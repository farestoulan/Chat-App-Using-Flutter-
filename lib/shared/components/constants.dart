
import 'package:chat_app/modules/login_screen/social_login_screen.dart';
import 'package:chat_app/shared/network/local/cache_helper.dart';

import 'components.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, SocialLoginScreen());
    }
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
String? uId = '';
