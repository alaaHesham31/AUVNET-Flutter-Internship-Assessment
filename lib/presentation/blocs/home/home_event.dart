import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadServices extends HomeEvent {}
class LoadRestaurants extends HomeEvent {}
class LoadShortcuts extends HomeEvent {}

class LoadUserProfile extends HomeEvent {
  final String uid;

  LoadUserProfile(this.uid);

  @override
  List<Object?> get props => [uid];
}
