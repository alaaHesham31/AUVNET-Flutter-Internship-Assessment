import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadOnboardingStatus extends OnboardingEvent {}

class CompleteOnboarding extends OnboardingEvent {}
