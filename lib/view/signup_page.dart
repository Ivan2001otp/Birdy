import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_event.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_state.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_status.dart';
import 'package:user_chat_app/view/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late SignUpBloc _signUpBloc;
  TextEditingController? _usernameController = TextEditingController();
  TextEditingController? _usermailController = TextEditingController();
  TextEditingController? _passController = TextEditingController();
  bool isProtected = true;
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _signUpBloc.close();

    _usermailController?.clear();
    _usernameController?.clear();
    _passController?.clear();
  }

  void displayErrorToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failed login"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void displaySuccessToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Success login"),
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
        key: _signUpFormKey,
        child: _signUpForm(context),
      ),
    );
  }

  Widget _signUpForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.sp),
      child: Column(
        children: [
          Text(
            'Sign Up Page',
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          _usernameField(),
          SizedBox(
            height: 10.h,
          ),
          _emailField(),
          SizedBox(
            height: 10.h,
          ),
          _passwordField(),
          SizedBox(
            height: 20.h,
          ),
          _signUpButton(context),
        ],
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status is LoginFailureStatus) {
          displayErrorToast(context);
        } else if (state.status is LoginSuccessStatus) {
          displaySuccessToast(context);
        }
      },
      builder: (context, state) {
        print('the state is ${state.status.toString()}');

        if (state.status is LoginLoadingStatus) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
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
          onPressed: () {
            //hides the soft keyboard.
            FocusManager.instance.primaryFocus?.unfocus();

            if (_usermailController!.text.isEmpty ||
                _usernameController!.text.isEmpty ||
                _passController!.text.isEmpty) {
              context.read<SignUpBloc>().add(onSignUpBtnClicked());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }),
              );
            } else {
              displayErrorToast(context);
            }
          },
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.black87),
        validator: (password) {
          print('log-validatin password $password');
        },
        onChanged: (password) {
          context.read<SignUpBloc>().add(onUserPasswordChange(password));
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Colors.black87),
        validator: (email) {
          print("validating $email");
        },
        onChanged: (email) {
          print("log-email changed $email");
          context.read<SignUpBloc>().add(onUserEmailChange(email));
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'abc@gmail.com',
        ),
      );
    });
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.name,
        style: const TextStyle(color: Colors.black87),
        validator: (userName) {
          print("log-validating $userName");
        },
        onChanged: (userName) {
          print("log-changed $userName");
          context.read<SignUpBloc>().add(onUserNameChange(userName));
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'UserName',
        ),
      );
    });
  }
}
