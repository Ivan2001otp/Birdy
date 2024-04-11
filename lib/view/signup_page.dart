import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_state.dart';
import 'package:user_chat_app/bloc/sign_up/sign_up_status.dart';
import 'package:user_chat_app/widgets/resuable/ca_button.dart';
import '../widgets/resuable/ca_textfield.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    // _signUpBloc = context.watch<SignUpBloc>();
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

  void displayErrorToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failed login"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void displaySuccessToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failed login"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.sp,
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(builder: (context, state) {
        //
        if (state is LoginInitialStatus) {
          return Padding(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                //username

                Text(
                  "Sign Up Page",
                  style: TextStyle(color: Colors.black, fontSize: 40.sp),
                ),

                SizedBox(
                  height: 12.h,
                ),
                CA_TextField(
                  _usernameController!,
                  TextInputType.text,
                  isObscure: false,
                  initialValueCustom: null,
                  CA_hintText: 'Your Username..',
                  suffixColor: Colors.black12,
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: Icon(Icons.verified_user)),
                  onTapField: () {},
                  onSaveField: (value) {},
                  onChangeField: (value) {
                    return "";
                  },
                  onEditingDone: () {},
                ),
                SizedBox(
                  height: 8.h,
                ),
                CA_TextField(_usermailController, TextInputType.emailAddress,
                    initialValueCustom: null,
                    suffixColor: Colors.black12,
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(Icons.email_outlined)),
                    CA_hintText: 'Your email...',
                    onSaveField: (val) {},
                    onEditingDone: () {},
                    onChangeField: (val) {},
                    onTapField: () {}),
                SizedBox(
                  height: 8.h,
                ),

                CA_TextField(
                  _usermailController,
                  TextInputType.emailAddress,
                  initialValueCustom: null,
                  isObscure: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isProtected = !isProtected;
                      });
                    },
                    icon: const Icon(
                      Icons.security,
                    ),
                  ),
                  suffixColor:
                      isProtected == true ? Colors.black26 : Colors.red,
                  CA_hintText: 'Your Password...',
                  onSaveField: (val) {},
                  onEditingDone: () {},
                  onChangeField: (val) {},
                  onTapField: () {},
                ),

                SizedBox(
                  height: 12.h,
                ),
                CA_Button(
                    btnText: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                    onpressed: () {
                      print("pressed on sign up");
                    })
              ],
            ),
          );
        }
        if (state is LoginLoadingStatus) {
          return const CircularProgressIndicator(
            color: Colors.green,
          );
        }
        return const Center(
          child: Text('nothing'),
        );
      }, listener: (context, state) {
        //navigation or toast.
        if (state is LoginFailureStatus) {
          displayErrorToast();
        } else if (state is LoginSuccessStatus) {
          displaySuccessToast();
        }
      }),
    );
  }
}
