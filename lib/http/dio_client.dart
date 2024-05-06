import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dioClient = Dio(
  BaseOptions(
    baseUrl: dotenv.get("VECINO_VIGILANTE_URL_SERVICE"),
    headers: {
      'Accept': 'application/json',
    },
  ),
);
