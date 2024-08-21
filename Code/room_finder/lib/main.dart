import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/bottom_bar.dart';
import 'package:room_finder/presentation/screens/account_page.dart';
import 'package:room_finder/presentation/screens/chat_page.dart';
import 'package:room_finder/presentation/screens/home_page.dart';
import 'package:room_finder/presentation/screens/saved_ads_page.dart';
import 'package:room_finder/presentation/screens/onboarding_page.dart';
import 'package:room_finder/style/theme.dart';
import 'package:room_finder/util/shared_preferences.dart';

// Variable to store whether the on boarding screen has been shown
bool _isShown = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Check if the user has seen the on boarding screen before
  // WARNING: if this is set to false, means that the user cannot be an existing user => isHost must be false
  _isShown = await OnBoardingScreenPreferences.getWasShown();
  // Set the device orientation to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const ProviderScope(
            child: MyApp(),
          )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp(
          title: 'RoomFinder',
          theme: GlobalThemeData.lightTheme,
          darkTheme: GlobalThemeData.darkTheme,
          themeMode: ThemeMode.system,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // TODO: handle this value with the user's role, for now it is hardcoded
  bool isHost = false;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget bodyTemplate({required Widget body}) {
      return Center(
        child: body,
      );
    }

    if (!_isShown) {
      _isShown = true;
      return const OnBoardingPage();
    }

    return Scaffold(
      body: isHost
          ? <Widget>[
              bodyTemplate(body: const SafeArea(child: HostHomePage())),
              bodyTemplate(body: const SafeArea(child: HostChatPage())),
              bodyTemplate(body: const AccountPage()),
            ][currentPageIndex]
          : <Widget>[
              bodyTemplate(body: const SafeArea(child: StudentHomePage())),
              bodyTemplate(body: const SafeArea(child: SavedAdsPage())),
              bodyTemplate(body: const SafeArea(child: StudentChatPage())),
              bodyTemplate(body: const AccountPage()),
            ][currentPageIndex],
      bottomNavigationBar: isHost
          ? HostNavigationBar(
              currentPageIndex: currentPageIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
            )
          : StudentNavigationBar(
              currentPageIndex: currentPageIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
            ),
    );
  }
}
