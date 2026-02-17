import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;
  String? _token; // Almacena el JWT temporalmente

  factory DioClient() => _instance;

  // Método para guardar el token después del login exitoso
  void setToken(String token) => _token = token;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        /* CONFIGURACIÓN DE IP AUTOMÁTICA:
          - Si kIsWeb es true (Chrome): usa localhost.
          - Si es false (Android): usa 10.0.2.2 para conectar al PC.
        */
        baseUrl: kIsWeb ? 'http://localhost:3000' : 'http://10.0.2.2:3000', 
        
        // Aumentamos el tiempo de espera a 20 segundos para evitar el Timeout
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // INTERCEPTOR: Agrega el token a cada petición automáticamente
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_token != null) {
          // Es vital que diga 'Bearer ' con el espacio incluido
          options.headers['Authorization'] = 'Bearer $_token';
        }
        print("Petición a: ${options.baseUrl}${options.path}"); // Log de ayuda
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Log para ver si el servidor respondió bien
        print("Respuesta recibida: ${response.statusCode}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          print("Error: Token expirado o sesión inválida.");
        } else if (e.type == DioExceptionType.connectionTimeout) {
          print("Error de conexión: El servidor tardó demasiado en responder.");
        }
        return handler.next(e);
      },
    ));
  }
}