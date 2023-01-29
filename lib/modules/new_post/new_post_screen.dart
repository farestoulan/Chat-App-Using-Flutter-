import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/cubit/social_cubit.dart';
import '../../home/cubit/social_states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icone_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                defaultTextButton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      var now = DateTime.now();

                      if (SocialCubit.get(context).postImage == null) {
                        SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                        );
                      } else {
                        SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                        );
                      }
                    }
                  },
                  text: 'Post',
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}',
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          '${SocialCubit.get(context).userModel!.name}',
                          style: const TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: textController,
                    validator: (value) {
                      if (value == null) {
                        //   return 'please enter your phone number';
                        // showToast(
                        //     msg: 'PLZ creat post first',
                        //     state: ToastStates.ERROR);
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20.0,
                  // ),
                  const Spacer(),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              4.0,
                            ),
                            image: DecorationImage(
                              image: FileImage(
                                  SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'add photo',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            '# tags',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
