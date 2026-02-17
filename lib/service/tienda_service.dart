import '../utils/dio_client.dart';
import '../models/producto_model.dart';

class TiendaService {
  final DioClient _client = DioClient();

  // Login con tu auth.js
  Future<bool> login(String usuario, String password) async {
    try {
      final response = await _client.dio.post('/api/auth/login', data: {
        'usuario': usuario,
        'password': password,
      });

      if (response.statusCode == 200) {
        _client.setToken(response.data['token']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Obtener productos reales de MySQL
  Future<List<ProductoModel>> fetchProductos() async {
    try {
      final response = await _client.dio.get('/api/productos');
      List<dynamic> data = response.data;
      return data.map((item) => ProductoModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Error al cargar productos");
    }
  }
}