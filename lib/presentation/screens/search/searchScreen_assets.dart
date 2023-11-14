part of "searchScreen.dart";

final backArrow = Image.asset("assets/icons/backArrow.png");
final starIcon = Padding(
    padding: const EdgeInsets.only(right: 15),
    child: Image.asset(
      "assets/icons/star.png",
      height: 25,
    ));
final rightArrow = Image.asset(
  "assets/icons/rightArrow.png",
  height: 22,
);

class _SearchScreenSearchBar extends StatelessWidget {
  const _SearchScreenSearchBar();

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return TextField(
      style: const TextStyle(fontSize: 20),
      // autofocus: true,
      decoration: const InputDecoration(
          hintText: "Search Products", hintStyle: TextStyle(fontSize: 18)
          // contentPadding: EdgeInsets.only(top: 20, bottom: 20)
          ),
      cursorColor: myColors.secondary2,

      // cursorHeight: ,
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Beamer.of(context).beamBack();
        },
        style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
        child: const StaticAsset("backArrow_black", 23));
  }
}

TextButton clearBtn(Color? color) {
  return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          minimumSize: const Size(30, double.infinity)),
      child: Text(
        "Clear",
        style: TextStyle(color: color!.withOpacity(0.8), fontSize: 17),
      ));
}

Padding prevSearched() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(children: [
      starIcon,
      Text(
        "flannel",
        style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w800),
      ),
      const Spacer(),
      rightArrow
    ]),
  );
}
