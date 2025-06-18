import 'package:hive/hive.dart';
import '../../../core/constants/hive_keys.dart';

class OnboardingLocalDataSource {
  final Box box = Hive.box(HiveKeys.onboardingBox);

  bool hasSeenOnboarding() {
    return box.get(HiveKeys.hasSeenOnboarding, defaultValue: false);
  }

  Future<void> markOnboardingSeen() async {
    await box.put(HiveKeys.hasSeenOnboarding, true);
  }
}
