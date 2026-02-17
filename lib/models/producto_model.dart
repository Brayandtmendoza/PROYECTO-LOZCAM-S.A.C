class ProductoModel {
  final int id;
  final String nombre;
  final double precio;
  final String? categoria;
  final String? urlImagen;

  ProductoModel({
    required this.id,
    required this.nombre,
    required this.precio,
    this.categoria,
    this.urlImagen,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'],
      nombre: json['nombre'],
      precio: double.parse(json['precio'].toString()),
      categoria: json['categoria'],
      urlImagen: json['imagenes_productos_url'],
    );
  }
}
