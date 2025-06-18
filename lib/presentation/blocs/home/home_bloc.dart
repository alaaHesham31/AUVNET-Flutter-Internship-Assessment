import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/service.dart';
import '../../../domain/entities/restaurant.dart';
import '../../../domain/entities/shortcut.dart';
import '../../../domain/entities/user_profile.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadServices>(_onLoadServices);
    on<LoadShortcuts>(_onLoadShortcuts);
    on<LoadRestaurants>(_onLoadRestaurants);
    on<LoadUserProfile>(_onLoadUserProfile); // ✅ NEW
  }

  Future<void> _onLoadServices(LoadServices event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));

    final mockServices = [
      Service(id: '1', imageUrl: 'assets/images/food.png', label: 'Food', tag: 'Up to 50%'),
      Service(id: '2', imageUrl: 'assets/images/health.png', label: 'Health & wellness', tag: '20mins'),
      Service(id: '3', imageUrl: 'assets/images/grocery.png', label: 'Groceries', tag: '15 mins'),
    ];

    emit(state.copyWith(services: mockServices, isLoading: false));
  }

  Future<void> _onLoadShortcuts(LoadShortcuts event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));

    final mockShortcuts = [
      Shortcut(id: '1', label: 'Past orders', image: 'assets/images/past_order.png'),
      Shortcut(id: '2', label: 'Super Saver', image: 'assets/images/super_saver.png'),
      Shortcut(id: '3', label: 'Must-tries', image: 'assets/images/must_tries.png'),
      Shortcut(id: '4', label: 'Give Back', image: 'assets/images/give_back.png'),
      Shortcut(id: '5', label: 'Best Sellers', image: 'assets/images/best_seller.png'),
    ];

    emit(state.copyWith(shortcuts: mockShortcuts, isLoading: false));
  }

  Future<void> _onLoadRestaurants(LoadRestaurants event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));

    final mockRestaurants = [
      Restaurant(id: '1', name: 'Allo Beirut', time: '32 mins', logo: 'assets/images/allo_beirut.png'),
      Restaurant(id: '2', name: 'Laffah', time: '38 mins', logo: 'assets/images/laffah.png'),
      Restaurant(id: '3', name: 'Falafil Al Rabiah', time: '44 mins', logo: 'assets/images/falafil.png'),
      Restaurant(id: '4', name: 'Barbar', time: '34 mins', logo: 'assets/images/barbar.png'),
    ];

    emit(state.copyWith(restaurants: mockRestaurants, isLoading: false));
  }

  Future<void> _onLoadUserProfile(LoadUserProfile event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(event.uid)
          .get();

      final data = doc.data();

      if (data != null) {
        final profile = UserProfile(
          name: data['name'] ?? '',
          address: data['address'] ?? '',
        );
        emit(state.copyWith(userProfile: profile, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
