


import 'package:just_play_test/models/court.dart';

abstract class HomeEvent  {
   const HomeEvent([List props = const []]) : super();
   

}
class HomeStarted extends HomeEvent {
  @override
  List<Object?> get props => [];
}
class SaveCourtStarted extends HomeEvent {
  final Court court;

  const SaveCourtStarted(this.court);
  @override
  List<Object?> get props => [];
}
class DeleteStarted extends HomeEvent {
  final Court court;

  const DeleteStarted(this.court);
  @override
  List<Object?> get props => [];
}