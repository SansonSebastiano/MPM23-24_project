import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/firebase_options.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/presentation/components/bottom_bar.dart';
import 'package:room_finder/presentation/screens/account_page.dart';
import 'package:room_finder/presentation/screens/chat_page.dart';
import 'package:room_finder/presentation/screens/home_page.dart';
import 'package:room_finder/presentation/screens/login_page.dart';
import 'package:room_finder/presentation/screens/saved_ads_page.dart';
import 'package:room_finder/presentation/screens/onboarding_page.dart';
import 'package:room_finder/provider/authentication_provider.dart';
import 'package:room_finder/provider/user_provider.dart';
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
  int currentStudentPageIndex = 0;
  int currentHostPageIndex = 0;

  bool isHost = false;
  // Check if a user is logged
  bool isLogged = false;
  // Get the information about the logged user from Authentication
  late User? userAuthenticated =
      ref.read(authNotifierProvider.notifier).currentUser;
  // Get the data about the logged user from Firestore
  late UserData user = UserData(isHost: isHost);

  // bool isOnLoad = true;

  @override
  void initState() {
    super.initState();

    _readUser();
  }

  void _readUser() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Get the login user state
      isLogged = ref.read(authNotifierProvider.notifier).isLogged();
      // if logged, then
      if (isLogged) {
        // get the infos
        userAuthenticated =
            ref.read(authNotifierProvider.notifier).currentUser!;
        print(userAuthenticated!.photoURL);
        // get the data
        await ref
            .read(userNotifierProvider.notifier)
            .getUser(userUid: userAuthenticated!.uid);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        // on successful getting data
        successfulRead: (userData) {
          // create the user instance
          user = UserData(
              uid: userAuthenticated!.uid,
              name: userAuthenticated!.displayName,
              email: userAuthenticated!.email,
              photoUrl: userAuthenticated!.photoURL,
              isHost: userData.isHost,
              savedAds: userData.savedAds);
          // setting the user role to display the correct screens
          setState(() {
            isHost = userData.isHost;
            // isOnLoad = false;
          });
        },
        // TODO: decide this, on failed getting data
        failedRead: () => null,
      );
    });

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
          // Host's screens
          ? <Widget>[
              bodyTemplate(
                  body: SafeArea(
                      child: HostHomePage(
                hostUser: user,
              ))),
              bodyTemplate(body: const SafeArea(child: HostChatPage())),
              bodyTemplate(body: AccountPage(user: user)),
            ][currentHostPageIndex]
          // Student's screens
          : <Widget>[
              bodyTemplate(
                body: SafeArea(
                    child: StudentHomePage(
                  isLogged: isLogged,
                  studentUser: user,
                )),
              ),
              bodyTemplate(
                  body: isLogged
                      ? SafeArea(child: SavedAdsPage(currentUserUid: user.uid!))
                      : const LoginPage()),
              bodyTemplate(
                  body: isLogged
                      ? const SafeArea(child: StudentChatPage())
                      : const LoginPage()),
              bodyTemplate(
                  body: isLogged ? AccountPage(user: user) : const LoginPage()),
            ][currentStudentPageIndex],
      bottomNavigationBar: isHost
          ? HostNavigationBar(
              currentPageIndex: currentHostPageIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  currentHostPageIndex = index;
                });
              },
            )
          : StudentNavigationBar(
              currentPageIndex: currentStudentPageIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  currentStudentPageIndex = index;
                });
              },
            ),
    );
  }
}
