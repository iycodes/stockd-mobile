import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:stockd/data/models/cart/cart.dart';
import 'package:stockd/presentation/screens/component/myAppBar.dart';
import 'package:stockd/presentation/screens/component/shimmer.dart';
import 'package:stockd/presentation/screens/itemScreen/itemscreen.dart';
import 'package:stockd/presentation/screens/mainScreen/cart/cartScreenShimmer.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';
import 'package:stockd/presentation/state/cart/bloc/cart_bloc.dart';
import 'package:stockd/presentation/theming/colors.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

part 'cartScreen_assets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  late final TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
  }

  late final List _keys =
      List.generate(randomItems.length, (index) => GlobalKey());
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final Cart userCart;
    return Scaffold(
        appBar: const MyAppBar("Cart"),
        backgroundColor: myColors.primary2,
        body: SafeArea(
          child: SizedBox(
              height: deviceHeight,
              child: Column(
                children: [
                  Column(
                    children: [
                      const HorizontalLine(
                          color: Colors.white,
                          thickness: 1,
                          length: double.infinity),
                      SizedBox(
                        height: 30,
                        child: TabBar(
                          isScrollable: false,
                          indicatorColor: Colors.transparent,
                          unselectedLabelColor:
                              myColors.secondary.withOpacity(0.8),
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700),
                          labelColor: myColors.secondary,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w800),
                          indicatorWeight: 0.5,
                          labelPadding: const EdgeInsets.all(0),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: const <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("SHOPPING BAG"),
                                ),
                                StaticAsset("cart", 13)
                              ],
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: Colors.white, width: 2))),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("SAVED"),
                                  ),
                                  StaticAsset("saved", 13)
                                ],
                              ),
                            )
                          ],
                          controller: _tabController,
                        ),
                      ),
                      const HorizontalLine(
                          color: Colors.white,
                          thickness: 1,
                          length: double.infinity)
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          BlocBuilder<CartBloc, CartState>(
                              bloc: context.read<CartBloc>(),
                              builder: (context, state) {
                                if ((state.status == CartStatus.initial) ||
                                    (state.status == CartStatus.loading)) {
                                  return CartScreenShimmer();
                                }
                                return Stack(
                                  children: [
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: randomImages.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Column(
                                            children: [
                                              _CartItem(index),
                                              HorizontalLine(
                                                  color: myColors.primary,
                                                  thickness: 1.5,
                                                  length: deviceWidth)
                                            ],
                                          );
                                        }),
                                    Positioned(
                                      // alignment: Alignment.bottomLeft,
                                      bottom: 0,
                                      child: Column(
                                        children: [
                                          HorizontalLine(
                                              color: myColors.primary,
                                              thickness: 1.5,
                                              length: deviceWidth),
                                          SizedBox(
                                            height: 45,
                                            width: deviceWidth,
                                            child: IntrinsicHeight(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                      child: InkWell(
                                                          child: ColoredBox(
                                                    color: myColors.primary2,
                                                    child: const Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text("CONTINUE"),
                                                    ),
                                                  ))),
                                                  Expanded(
                                                      child: InkWell(
                                                          child: ColoredBox(
                                                              color: myColors
                                                                  .secondary,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            5),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "TOTAL",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: myColors.primary,
                                                                            fontSize: 14)),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Text(
                                                                            "N27650",
                                                                            style:
                                                                                TextStyle(color: myColors.primary, fontSize: 13)),
                                                                        Text(
                                                                          "VAT NOT INCLUDED",
                                                                          style: TextStyle(
                                                                              color: myColors.primary,
                                                                              fontSize: 8),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ))))
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                          GridView.builder(
                              padding: const EdgeInsets.only(top: 0),
                              itemCount: randomItems.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 10,
                                      mainAxisExtent:
                                          (deviceWidth / 2) * 4 / 3),
                              itemBuilder: (context, index) {
                                final width = (deviceWidth - 15) / 2;
                                return CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: deviceWidth / 2,
                                    placeholder: (context, index) {
                                      return MyshimmerImage(width);
                                    },
                                    imageUrl: randomItems[index]);
                              })
                        ]),
                  )
                ],
              )),
        ));
  }
}

final testData = ["a", "b", "a", "a", "a", "l"];

class name extends StatelessWidget {
  const name({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
