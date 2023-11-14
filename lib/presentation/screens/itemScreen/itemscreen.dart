import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:stockd/data/models/item.dart';
import 'package:stockd/presentation/screens/component/ItemCard.dart';
import 'package:stockd/presentation/screens/component/myAppBar.dart';
import 'package:stockd/presentation/screens/component/shimmer.dart';
import 'package:stockd/presentation/screens/itemScreen/itemScreenShimmer.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';
import 'package:stockd/presentation/state/Item/cubit/item_cubit.dart';

import 'package:stockd/presentation/theming/colors.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

part 'itemscreen_assets.dart';

class ItemScreen extends StatefulWidget {
  final String itemId;
  const ItemScreen(this.itemId, {super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ItemCubit>(context).fetchItem(widget.itemId);
  }

  bool itemIsSaved = false;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final myColors = Theme.of(context).extension<MyColors>()!;
    return Scaffold(
      backgroundColor: myColors.primary2,
      appBar: const MyAppBar("Product"),
      body: SafeArea(child: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          if (state.status != EventStatus.loaded) {
            return const ItemScreenShimmer();
          }
          return ItemScreenContent(state.data!);
        },
      )),
    );
  }
}

class ItemScreenContent extends StatefulWidget {
  final Item data;
  const ItemScreenContent(this.data, {super.key});

  @override
  State<ItemScreenContent> createState() => _ItemScreenContentState();
}

class _ItemScreenContentState extends State<ItemScreenContent>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final myColors = Theme.of(context).extension<MyColors>()!;
    final itemState = BlocProvider.of<ItemCubit>(context).state;
    return FadeTransition(
      opacity: _animation,
      child: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text.rich(TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                                text: "₦",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 18)),
                            TextSpan(
                                text: " 7,999", style: TextStyle(fontSize: 30))
                          ])),
                      SizedBox(
                        height: 45,
                        child: ColoredBox(
                          color: Colors.black,
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        addToCartSnackBar(
                                            myColors: myColors,
                                            deviceWidth: deviceWidth,
                                            data: itemState.data!.colors!));
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: myColors.secondary,
                                      foregroundColor: myColors.primary,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: deviceWidth / 12),
                                      shape: const LinearBorder()),
                                  child: Row(
                                    children: [
                                      Badge.count(
                                        count: 4,
                                        child: const StaticAsset(
                                            "cart_active1", 25),
                                      ),
                                      // const Text("CHECKOUT")
                                    ],
                                  )),
                              VerticalLine(
                                  color: myColors.primary,
                                  length: 30,
                                  thickness: 0.4),
                              AddToCart(
                                data: itemState.data!,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyGenericSlider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                                color: storeName,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "Classy & Comfy",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                          const Text(
                            "Defacto Man Regular Fit Knitted T-Shirt - Black",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ColorShower(["#000000", "808080"]),
                              SavedIcon(widget.data.id, 30)
                            ],
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  final Item data;
  const AddToCart({
    super.key,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    print("data => $data");
    final deviceWidth = MediaQuery.of(context).size.width;
    final myColors = Theme.of(context).extension<MyColors>()!;
    return TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(addToCartSnackBar(
            myColors: myColors, deviceWidth: deviceWidth, data: data.colors!));
      },
      style: TextButton.styleFrom(
          backgroundColor: myColors.secondary,
          foregroundColor: myColors.primary,
          padding: EdgeInsets.symmetric(horizontal: deviceWidth / 10),
          shape: const LinearBorder()),
      child: const Row(
        children: [
          StaticAsset("cart_active", 25),
          ColoredBox(
            color: Colors.white,
            child: Xspacer(10),
          ),
          Text(
            "ADD +",
            style: TextStyle(fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}

class AddToCartSnackBarContent extends StatefulWidget {
  // final List<ExtractColors> colors;
  const AddToCartSnackBarContent({super.key});

  @override
  State<AddToCartSnackBarContent> createState() =>
      _AddToCartSnackBarContentState();
}

class _AddToCartSnackBarContentState extends State<AddToCartSnackBarContent> {
  late final List<ExtractColors> sizes;
  late List<List<ItemSize>> sizes1;

  // List<ItemSize> sizes1 = [...colorsList[0].sizes];

  @override
  void initState() {
    super.initState();
    // print("INITSTATE , sizes => $sizes");
  }

  @override
  void didChangeDependencies() {
    final a = BlocProvider.of<ItemCubit>(context).state.colorsList;
    sizes = [...?a];
    sizes1 = sizes[0].nestedSizes;

    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  void selectColor(index) {
    setState(() {
      sizes1 = sizes[index].nestedSizes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final myColors = Theme.of(context).extension<MyColors>()!;
    print("REBUILT");
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10),
          child: HorizontalLine(color: Colors.black, thickness: 2, length: 100),
        ),
        ColoredBox(
          color: myColors.primary2,
          child: SizedBox(
              height: deviceWidth / 8 * (sizes1.length),
              child: GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      // mainAxisSpacing: 1.4,
                      // crossAxisSpacing: 1.4,
                      // mainAxisExtent: deviceWidth / 8,
                      childAspectRatio: 8 / 1,
                      crossAxisCount: 1),
                  itemCount: sizes1.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: sizes1[index]
                          .map(
                            (e) => Expanded(
                                child: DecoratedBox(
                              // color: myColors.primary2,
                              decoration: BoxDecoration(
                                  color: myColors.primary2,
                                  border: Border(
                                    top: BorderSide(
                                        width: 1.4, color: myColors.secondary),
                                    right: BorderSide(
                                        width: 1.4, color: myColors.secondary),
                                    // bottom: BorderSide(
                                    //     width: index == sizes.length - 2 ? 1.4 : 0,
                                    //     color: myColors.secondary)
                                  )),
                              child: Text(
                                e.size,
                                style: const TextStyle(color: Colors.black),
                              ),
                            )),
                          )
                          .toList(),
                    );
                  })),
        ),
        ColoredBox(
          color: myColors.primary2,
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ListView.builder(
                  itemCount: sizes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TextButton(
                        onPressed: () {
                          setState(() {
                            // sizes.removeAt(0);
                            sizes1 = sizes[index].nestedSizes;
                          });
                          print(sizes);
                        },
                        child: Text(sizes[index].color));
                  })),
        )
      ],
    );
  }
}

