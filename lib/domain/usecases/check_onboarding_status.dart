import '../../../data/datasources/local/onboarding_local_data_source.dart';

class CheckOnboardingStatus {
  final OnboardingLocalDataSource localDataSource;

  CheckOnboardingStatus(this.localDataSource);

  bool execute() => localDataSource.hasSeenOnboarding();
}
