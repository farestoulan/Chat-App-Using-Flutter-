import 'package:bloc/bloc.dart';
import 'package:chat_app/layout/cubit/social_cubit.dart';
import 'package:chat_app/layout/social_layout.dart';
import 'package:chat_app/modules/login_screen/social_login_screen.dart';
import 'package:chat_app/shared/bloc_observer/bloc_observer.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/network/local/cache_helper.dart';
import 'package:chat_app/shared/network/remot/dio_helper.dart';
import 'package:chat_app/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;

 // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
 // token = CacheHelper.getData(key: 'token');
   uId = CacheHelper.getData(key: 'uId');

  if(uId != null){
    widget =  SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }





  runApp(MyApp(
    isDark: isDark,
    startWidget:widget,
  ));
}

class MyApp extends StatelessWidget {
   bool? isDark;

  Widget? startWidget;

  MyApp({this.isDark, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark),

        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()

        ),
      ],
      child: BlocConsumer<AppCubit ,AppStates>(
        listener: (context , state) {},
        builder: (context ,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home:startWidget,
          );
        },

      ),

    );
  }
}


