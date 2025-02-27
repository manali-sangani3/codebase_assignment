import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/navigation/routes.dart';
import 'package:flutter_base_project/config/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: _buildCenterLogo(),
    );
  }

  /// Build center logo
  Widget _buildCenterLogo() {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: buildBlocListener,
      builder: (_, __) {
        return Center(child: _buildAvatar());
      },
    );
  }

  /// Build bloc listener widget.
  void buildBlocListener(BuildContext context, SplashState state) {
    if (state is SplashInitial) {
      context.read<SplashCubit>().navigateToScreen();
    } else if (state is InitialiseComplete) {
      context.goNamed(Routes.kUsersScreen);
    }
  }

  /// build app logo
  Widget _buildAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.grey[100],
      radius: 50.0,
      child: const FlutterLogo(
        size: 50.0,
      ),
    );
  }
}
