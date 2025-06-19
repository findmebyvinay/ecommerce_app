import 'package:ecom_app/core/mixin/location_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocationCubit extends Cubit<LocationModel> with LocationMixin {
  LocationCubit() : super(LocationModel());

  void reset() {
    emit(LocationModel());
  }

  void init() async {
    try {
      LocationModel location = await getCurrentLocation();
      emit(location);
    } catch (e) {
      emit(LocationModel());
      rethrow;
    }
  }
}
