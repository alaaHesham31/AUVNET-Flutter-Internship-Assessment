import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final bool hasSeenOnboarding;

  const OnboardingState({required this.hasSeenOnboarding});

  OnboardingState copyWith({bool? hasSeenOnboarding}) {
    return OnboardingState(
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }

  @override
  List<Object?> get props => [hasSeenOnboarding];
}
