import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:stockd/common/models/api_response.dart';
import 'package:stockd/data/models/user/user.dart';
import 'package:stockd/domain/api_repo.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

import 'package:stockd/presentation/state/user/cubit/user_cubit.dart';

part "login_assets.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisible = false;

  Map<String, String?> loginData = {
    "email": "iyanufanoro@gmail.com",
    "pswd": ".1yanu0luwA"
  };
  Map<String, String?> getLoginData() => loginData;
  void updateEmail(String email) {
    setState(() {
      loginData["email"] = email;
    });
  }

  void updatePswd(String pswd) {
    setState(() {
      loginData["pswd"] = pswd;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    final devicewidth = MediaQuery.of(context).size.width.toInt();
    final deviceHeight = MediaQuery.of(context).size.height.toInt();
    final pad = devicewidth * 0.07;

    return Scaffold(
      backgroundColor: myColors.primary2,
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   toolbarHeight: 0,
      // ),
      body: Align(
        child: SizedBox(
          height: double.infinity,
          width: devicewidth.toDouble() * 0.8,
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Yspacer(30),
                  LottieBuilder.asset(
                    "assets/icons/login.json",
                    width: 250,
                    // height: 250,
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    "Sign in",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
                  ),
                  // Yspacer(),
                  const Text(
                    "Welcome - Be sure to enjoy exclusive deals,offers,discounts and rewards",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "*Email",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        _EmailField(updateEmail),
                      ],
                    ),
                  ),
                  const Yspacer(15),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "*Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        _PswdField(updatePswd)
                      ],
                    ),
                  ),
                  const Yspacer(15),
                  Underlinedtext(
                      textColor: myColors.secondary2,
                      text: "Forgot your password?",
                      lineColor: myColors.secondary.withOpacity(0.8)),
                  const Yspacer(25),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: _LoginBtn(getLoginData),
                  ),
                  const Spacer(),
                  Underlinedtext(
                    textColor: myColors.secondary2,
                    text: "back",
                    lineColor: myColors.secondary.withOpacity(0.8),
                  ),
                  const Yspacer(60)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginBtn extends StatelessWidget {
  Function getLoginData;

  _LoginBtn(this.getLoginData);
  final _apiRepo = ApiRepo();
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) => previous != current,
        builder: (BuildContext context, UserState state) {
          return OutlinedButton(
            onPressed: () async {
              if (state.status == userStatus.loggingIn) {
                return;
              }
              BlocProvider.of<UserCubit>(context).loginClicked();
              final data = getLoginData();
              // print(data)
              final resp = await _apiRepo
                  .login(UserLoginModel(data["email"]!, data["pswd"]!));
              if (resp.status == ApiReqStatus.success) {
                print("logged in user data => ${resp.data}");
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(message("success", "#4BB543"));
                  BlocProvider.of<UserCubit>(context)
                      .loginSuccess(LoggedInUserModel.fromJson(resp.data));
                  await Future.delayed(const Duration(seconds: 2));
                  // print(state.loggedInUser);
                  if (context.mounted) {
                    context.beamToNamed("/");
                  }
                }
              } else {
                if (context.mounted) {
                  BlocProvider.of<UserCubit>(context).initial();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(message("Error Logging In", "#FC100D"));
                }
              }
            },
            style: OutlinedButton.styleFrom(
                // minimumSize: Size.fromHeight(0),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                foregroundColor: myColors.primary,
                backgroundColor: myColors.secondary,
                side: const BorderSide()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (state.status == userStatus.loggingIn) ||
                      (state.status == userStatus.loggedIn)
                  ? [
                      CircularProgressIndicator(
                        color: myColors.primary2,
                      )
                    ]
                  : [
                      const Text(
                        "LOGIN",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      loginIconWhite
                    ],
            ),
          );
        });
  }
}

SnackBar message(String txt, String color) {
  return SnackBar(
    content: Text(txt),
    backgroundColor: HexColor(color).withOpacity(0.6),
  );
}
