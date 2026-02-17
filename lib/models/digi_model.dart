class DigiModel {
  final String name;
  final String img;
  final String level;

  DigiModel({required this.name, required this.img, required this.level});

  factory DigiModel.fromJson(Map<String, dynamic> json) {
    return DigiModel(
      name: json['name'],
      img: json['img'],
      level: json['level'],
    );
  }
}
