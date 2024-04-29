import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_chat_app/bloc/sign_in/sign_in_event.dart';
import 'package:user_chat_app/bloc/sign_in/sign_in_status.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_event.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_state.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_status.dart';
import 'package:user_chat_app/view/home.dart';

import '../bloc/sign_in/sign_in_bloc.dart';
import '../bloc/sign_in/sign_in_state.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late SignUpBloc _signUpBloc;
  TextEditingController? _usermailController = TextEditingController();
  TextEditingController? _passController = TextEditingController();
  bool isProtected = true;
  final _signInFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const HomePage();
          }),
        );
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _signUpBloc.close();

    _usermailController?.clear();
    _passController?.clear();
  }

  void displayErrorToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failed to Sign In"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void displaySuccessToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Success Sign In"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.sp,
      ),
      body: Form(
        key: _signInFormKey,
        child: _signUpForm(context),
      ),
    );
  }

  Widget _signUpForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Column(
        children: [
          Text(
            'Sign In Page',
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          _emailField(),
          SizedBox(
            height: 10.h,
          ),
          _passwordField(),
          SizedBox(
            height: 4.h,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.login,
                color: Colors.black,
              ),
              label: Text('Sign Up Here..'),
            ),
          ]),
          _signUpButton(context),
        ],
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) async {
        if (state.status is SignInFailureStatus) {
          displayErrorToast(context);
        } else if (state.status is SignInSuccessStatus) {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return const HomePage();
            }),
          );
          displaySuccessToast(context);
        }
      },
      builder: (context, state) {
        print('the state is ${state.status.toString()}');

        if (state.status is SignInLoadingStatus) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          onPressed: () async {
            //hides the soft keyboard.
            FocusManager.instance.primaryFocus?.unfocus();

            if (_usermailController!.text.isEmpty ||
                _passController!.text.isEmpty) {
              context.read<SignInBloc>().add(OnSignInBtnClicked());
            } else {
              displayErrorToast(context);
            }
          },
          child: Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.black87),
        validator: (password) {
          print('log-validation password $password');
        },
        onChanged: (password) {
          debugPrint('Password is $password');
          context.read<SignInBloc>().add(OnUserPasswordChanged(password));
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Colors.black87),
        validator: (email) {
          print("validating $email");
        },
        onChanged: (email) {
          print("log-email changed $email");
          context.read<SignInBloc>().add(OnUseremailChanged(email));
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'abc@gmail.com',
        ),
      );
    });
  }
}
