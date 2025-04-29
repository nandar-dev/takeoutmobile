import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/user/user_cubit.dart';
import 'package:takeout/cubit/user/user_state.dart';
import 'package:takeout/navigation/app_navigation.dart';
import 'package:takeout/pages/auth/login_page.dart';
import 'package:takeout/pages/landing/landing_page.dart';
import 'package:takeout/utils/first_launch_storage.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: FirstLaunchStorage.isFirstLaunch(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return const LandingPage();
        }
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const AppNavigation();
            } else {
              return const LoginPage();
            }
          },
        );
      },
    );
  }
}
