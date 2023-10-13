import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_play_test/core/failures/common_failure.dart';
import 'package:just_play_test/models/court.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const HomeState._();
  const factory HomeState.initial() = _Initial;

  const factory HomeState.loading() = _Loading;

  const factory HomeState.data({required List<Court> news}) = _Data;

  const factory HomeState.save({required bool save}) = _Save;

  const factory HomeState.error({
    required CommonFailure failure,
  }) = _Error;
}
