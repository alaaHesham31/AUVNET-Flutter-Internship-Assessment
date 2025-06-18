import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';
import '../../../data/datasources/local/onboarding_local_data_source.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingLocalDataSource localDataSource;

  OnboardingBloc(this.localDataSource)
      : super(const OnboardingState(hasSeenOnboarding: false)) {
    on<LoadOnboardingStatus>((event, emit) {
      final seen = localDataSource.hasSeenOnboarding();
      emit(state.copyWith(hasSeenOnboarding: seen));
    });

    on<CompleteOnboarding>((event, emit) async {
      await localDataSource.markOnboardingSeen();
      emit(state.copyWith(hasSeenOnboarding: true));
    });
  }
}
