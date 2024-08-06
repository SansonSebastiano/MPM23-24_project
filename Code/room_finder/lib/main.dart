import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/renter_box.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StudentTemplateScreen(
      screenLabel: AppLocalizations.of(context)!.lblWelcomeUser("John"),
      screenContent: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          HostRenterBox(
            name: "Name",
            age: 23,
            facultyOfStudies: "facultyOfStudies",
            interests: "interests",
            contractDeadline: DateTime.now(),
            onEditPressed: () {},
            onRemovePressed: () {},
          )
        ],
      ),
    );
    // Scaffold(
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         connectivityStatusProvider == NetworkStatus.off
    //             ? NoInternetErrorMessage(context: context)
    //             : const CircularProgressIndicator(),
    //       ],
    //     ),
    //   ),
    //   bottomNavigationBar: const StudentNavigationBar(),
    // );
  }
}
