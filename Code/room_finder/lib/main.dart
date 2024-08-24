import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/firebase_options.dart';
import 'package:room_finder/presentation/components/bottom_bar.dart';
import 'package:room_finder/presentation/screens/account_page.dart';
import 'package:room_finder/presentation/screens/chat_page.dart';
import 'package:room_finder/presentation/screens/home_page.dart';
import 'package:room_finder/presentation/screens/login_page.dart';
import 'package:room_finder/presentation/screens/saved_ads_page.dart';
import 'package:room_finder/presentation/screens/onboarding_page.dart';
import 'package:room_finder/provider/authentication_provider.dart';
import 'package:room_finder/style/theme.dart';
import 'package:room_finder/util/shared_preferences.dart';

// Variable to store whether the on boarding screen has been shown
bool _isShown = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  // TODO: handle this value with the user's role, for now it is hardcoded
  bool isHost = false;  // if this is false
  int currentPageIndex = 0;
  bool isLogged = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isLogged = ref.read(authNotifierProvider.notifier).isLogged();
      if (!isLogged) {
        print("not logged");
        // if (mounted) {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => const LoginPage()));
        // }
      }
      else {
        // just for testing
        User user = ref.read(authNotifierProvider.notifier).currentUser!;
        print("User uid: ${user.uid}");
        print("User email: ${user.email}");
        print("User name: ${user.displayName}");
        print("User photo URL: ${user.photoURL}");

        // TODO: create UserData instance
      }
    });

    setState(() {});
  }

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
              bodyTemplate(body: isLogged ? const AccountPage() : const LoginPage()),
            ][currentPageIndex]
          : <Widget>[
              bodyTemplate(body: SafeArea(child: StudentHomePage(isLogged: isLogged,))),
              bodyTemplate(body: isLogged ? const SafeArea(child: SavedAdsPage()) : const LoginPage()),
              bodyTemplate(body: isLogged ? const SafeArea(child: StudentChatPage()) : const LoginPage()),
              bodyTemplate(body: isLogged ? const AccountPage() : const LoginPage()),
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
