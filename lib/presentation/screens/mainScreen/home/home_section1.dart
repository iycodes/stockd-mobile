import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockd/domain/api_repo.dart';
import 'package:stockd/presentation/screens/component/HomeTabBar1.dart';
import 'package:stockd/presentation/screens/component/myShimmerPage.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/state/cubit/hometab1_cubit.dart';
import 'package:stockd/presentation/state/user/cubit/user_cubit.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class HomePageSection1 extends StatefulWidget {
  const HomePageSection1({super.key});

  @override
  State<HomePageSection1> createState() => _HomePageSection1State();
}

class _HomePageSection1State extends State<HomePageSection1> {
  @override
  void initState() {
    super.initState();
  }

  final _apiRepo = ApiRepo();

  @override
  void didChangeDependencies() {
    print("initiated");
    final homeTab1Bloc = BlocProvider.of<Hometab1Cubit>(context);
    final userState = BlocProvider.of<UserCubit>(context).state;
    if (homeTab1Bloc.state.status != HomeTabStatus.loaded) {
      homeTab1Bloc.onFetchHomeTabItems(userState.loggedInUser!.savedItems);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // dynamic get fetchTabItems =>
  //     BlocProvider.of<Hometab1Cubit>(context).onFetchHomeTabItems();

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return BlocBuilder<Hometab1Cubit, Hometab1State>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          // print(state.data);
          if (state.status == HomeTabStatus.loaded) {
            return ColoredBox(
              color: myColors.primary2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // AppBar(
                  //   toolbarHeight: 0,
                  //   backgroundColor: myColors.primary2,
                  //   shadowColor: Colors.transparent,
                  //   surfaceTintColor: Colors.transparent,
                  // ),
                  const Yspacer(60),
                  // const MyCarouselSlider(),
                  const Yspacer(5),
                  // HomeTabBar1(tabNames),
                  HomeTabBar1(tabNames, myColors)
                ],
              ),
            );
          } else {
            return MyShimmerPage();
          }
        });
  }
}
