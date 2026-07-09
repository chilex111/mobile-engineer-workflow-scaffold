import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Single Dio instance shared across all DataSources.
/// Configure base URL, headers, and interceptors here once.
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.example.com/v1',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'Content-Type': 'application/json'},
  ));

  // Add interceptors here (logging, auth token injection, etc.)
  // dio.interceptors.add(AuthInterceptor(ref));

  return dio;
});
