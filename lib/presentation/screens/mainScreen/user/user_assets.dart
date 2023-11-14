import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';

class UserPageSection extends StatelessWidget {
  final String name;
  const UserPageSection(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // focusColor: myColors.secondary,
      onTap: () {
        // print("object");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              // MyIcon("rightArrow", false)
              const StaticAsset("rightArrow", 20.0)
            ],
          ),
        ),
      ),
    );
  }
}
