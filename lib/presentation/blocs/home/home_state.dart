import 'package:equatable/equatable.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/restaurant.dart';
import '../../../domain/entities/shortcut.dart';
import '../../../domain/entities/user_profile.dart';

class HomeState extends Equatable {
  final List<Service> services;
  final List<Restaurant> restaurants;
  final List<Shortcut> shortcuts;
  final UserProfile? userProfile;
  final bool isLoading;
  final String? error;


  const HomeState({
    this.services = const [],
    this.restaurants = const [],
    this.shortcuts = const [],
    this.userProfile,
    this.isLoading = false,
    this.error,

  });

  HomeState copyWith({
    List<Service>? services,
    List<Restaurant>? restaurants,
    List<Shortcut>? shortcuts,
    UserProfile? userProfile,
    bool? isLoading,
    String? error,

  }) {
    return HomeState(
      services: services ?? this.services,
      restaurants: restaurants ?? this.restaurants,
      shortcuts: shortcuts ?? this.shortcuts,
      userProfile: userProfile ?? this.userProfile,
      isLoading: isLoading ?? this.isLoading,
      error: error,

    );
  }

  @override
  List<Object?> get props => [services, restaurants, shortcuts, isLoading, error, userProfile ?? ''];
}
