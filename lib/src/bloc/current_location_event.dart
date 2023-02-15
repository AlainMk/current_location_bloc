part of 'current_location_bloc.dart';

/// base event
abstract class CurrentLocationEvent extends Equatable {
  /// primary constructor
  const CurrentLocationEvent();
}

/// current event
class ListenCurrentLocationEvent extends CurrentLocationEvent {
  /// primary constructor
  const ListenCurrentLocationEvent();

  @override
  List<Object?> get props => [];
}
