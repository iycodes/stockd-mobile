part of "cartScreen.dart";

class _CartItem extends StatelessWidget {
  final int index;
  const _CartItem(this.index);

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SwipeActionCell(
      trailingActions: <SwipeAction>[
        SwipeAction(
            performsFirstActionWithFullSwipe: true,
            title: "DELETE",
            style: const TextStyle(fontSize: 15, color: Colors.white),
            onTap: (CompletionHandler handler) async {
              randomImages.removeAt(index);
            },
            color: Colors.redAccent)
      ],

      // confirmDismiss: ,
      key: Key("cartItem_$index"),
      child: IntrinsicHeight(
          child: Row(
        // crossAxisAlignment:
        //     CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CachedNetworkImage(
              // fit
              imageUrl: randomImages[index],
              placeholder: (context, url) => MyshimmerImage(deviceWidth / 2),
              cacheManager: CacheManager(Config("item_${randomImages[index]}",
                  stalePeriod: const Duration(days: 1))),
            ),
          ),
          VerticalLine(
              color: myColors.primary, length: double.infinity, thickness: 0.8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 10, left: 8, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {},
                        child: const StaticAsset("cancel_black", 25)),
                  ),
                  const Yspacer(10),
                  Text(
                    "nice fitted t-shirt \nN7999".toUpperCase(),
                    style: TextStyle(
                        color: myColors.secondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                  const Yspacer(20),
                  Text("EU XS / US XS | BLACK".toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: myColors.secondary2.withOpacity(0.8))),
                  const Spacer(),
                  SizedBox(
                    height: 35,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: myColors.secondary,
                            width: 1.5,
                          )),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                child: StaticAsset("subtract_black", 18),
                              ),
                            ),
                            VerticalLine(
                                color: myColors.secondary2.withOpacity(0.5),
                                length: double.infinity,
                                thickness: 1.3),
                            const Xspacer(12),
                            const Text(
                              "1",
                              style: TextStyle(fontSize: 15, color: black3),
                            ),
                            const Xspacer(12),
                            VerticalLine(
                                color: myColors.secondary2.withOpacity(0.5),
                                length: double.infinity,
                                thickness: 1.3),
                            InkWell(
                                onTap: () {},
                                child: InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    child: Opacity(
                                      opacity: 1,
                                      child: StaticAsset("add_black", 18),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
