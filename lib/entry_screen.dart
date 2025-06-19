import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_data.dart';
import 'package:ecom_app/features/auth/presentation/screen/login_screen.dart';
import 'package:ecom_app/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    token = getIt<SharedPrefData>().getAuthToken;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (token ?? '').isNotEmpty
        ? const DashboardScreen()
        : const LoginScreen();
  }
}
