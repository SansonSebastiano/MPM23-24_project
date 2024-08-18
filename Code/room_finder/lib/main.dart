import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/presentation/components/bottom_bar.dart';
import 'package:room_finder/presentation/screens/chat_page.dart';
import 'package:room_finder/presentation/screens/home_page.dart';
import 'package:room_finder/presentation/screens/saved_ads_page.dart';
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

    return Scaffold(
      body: isHost
          ? <Widget>[
              bodyTemplate(body: const HostHomePage()),
              bodyTemplate(body: const ChatPage()),
              bodyTemplate(body: const Text("Host account")),
            ][currentPageIndex]
          : <Widget>[
              bodyTemplate(body: const StudentHomePage()),
              bodyTemplate(body: const SavedAdsPage()),
              bodyTemplate(body: const ChatPage()),
              bodyTemplate(body: const Text("Student account")),
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
    // const FacilityDetailPage(
    //     isStudent: false,
    //     isWizardPage: true,
    //     facilityPhotos: [
    //       "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg",
    //       "https://cdn.cosedicasa.com/wp-content/uploads/webp/2022/05/cucina-e-soggiorno-640x320.webp",
    //       "https://www.grazia.it/content/uploads/2018/03/come-arredare-monolocale-sfruttando-centimetri-2.jpg"
    //     ],
    //     facilityName: "Casa Dolce Casa",
    //     facilityAddress: "Padova - Via Roma 12",
    //     facilityPrice: 300,
    //     facilityHostName: "Mario Rossi",
    //     hostUrlImage:
    //         "https://cdn.create.vista.com/api/media/medium/319362956/stock-photo-man-pointing-showing-copy-space-isolated-on-white-background-casual-handsome-caucasian-young-man?token=",
    //     facilityServices: ["2 bedrooms", "3 beds", "1 bathroom", "WiFi"]);

    // WizardTemplateScreen(
    //   leftButton: DarkBackButton(onPressed: () {}),
    //   rightButton: CancelButton(onPressed: () {}),
    //   rightButtonVisibility: true,
    //   screenLabel: "Screen Title",
    //   screenContent: const Text("Screen Content"),
    //   dialogTitle: "Dialog Title",
    //   dialogContent: "Dialog Content",
    //   currentStep: 1,
    //   btnNextLabel: "Next",
    //   btnNextOnPressed: () {},
    // );
    // SecondaryTemplateScreen(
    //   leftHeaderWidget: DarkBackButton(onPressed: () {}),
    //   centerHeaderWidget: const CustomSearchBar(
    //     hintText: "Search",
    //   ),
    //   rightHeaderWidget: FilterButton(onPressed: () {}),
    //   rightHeaderWidgetVisibility: true,
    // );

    // StudentTemplateScreen(
    //   screenLabel: AppLocalizations.of(context)!.lblWelcomeUser("John"),
    //   screenContent: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //     ],
    //   ),
    // );

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
