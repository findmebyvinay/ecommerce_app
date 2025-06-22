import 'package:ecom_app/core/constants/typedef.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/network_service/api_request.dart';
import 'package:ecom_app/features/products/domain/repo/product_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepo)
class ProductRepoImpl extends ProductRepo {
static const String productEndpoint='https://dummyjson.com/products';

@override
  FutureDynamicResponse getProduct() {
  return getIt<ApiRequest>().getResponse(
    endPoint: productEndpoint,
    apiMethods: ApiMethods.get);
  }
}