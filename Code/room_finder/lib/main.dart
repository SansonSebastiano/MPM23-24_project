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
import 'package:room_finder/presentation/screens/splash_page.dart';
import 'package:room_finder/provider/splash_provider.dart';
import 'package:room_finder/style/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  // TODO: handle this value with the user's role, for now it is hardcoded
  bool isHost = false;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget bodyTemplate({required Widget body}) {
      return SafeArea(
          child: Center(
        child: body,
      ));
    }

    return FutureBuilder(
      future: ref.watch(splashStateProvider).value!.isFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Scaffold(
                body: isHost
                    ? <Widget>[
                        bodyTemplate(body: const HostHomePage()),
                        bodyTemplate(body: const HostChatPage()),
                        bodyTemplate(body: const AccountPage()),
                      ][currentPageIndex]
                    : <Widget>[
                        bodyTemplate(body: const StudentHomePage()),
                        bodyTemplate(body: const SavedAdsPage()),
                        bodyTemplate(body: const StudentChatPage()),
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
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        ref.watch(splashStateProvider).value!.setFirstTime();
        return const SplashPage();
      },
    );
  }
}
