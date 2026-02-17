import '../utils/dio_client.dart';
import '../models/producto_model.dart';

class DigiService {
  final DioClient _client = DioClient();

  // LOGIN: Conecta con routes/auth.js
  Future<bool> login(String usuario, String password) async {
    try {
      final response = await _client.dio.post('/api/auth/login', data: {
        'usuario': usuario,
        'password': password,
      });

      if (response.statusCode == 200) {
        String token = response.data['token'];
        _client.setToken(token); // Guardamos el token en el cliente
        return true;
      }
      return false;
    } catch (e) {
      print("Error en login: $e");
      return false;
    }
  }

  // OBTENER PRODUCTOS: Conecta con routes/productos.js
  Future<List<ProductoModel>> fetchProductos() async {
    try {
      final response = await _client.dio.get('/api/productos');
      List<dynamic> data = response.data;
      return data.map((item) => ProductoModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Error al cargar productos: $e");
    }
  }

  // REGISTRAR COMPROBANTE: Conecta con routes/comprobantes.js
  Future<bool> registrarComprobante(String numero, double monto, String fecha) async {
    try {
      final response = await _client.dio.post('/api/comprobantes', data: {
        'numero': numero,
        'monto': monto,
        'fecha': fecha,
      });
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}