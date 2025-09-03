import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/login/login_view.dart';
import '../ui/splash/splash_view.dart';
import '../ui/dashboard/dashboard_page.dart';
import '../ui/documents/add_document_view.dart';
import '../ui/documents/documents_page.dart';
import '../ui/documents/preview_document_view.dart';
import '../ui/forget_password/forget_password_view.dart';
import '../ui/forget_password/update_password_view.dart';
import '../ui/profile/edit_profile_view.dart';
import '../ui/profile/profile_view.dart';
import '../ui/setting/setting_view.dart';
import '../ui/setting/term_condition_view.dart';
import '../ui/signup/signup_view.dart';
import '../ui/widgets/header_txt_widget.dart';
import '../ui/setting/privacy_policy_view.dart';
import '../ui/help_support/help_support_view.dart';
import '../ui/help_support/help_support_list_view.dart';

List<GetPage> appRoutes() => [
  GetPage(
    name: '/splash',
    page: () => const SplashPage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/login',
    page: () => const LoginPage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/signup',
    page: () => const SignupPage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/edit_profile',
    page: () => EditProfilePage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/setting',
    page: () => SettingPage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/forget_password',
    page: () => const ForgetPasswordPage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/update_password',
    page: () => UpdatePasswordPage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/dashboard',
    page: () => DashboardPage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/add_document',
    page: () => const AddDocumentView(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/term_condition',
    page: () => const TermConditionView(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/privacy_policy',
    page: () => const PrivacyPolicyView(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/preview_document',
    page: () => const PreviewDocumentView(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/help_support',
    page: () => HelpSupportPage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/help_support_list',
    page: () => HelpSupportListPage(),
    transitionDuration: const Duration(milliseconds: 500),
  ),
];

Route? onGenerateRoute(RouteSettings settings) {
  print("Navigating to: ${settings.name}");
  if (settings.name == 'home') {
    return GetPageRoute(
      settings: settings,
      page: () => const DocumentsPage(),
    );
  }
  if (settings.name == 'more') {
    return GetPageRoute(
      settings: settings,
      page: () => ProfilePage(),
    );
  }
  if (settings.name == 'help_support') {
    return GetPageRoute(
      settings: settings,
      page: () => HelpSupportPage(),
    );
  }
  if (settings.name == 'help_support_list') {
    return GetPageRoute(
      settings: settings,
      page: () => HelpSupportListPage(),
    );
  }

  return GetPageRoute(
    settings: settings,
    page: () => Container(
      alignment: AlignmentDirectional.center,
      child: HeaderTxtWidget("Page Under Development"),
    ),
  );
}

class MyMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print("Middleware: Navigating to ${page?.name}");
    return super.onPageCalled(page);
  }
}