import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    navigateToScreen();
  }

  /// navigate to welcome screen
  void navigateToScreen() {
    Future.delayed(const Duration(seconds: 1), () {
      emit(InitialiseComplete());
    });
  }
}
