import 'package:flutter_dotenv/flutter_dotenv.dart';

class GetEnvConfig {
  GetEnvConfig._();

  static final String appEnvironment = dotenv.get('APP_ENV');
  static final String baseUrl = dotenv.get('BASE_URL');
}
