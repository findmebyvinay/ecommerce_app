import 'package:dartz/dartz.dart';
import 'package:ecom_app/core/common/failure_state.dart';

typedef GestureTapCallback = void Function();
typedef VoidCallback = void Function()?;
typedef VoidCallbackWithValue<T> = void Function(T? value)?;

typedef FutureDynamicResponse = Future<Either<dynamic, Failure>>;
typedef DynamicResponse = Either<dynamic, Failure>;

typedef FutureListMap = Future<List<Map<String, dynamic>>>;
typedef ListMap = List<Map<String, dynamic>>;
typedef FutureMap = Future<Map<String, dynamic>>;
typedef FutureString = Future<String>;
typedef FutureBool = Future<bool>;
typedef FutureInt = Future<int>;
typedef FutureDouble = Future<double>;
typedef FutureVoid = Future<void>;
