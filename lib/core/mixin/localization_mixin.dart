// ignore_for_file: constant_identifier_names

import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:flutter_localization/flutter_localization.dart';
final FlutterLocalization localization = FlutterLocalization.instance;

bool get isEnglish => true;

class AppLanguage {
  AppLanguage._();

  static const String ne_lang = 'ne';
  static const String en_lang = 'en';
}

String l10(String key) {
  return key.getString(getIt<NavigationService>().getNavigationContext());
}

mixin AppLocale {
  static const String languagae = 'languagae';

  ///========== NavBar ==========
  static const String home = 'home';
  static const String startSurvey = 'startSurvey';
  static const String profile = 'profile';
  static const String notifications = 'notifications';

  ///========== LogIn Screen ==========
  static const String logIn = 'logIn';
  static const String loginButton = 'loginButton';
  static const String forgotPassword = 'forgotPassword';
  static const String rememberMe = 'rememberMe';
  static const String emailAddress = 'emailAddress';
  static const String password = 'password';
  static const String routineImmunizationRCMApplication =
      'routineImmunizationRCMApplication';
  static const String emailRequired = 'emailRequired';
  static const String passwordRequired = 'passwordRequired';
  static const String invalidEmail = 'invalidEmail';
  static const String invalidPassword = 'invalidPassword';

  ///========== Dashboard Screen ==========
  static const String dashboard = 'dashboard';
  static const String immunizationMonitoringDashboard =
      'immunizationMonitoringDashboard';
  static const String immunizationMonitoring = 'immunizationMonitoring';
  static const String rcmMonitoring = 'rcmMonitoring';
  static const String availableData = 'availableData';

  ///========== Start Survey Screen ==========
  static const String startSurveyTitle = 'startSurveyTitle';
  static const String downloadRCMQuestionnaires = 'downloadRCMQuestionnaires';
  static const String startRCM = 'startRCM';
  static const String editRCM = 'editRCM';
  static const String uploadRCM = 'uploadRCM';
  static const String start_a_new_survey_message = 'start_a_new_survey_message';

  ///========== Global ==========
  static const String noData = 'noData';
  static const String somethingWentWrong = 'somethingWentWrong';
  static const String somethingWentWrongMessage = 'somethingWentWrongMessage';
  static const String retry = 'retry';
  static const String filter = 'filter';
  static const String appExitLable = 'appExitLable';
  static const String appExitMessage = 'appExitMessage';
  static const String backOnline = 'backOnline';
  static const String noInternetConnection = 'noInternetConnection';
  static const String exitAppTitle = 'exitAppTitle';
  static const String exitAppConfirmation = 'exitAppConfirmation';

  ///========== Buttons ==========
  static const String ok = 'ok';
  static const String cancel = 'cancel';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String save = 'save';
  static const String delete = 'delete';
  static const String edit = 'edit';
  static const String add = 'add';
  static const String next = 'next';
  static const String previous = 'previous';
  static const String submit = 'submit';
  static const String close = 'close';
  static const String back = 'back';
  static const String continueButton = 'continue';
  static const String view = 'view';
  static const String viewAll = 'viewAll';
  static const String viewDetails = 'viewDetails';
  static const String viewMore = 'viewMore';
  static const String viewLess = 'viewLess';
  static const String start = 'start';

  /// =========== Form Fields =============
  static const String province = 'province';
  static const String district = 'district';
  static const String municipality = 'municipality';
  static const String select = 'select';

  ///
  ///========== Profile ==========
  static const String theme = 'theme';
  static const String logout = 'logout';
  static const String themeSubtitle = 'themeSubtitle';
  static const String languageSubtitle = 'languageSubtitle';

  ///========== English Languagae ==========
  static const Map<String, dynamic> en = {
    languagae: 'Language',
    noData: "No Data Found !",
    somethingWentWrong: "Something went wrong !",
    somethingWentWrongMessage: "Please try again later.",
    retry: "Retry",
    filter: "Filter",
    home: 'Home',
    startSurvey: 'Start Survey',
    profile: 'Profile',
    notifications: 'Notifications',
    dashboard: 'Dashboard',
    theme: 'Theme',
    logout: 'Logout',
    appExitLable: 'Tap back again to exit app.',
    appExitMessage: 'Are you sure you want to exit the app?',
    startSurveyTitle: 'Start Survey',
    downloadRCMQuestionnaires: 'Download RCM Questionnaires',
    startRCM: 'Start RCM',
    editRCM: 'Edit RCM',
    uploadRCM: 'Upload RCM',
    ok: 'OK',
    cancel: 'Cancel',
    yes: 'Yes',
    no: 'No',
    save: 'Save',
    delete: 'Delete',
    edit: 'Edit',
    add: 'Add',
    next: 'Next',
    previous: 'Previous',
    submit: 'Submit',
    close: 'Close',
    back: 'Back',
    continueButton: 'Continue',
    view: 'View',
    viewAll: 'View All',
    viewDetails: 'View Details',
    viewMore: 'View More',
    viewLess: 'View Less',
    start: 'Start',
    immunizationMonitoringDashboard: 'Immunization Monitoring Dashboard',
    immunizationMonitoring: 'Immunization Monitoring',
    rcmMonitoring: 'RCM Monitoring',
    availableData: 'Available Data',
    logIn: 'Login',
    loginButton: 'Log In',
    forgotPassword: 'Forgot Password?',
    rememberMe: 'Remember Me',
    emailAddress: 'Email Address',
    password: 'Password',
    routineImmunizationRCMApplication: 'Routine Immunization RCM Application',
    emailRequired: 'Email is required',
    passwordRequired: 'Password is required',
    invalidEmail: 'Invalid email format',
    invalidPassword: 'Password must be at least 6 characters',
    backOnline: 'Back Online',
    noInternetConnection: 'No Internet Connection',
    province: 'Province',
    district: 'District',
    municipality: 'Municipality',
    select: "Select",
    start_a_new_survey_message:
        "Start a new survey by clicking the 'Start Survey' button",
    themeSubtitle: 'Switch themes to match your vibe',
    languageSubtitle: 'Choose your preferred language',
    exitAppTitle: 'Exit ?',
    exitAppConfirmation: 'Are you sure you want to exit this screen?',
  };

  ///========== Nepali Languagae ==========
  static const Map<String, dynamic> ne = {
    languagae: 'भाषा',
    noData: "डाटा फेला परेन !",
    somethingWentWrong: "केहि गल्ती भयो !",
    somethingWentWrongMessage: "कृपया पछि फेरि प्रयास गर्नुहोस्।",
    retry: "पुन प्रयास गर्नुहोस्",
    filter: "फिल्टर",
    home: 'गृहपृष्ठ',
    startSurvey: 'सर्वेक्षण सुरु',
    profile: 'प्रोफाइल',
    notifications: 'सूचनाहरू',
    dashboard: 'ड्यासबोर्ड',
    theme: 'थीम',
    logout: 'लगआउट',
    appExitLable: 'बाहिर निस्कनको लागि फेरि ब्याकमा ट्याप गर्नुहोस्।',
    appExitMessage: 'के तपाईँ साँच्चै एप्लिकेसनबाट बाहिर निस्कन चाहनुहुन्छ?',
    startSurveyTitle: 'सर्वेक्षण सुरु गर्नुहोस्',
    downloadRCMQuestionnaires: 'RCM प्रश्नावलीहरू डाउनलोड गर्नुहोस्',
    startRCM: 'RCM सुरु गर्नुहोस्',
    editRCM: 'RCM सम्पादन गर्नुहोस्',
    uploadRCM: 'RCM अपलोड गर्नुहोस्',
    ok: 'ठिक छ',
    cancel: 'रद्द गर्नुहोस्',
    yes: 'हो',
    no: 'होइन',
    save: 'सुरक्षित गर्नुहोस्',
    delete: 'मेटाउनुहोस्',
    edit: 'सम्पादन गर्नुहोस्',
    add: 'थप्नुहोस्',
    next: 'अर्को',
    previous: 'अघिल्लो',
    submit: 'पेश गर्नुहोस्',
    close: 'बन्द गर्नुहोस्',
    back: 'फिर्ता',
    continueButton: 'जारी राख्नुहोस्',
    view: 'हेर्नुहोस्',
    viewAll: 'सबै हेर्नुहोस्',
    viewDetails: 'विवरण हेर्नुहोस्',
    viewMore: 'थप हेर्नुहोस्',
    viewLess: 'कम हेर्नुहोस्',
    start: 'सुरु गर्नुहोस्',
    immunizationMonitoringDashboard: 'खोप अनुगमन ड्यासबोर्ड',
    immunizationMonitoring: 'खोप अनुगमन',
    rcmMonitoring: 'RCM अनुगमन',
    availableData: 'उपलब्ध डाटा',
    logIn: 'लगइन',
    loginButton: 'लग इन',
    forgotPassword: 'पासवर्ड बिर्सनुभयो?',
    rememberMe: 'मलाई सम्झनुहोस्',
    emailAddress: 'इमेल ठेगाना',
    password: 'पासवर्ड',
    routineImmunizationRCMApplication: 'रूटीन इम्यूनाइजेशन RCM एप्लिकेशन',
    emailRequired: 'इमेल आवश्यक छ',
    passwordRequired: 'पासवर्ड आवश्यक छ',
    invalidEmail: 'अमान्य इमेल ढाँचा',
    invalidPassword: 'पासवर्ड कम्तिमा ६ अक्षरको हुनुपर्छ',
    backOnline: 'फेरि अनलाइन',
    noInternetConnection: 'इन्टरनेट जडान छैन',
    province: 'प्रदेश',
    district: 'जिल्ला',
    municipality: 'नगरपालिका',
    select: "चयन",
    start_a_new_survey_message:
        "'सर्वेक्षण सुरु' बटन क्लिक गरेर नयाँ सर्वेक्षण सुरु गर्नुहोस्",
    themeSubtitle: 'आफ्नो भाइबसँग मेल खाने विषयवस्तुहरू बदल्नुहोस्',
    languageSubtitle: 'आफ्नो मनपर्ने भाषा छान्नुहोस्',
    exitAppTitle: 'बाहिर निस्कनुहोस् ?',
    exitAppConfirmation:
        'के तपाईं यो स्क्रिनबाट बाहिर निस्कन निश्चित हुनुहुन्छ?',
  };
}
