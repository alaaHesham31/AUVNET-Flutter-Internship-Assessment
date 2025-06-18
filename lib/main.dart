import 'package:ecommerce_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_app/presentation/blocs/home/home_bloc.dart';
import 'package:ecommerce_app/presentation/blocs/home/home_event.dart';
import 'package:ecommerce_app/presentation/screens/homescreen.dart';
import 'package:ecommerce_app/presentation/screens/login_screen.dart';
import 'package:ecommerce_app/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:ecommerce_app/presentation/blocs/onboarding/onboarding_event.dart';
import 'package:ecommerce_app/presentation/screens/onboarding_screen.dart';
import 'package:ecommerce_app/presentation/screens/signup_screen.dart';
import 'package:ecommerce_app/presentation/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/constants/hive_keys.dart';
import 'data/datasources/local/onboarding_local_data_source.dart';
import 'data/datasources/remote/auth_remote_data_source.dart';
import 'data/repositories_impl/auth_repository_impl.dart';
import 'domain/usecases/login_user.dart';
import 'domain/usecases/register_user.dart';
import 'firebase_options.dart';




import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox(HiveKeys.onboardingBox);

  final onboardingSeen = Hive.box(HiveKeys.onboardingBox)
      .get(HiveKeys.hasSeenOnboarding, defaultValue: false);

  final onboardingBloc = OnboardingBloc(OnboardingLocalDataSource())
    ..add(LoadOnboardingStatus());

  final firebaseAuth = FirebaseAuth.instance;
  final authRemote = AuthRemoteDataSource(firebaseAuth);
  final authRepo = AuthRepositoryImpl(authRemote);

  final authBloc = AuthBloc(
    loginUser: LoginUser(authRepo),
    registerUser: RegisterUser(authRepo),
  );

  final homeBloc = HomeBloc()
    ..add(LoadServices())
    ..add(LoadRestaurants())
    ..add(LoadShortcuts());

  final uid = FirebaseAuth.instance.currentUser?.uid;
  homeBloc.add(LoadUserProfile(uid!));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingBloc>.value(value: onboardingBloc),
        BlocProvider<AuthBloc>.value(value: authBloc),
        BlocProvider<HomeBloc>.value(value: homeBloc),
      ],
      child: MyApp(startWithOnboarding: !onboardingSeen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool startWithOnboarding;

  const MyApp({super.key, required this.startWithOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}