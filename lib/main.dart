import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockd/domain/api_repo.dart';
import 'package:stockd/presentation/screens/entry/entry.dart';
import 'package:stockd/presentation/screens/itemScreen/itemscreen.dart';

import 'package:stockd/presentation/screens/login/login.dart';
import 'package:stockd/presentation/screens/mainScreen/cart/cartScreen.dart';
import 'package:stockd/presentation/screens/mainScreen/inheritedWidget.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen.dart';
import 'package:stockd/presentation/screens/search/searchScreen.dart';
import 'package:stockd/presentation/screens/signup/signup.dart';
import 'package:stockd/presentation/state/Item/cubit/item_cubit.dart';
import 'package:stockd/presentation/state/cart/bloc/cart_bloc.dart';
import 'package:stockd/presentation/state/cubit/hometab1_cubit.dart';
import 'package:stockd/presentation/state/user/cubit/user_cubit.dart';
import 'package:stockd/presentation/theming/colors.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  bool isDeviceTheme = false;
  bool isLightTheme = true;
  bool isAuth = false;
  void toggleTheme() {
    // debugPrint(Theme.of(context).brightness.toString());
    setState(() {
      debugPrint("lol");
      isDeviceTheme = false;
      isLightTheme = !isLightTheme;
    });
  }

  void setAuth() {
    setState(() {
      isAuth = true;
    });
  }

  late BeamerDelegate routerDelegate;
  _MyAppState() {
    routerDelegate = BeamerDelegate(
      // initialPath: isAuth ? "/home" : "/entry",

      initialPath: "/login",
      locationBuilder: RoutesLocationBuilder(
        routes: {
          // Return either Widgets or BeamPages if more customization is needed
          // '/home': (context, state, data) => const Home(),
          // "/": (context, state, data) {
          //   return const Entry();
          // },
          "/": (context, state, data) {
            return const InheritedWrapperMainScreen(
              key: ValueKey("mainscreen"),
              child: MainScreen(),
            );
          },
          "/searchScreen": (context, state, data) => const BeamPage(
                // type: BeamPageType.slideTransition,
                // popToNamed: "/mainscreen",
                key: ValueKey("searchScreen"),
                child: SearchScreen(),
              ),
          "/entry": (context, state, data) => const Entry(
              // changeTheme: toggleTheme,
              // slideTransition: useDeviceTheme,````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
              // isLightTheme: isLightTheme
              ),
          "/cart": (cnotext, state, data) {
            return const BeamPage(
              key: ValueKey("cart"),
              child: CartPage(),
              // type: BeamPageType.cupertino,
            );
          },
          "/item/:id": (context, state, data) {
            final id = state.pathParameters["id"];
            return BeamPage(
              key: ValueKey("item-$id"),
              child: ItemScreen(id!),
              popToNamed: "/",
              // type: BeamPageType.cupertino,
            );
          },
          "/item/:id/searchScreen": (context, state, data) {
            return const BeamPage(
                key: ValueKey("searchScreen"),
                child: SearchScreen(),
                type: BeamPageType.slideTransition);
          },
          "/item/:id/gallery": (context, state, data) {
            final id = state.pathParameters["id"];
            return BeamPage(
                key: ValueKey("item-$id-gallery"),
                child: PhotoGallery(data!),
                type: BeamPageType.slideTransition);
          },
          '/signup': (context, state, data) => const Signup(),
          // '/verify': (context, state, data) => VerifyEmailPage(),
          "/login": (context, state, data) => const Login(),
        },
      ),
    );
  }

  void useDeviceTheme() {
    setState(() {
      debugPrint(isDeviceTheme.toString());
      isDeviceTheme = !isDeviceTheme;
    });
  }

  // final routerDelegate = BeamerDelegate(
  //   initialPath: isAuth ? "/home" : "/signup",
  //   locationBuilder: RoutesLocationBuilder(
  //     routes: {
  //       // Return either Widgets or BeamPages if more customization is needed
  //       '/home': (context, state, data) => HomePage(),
  //       '/signup': (context, state, data) => SignupPage(),
  //       '/verify': (context, state, data) => VerifyEmailPage(),
  //       "/login": (context, state, data) => LoginPage()
  //     },
  //   ),
  // );
  final ApiRepo myRepo = ApiRepo();
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>();
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor:
          isLightTheme ? const Color(0xffffffff) : const Color(0xff000000),
      systemNavigationBarIconBrightness:
          isLightTheme ? Brightness.dark : Brightness.light,
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: MultiBlocProvider(
            providers: [
              // BlocProvider<ItemListBloc>(create: (context) => ItemListBloc()),
              BlocProvider<ItemCubit>(create: (context) => ItemCubit()),
              BlocProvider<CartBloc>(create: (context) => CartBloc()),
              BlocProvider<UserCubit>(create: (context) => UserCubit()),
              BlocProvider<Hometab1Cubit>(create: (context) => Hometab1Cubit())
            ],
            child: MaterialApp.router(
                title: 'idanSocial',
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light().copyWith(
                  useMaterial3: true,
                  textTheme: Typography().white.apply(
                      fontFamily: "mukta", bodyColor: const Color(0xff222222)),
                  extensions: <ThemeExtension<dynamic>>[
                    const MyColors(
                        primary: white,
                        primary2: offwhite,
                        secondary: black,
                        secondary2: black2,
                        ash: Color(0XFFF5F2F2),
                        accentColor1: Color(0xff164D6C),
                        textColor: Color(0xff000000),
                        lightGrey: Color.fromRGBO(83, 100, 110, 0.5)),
                  ],
                ),
                darkTheme: ThemeData.dark().copyWith(
                  // brightness: Brightness.dark,
                  useMaterial3: true,
                  textTheme: Typography().black.apply(
                      fontFamily: "mukta", bodyColor: const Color(0xffffffff)),
                  extensions: <ThemeExtension<dynamic>>[
                    const MyColors(
                        primary: white,
                        primary2: black2,
                        secondary: black,
                        secondary2: black2,
                        accentColor1: Color(0xffffffff),
                        ash: Color(0xff0a0d0d),
                        textColor: Color(0xffF9F9F9),
                        lightGrey: Color.fromRGBO(83, 100, 110, 0.5)),
                  ],
                ),
                // themeMode: isDeviceTheme
                //     ? ThemeMode.system
                //     : (isLightTheme ? ThemeMode.light : ThemeMode.dark),
                themeMode: ThemeMode.system,
                routeInformationParser: BeamerParser(),
                routerDelegate: routerDelegate,
                backButtonDispatcher: BeamerBackButtonDispatcher(
                  delegate: routerDelegate,
                ))));
  }
}
