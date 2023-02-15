import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

/// bloc
class CurrentLocationBloc
    extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  /// primary constructor
  CurrentLocationBloc(this.location) : super(const CurrentLocationState()) {
    on<ListenCurrentLocationEvent>((event, emit) async {
      try {
        bool _serviceEnabled;
        PermissionStatus _permissionGranted;

        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }
        emit(state.copyWith(status: CurrentLocationStatus.loading));
        await emit.onEach<LocationData>(
          location.onLocationChanged,
          onData: (location) {
            return emit(
              state.copyWith(
                status: CurrentLocationStatus.success,
                latitude: location.latitude,
                longitude: location.longitude,
              ),
            );
          },
          onError: (e, __) => state.copyWith(
            status: CurrentLocationStatus.error,
            message: e.toString(),
          ),
        );
      } catch (e) {
        emit(const CurrentLocationState(status: CurrentLocationStatus.error));
      }
    });
  }

  /// location
  final Location location;
}
