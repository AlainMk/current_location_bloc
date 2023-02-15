part of 'current_location_bloc.dart';

/// CurrentLocationState
// ignore: public_member_api_docs
enum CurrentLocationStatus { initial, success, error, loading }

/// CurrentLocationStatusX
extension CurrentLocationStatusX on CurrentLocationStatus {
  bool get isInitial => this == CurrentLocationStatus.initial;
  bool get isSuccess => this == CurrentLocationStatus.success;
  bool get isError => this == CurrentLocationStatus.error;
  bool get isLoading => this == CurrentLocationStatus.loading;
}

/// CurrentLocationState
class CurrentLocationState extends Equatable {
  /// primary constructor
  const CurrentLocationState({
    this.status = CurrentLocationStatus.initial,
    double? longitude,
    double? latitude,
    String? message,
  })  : longitude = longitude ?? 0,
        latitude = latitude ?? 0,
        message = message ?? 'error';

  /// longitude
  final double longitude;

  /// latitude
  final double latitude;

  /// message
  final String message;

  /// status
  final CurrentLocationStatus status;

  @override
  List<Object?> get props => [status, longitude, latitude];

  /// copyWith
  CurrentLocationState copyWith({
    double? longitude,
    double? latitude,
    CurrentLocationStatus? status,
    String? message,
  }) {
    return CurrentLocationState(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
