import 'package:ecom_app/core/bloc/app_open_cubit.dart';
import 'package:ecom_app/core/bloc/language_cubit.dart';
import 'package:ecom_app/core/bloc/theme_cubit.dart';
import 'package:ecom_app/core/constants/enum.dart';
import 'package:ecom_app/core/flavor/set_env_config.dart';
import 'package:ecom_app/core/mixin/localization_mixin.dart';
import 'package:ecom_app/core/routes/route_generator.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/core/services/theme/dark_theme.dart';
import 'package:ecom_app/core/services/theme/light_theme.dart';
import 'package:ecom_app/entry_screen.dart';
import 'package:ecom_app/global_bloc_provider.dart';
import 'package:ecom_app/widget/app_exit_widget.dart';
import 'package:ecom_app/widget/internet_connection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AbsMain {
  /// A method to initialize the application.
  ///
  /// This can be used to set up necessary resources or configurations
  /// before the main logic is executed.
  Future<void> init({required Enviroment environment});
}

class MainScreen extends AbsMain {
  @override
  Future<void> init({required Enviroment environment}) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Load the environment variables based on the environment
    await dotenv.load(
      fileName: environment == Enviroment.PROD
          ? devEnv[keyEnvironmentFile]!
          : prodEnv[keyEnvironmentFile]!,
    );
    // Initialize the service manager
    await configureDependencies();

    // Initialize local database
    // try {
    //   await LocalDatabaseService()
    //       .database; // Ensures DB and tables are created
    //   log("Local database initialized successfully.");
    // } catch (e) {
    //   log("Database initialization failed: $e");
    // }
    // Ensure that the Flutter Localization is initialized
    await FlutterLocalization.instance.ensureInitialized();
    // Run the main application
    // This is where the main app widget is run
    // It is typically the entry point of the application.
    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AppLocale {
  // Instance of FlutterLocalization to handle localization
  final FlutterLocalization _localization = FlutterLocalization.instance;

  final ValueNotifier<bool> _isToHide = ValueNotifier<bool>(true);

  @override
  void initState() {
    initLang();
    init();
    super.initState();
  }

  void init() {
    // Initialize the theme and language cubits
    getIt<ThemeCubit>().init();
    getIt<LanguageCubit>().init();
  }

  void initLang({String? languageCode}) {
    // Initialize the localization with the supported languages
    // and set the initial language code.
    // This is where you can define the languages your app supports.
    _localization.init(
      mapLocales: [
        const MapLocale(AppLanguage.en_lang, AppLocale.en),
        const MapLocale(AppLanguage.ne_lang, AppLocale.ne),
      ],
      initLanguageCode: languageCode ?? AppLanguage.en_lang,
    );
    // Register the callback for when the language is translated
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  // the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: globalBlocProvider(),
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, themeState) {
          return BlocListener<LanguageCubit, String>(
            listener: (context, langState) {
              initLang(languageCode: langState);
            },
            child: PopScopeWidget(
              canPop: false,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    Expanded(
                      child: ScreenUtilInit(
                        designSize: Size(
                          MediaQuery.sizeOf(context).width,
                          MediaQuery.sizeOf(context).height,
                        ),
                        minTextAdapt: true,
                        splitScreenMode: true,
                        builder: (context, child) {
                          return Material(
                            child: MaterialApp(
                              debugShowCheckedModeBanner: false,
                              supportedLocales: _localization.supportedLocales,
                              localizationsDelegates:
                                  _localization.localizationsDelegates,
                              navigatorKey: NavigationService.navigatorKey,
                              onGenerateRoute: RouteGenerator.generateRoute,
                              darkTheme: darkTheme(context),
                              theme: lightTheme(context),
                              themeMode: themeState
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              home: EntryScreen(),
                              title: 'Ecommerce APP',
                            ),
                          );
                        },
                      ),
                    ),
                    // This is the widget that handles the internet connection status
                    ValueListenableBuilder(
                      valueListenable: _isToHide,
                      builder: (_, isToHide, __) {
                        return BlocBuilder<AppOpenCubit, bool>(
                          builder: (context, appOpenState) {
                            return InternetConnectionWidget(
                              callBack: (isConnected) {
                                if (isConnected) {
                                  if (appOpenState) {
                                    _isToHide.value = true;
                                  } else {
                                    // Call your method after 3 seconds
                                    Future.delayed(Duration(seconds: 3), () {
                                      // Set showWidget to true after 3 seconds
                                      _isToHide.value = true;
                                    });
                                  }
                                } else {
                                  _isToHide.value = false;
                                }
                              },
                              offlineWidget: Align(
                                alignment: Alignment.bottomCenter,
                                child: InternetConnectionMsgWidget(
                                  isConnected: false,
                                ),
                              ),
                              onlineWidget: Align(
                                alignment: Alignment.bottomCenter,
                                child: isToHide
                                    ? SizedBox.fromSize()
                                    : InternetConnectionMsgWidget(
                                        isConnected: true,
                                      ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
