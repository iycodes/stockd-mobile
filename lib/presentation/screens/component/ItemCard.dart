import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:stockd/presentation/screens/component/shimmer.dart';
import 'package:stockd/presentation/screens/login/login.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';
import 'package:stockd/presentation/state/user/cubit/user_cubit.dart';
import 'package:stockd/presentation/theming/colors.dart';

class ItemCard extends StatelessWidget {
  ItemCard(
      {required this.itemId,
      required this.imgSrc,
      required this.title,
      required this.price,
      required this.discount,
      required this.width,
      super.key});
  final String itemId;
  final String imgSrc;
  final String title;
  final int price;
  final String discount;

  late final double width;
  final StreamController<bool> myStream = StreamController();

  late final Widget img = CachedNetworkImage(
    imageUrl: imgSrc,
    placeholder: (context, url) => MyshimmerImage(
      width,
      radius: 8,
    ),
    cacheManager: CacheManager(
        Config("HomeTabImages", stalePeriod: const Duration(days: 1))),
  );
  @override
  Widget build(BuildContext context) {
    // ctx = context;
    // final deviedWidth = MediaQuery.of(context).size.width;
    // final myColors = Theme.of(context).extension<MyColors>()!;

    return true
        ? GestureDetector(
            onTap: () {
              context.beamToNamed("/item/$itemId");
              // print(itemId);
            },
            child: SizedBox(
              width: width,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    OneSidedBoxShadow(width),
                    SizedBox(
                      width: width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: [
                            img,
                            const Positioned(
                                top: 4, left: 4, child: DiscountIcon("9%")),
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: SavedIcon(itemId, 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Yspacer(5),
                SizedBox(
                    width: width,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: width * 0.6,
                          child: Text(
                            title,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                            style: TextStyle(
                                // backgroundColor: Colors.green,

                                fontWeight: FontWeight.w900,
                                // height: 0.5,
                                height: 1.2,
                                fontSize: width / 10),
                          ),
                        ),
                        Text(
                          "₦$price",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: width / 9.5,
                              // fontSize: 1,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ))
              ]),
            ),
          )
        : const MyShimmerItem();
  }
}

// class SavedIcon extends StatefulWidget {
//   final bool isSaved;
//   final String itemId;
//   const SavedIcon(this.isSaved, this.itemId, {super.key});

//   @override
//   State<SavedIcon> createState() => _SavedIconState();
// }

class SavedIcon extends StatelessWidget {
  final String itemId;
  final double iconSize;
  const SavedIcon(this.itemId, this.iconSize, {super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final isSaved = state.loggedInUser!.savedItems.contains(itemId);
          return InkWell(
            // splashRadius: 7,
            onTap: () async {
              isSaved;
              if (isSaved) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(message("Loading...", "#000000"));
                }
                final res = await BlocProvider.of<UserCubit>(context)
                    .unSaveItem([itemId], state.loggedInUser!.email);

                if (context.mounted) {
                  if (state.updatedText == "item updated") {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(message("Item unsaved", "#000000"));
                  }
                }
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(message("Loading...", "#000000"));
                final res = await BlocProvider.of<UserCubit>(context)
                    .saveItem([itemId], state.loggedInUser!.email);
                if (context.mounted && res == "saved") {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(message("Item Saved", "#000000"));
                }
              }
            },
            child:
                StaticAsset(isSaved ? "saved_active_black" : "saved", iconSize),
          );
        });
  }
}

class DiscountIcon extends StatelessWidget {
  final String val;
  const DiscountIcon(this.val, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: ColoredBox(
        color: discountRed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 7),
          child: Text(
            "-$val",
            style: const TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class OneSidedBoxShadow extends StatelessWidget {
  final double width;
  const OneSidedBoxShadow(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                spreadRadius: 7,
                blurRadius: 25,
                offset: Offset(0, 0))
          ],
        ),
        child: SizedBox(
          width: width - 40,
          // child: Text("here"),
        ));
  }
}