SnackBar addToCartSnackBar(
    {required MyColors myColors,
    required double deviceWidth,
    required List data}) {
  // print(data);
  List<List<Widget>> sizes = [
    [
      ColoredBox(
        color: myColors.primary2,
        child: const Text(
          "XL",
          style: TextStyle(color: Colors.black),
        ),
      ),
      ColoredBox(
        color: myColors.primary2,
        child: const Text(
          "XL",
          style: TextStyle(color: Colors.black),
        ),
      ),
      ColoredBox(
        color: myColors.primary2,
        child: const Text(
          "XL",
          style: TextStyle(color: Colors.black),
        ),
      ),
    ],
    [
      ColoredBox(
        color: myColors.primary2,
        child: const Text(
          "XL",
          style: TextStyle(color: Colors.black),
        ),
      ),
      ColoredBox(
        color: myColors.primary2,
        child: const Text(
          "XL",
          style: TextStyle(color: Colors.black),
        ),
      ),
    ]
    // ColoredBox(
    //   color: myColors.primary2,
    //   child: const Text(
    //     "XL",
    //     style: TextStyle(color: Colors.black),
    //   ),
    // )
  ];
  return const SnackBar(
    duration: Duration(hours: 2),
    backgroundColor: Colors.transparent,
    elevation: 0,
    padding: EdgeInsets.all(0),
    content: AddToCartSnackBarContent(),
  );
}

// List<ItemSize> toSizes(List<String> sizeCountList) {
//   final sizes = sizeCountList.map((String e) {
//     final index = e.indexOf("-");
//     final size = e.substring(0, index);
//     final qty = int.parse(e.substring(index + 1));
//     return ItemSize(size, qty);
//   }).toList();
//   return sizes;
// }

// class ItemSize {
//   final String size;
//   final int quantity;
//   ItemSize(this.size, this.quantity);
// }

final colorsList = [
  ExtractColors.initiate("BLACK&GREY", ["S-2", "XL-5", "XXL-3", "L-1"]),
  ExtractColors.initiate("GREEN", ["M-3", "L-4", "XXL-1", "XL-3"])
];


//  GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: 4,
//           padding: const EdgeInsets.all(0),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               mainAxisSpacing: 1.3, mainAxisExtent: 50, crossAxisCount: 2),
//           itemBuilder: (context, index) {
//             return const Expanded(
//               child: ColoredBox(
//                 color: Colors.white,
//                 child: Text(
//                   "XL",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             );
//           }),

// GridView.count(
//                 // padding: const EdgeInsets.all(1.4),
//                 mainAxisSpacing: 1.4,
//                 padding: const EdgeInsets.symmetric(vertical: 1.4),
//                 crossAxisSpacing: 1.4,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 childAspectRatio: 4 / 1,
//                 children: sizes,
//               )
