part of "login.dart";

Image logo(w) {
  return Image.asset(
    "assets/icons/stockd.png",
    width: w,
  );
}

class _EmailField extends StatelessWidget {
  final Function updateEmail;
  const _EmailField(this.updateEmail);
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return TextField(
      onChanged: (value) {
        updateEmail(value);
        // print(value);
      },
      controller: TextEditingController(text: "iyanufanoro@gmail.com"),
      cursorColor: Colors.grey,
      decoration: InputDecoration(
          // border: OutlineInputBorder(
          //     borderSide: BorderSide(
          //         color: myColors.secondary2.withOpacity(0.1), width: 3)),
          filled: true,
          fillColor: const Color(0xffffffff),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: myColors.secondary2.withOpacity(0.1), width: 3)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: myColors.secondary2.withOpacity(0.7), width: 3)),
          prefixIcon: isDarkMode(context, emailIconWhite, emailIcon),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 20, maxWidth: 40, minWidth: 40)),
    );
  }
}

class _PswdField extends StatelessWidget {
  Function updatePswd;
  _PswdField(this.updatePswd);
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    return ValueListenableBuilder<bool>(
        valueListenable: showPassword,
        builder: (context, bool value, child) {
          return TextField(
            obscureText: value,
            cursorColor: Colors.grey,
            onChanged: (value) {
              updatePswd(value);
              // print(value);
            },
            controller: TextEditingController(text: ".1yanu0luwA"),
            decoration: InputDecoration(
                // border:
                //     OutlineInputBorder(borderSide: BorderSide(color: bc, width: 3)),
                filled: true,
                fillColor: const Color(0xffffffff),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: myColors.secondary2.withOpacity(0.1), width: 3)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: myColors.secondary2.withOpacity(0.7), width: 3)),
                prefixIcon:
                    isDarkMode(context, passwordIconWhite, passwordIcon),
                suffixIcon: GestureDetector(
                  onTap: () {
                    showHide();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: StaticAsset("hidePassword_black", 20),
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(maxWidth: 25),
                prefixIconConstraints: const BoxConstraints(
                    maxHeight: 25, maxWidth: 40, minWidth: 40)),
          );
        });
  }

  void showHide() => showPassword.value = !showPassword.value;
}

Image isDarkMode(context, a, b) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return a;
  } else {
    return b;
  }
}

const emailIcon = Image(
  width: 32,
  height: 32,
  image: Svg("assets/icons/@.svg"),
);

const emailIconWhite = Image(image: Svg("assets/icons/@_white.svg"));
final passwordIcon = Image.asset("assets/icons/password-dark.png");
final passwordIconWhite = Image.asset("assets/icons/password.png");

class Underlinedtext extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color lineColor;

  const Underlinedtext(
      {required this.text,
      required this.textColor,
      required this.lineColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.7, color: lineColor))),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: textColor ?? const Color(0xff000000)),
        ));
  }
}

Padding loginIconWhite = Padding(
    padding: const EdgeInsets.only(
      left: 10,
    ),
    child: Image.asset(
      "assets/icons/login_white.png",
      width: 20,
    ));
SizedBox myspacer(double h) {
  return SizedBox(
    height: h,
  );
}
