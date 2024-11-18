class CategoryModel {
  int? id;
  String? name;
  String? image;

  CategoryModel({ required this.id,required this.name,required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}


final List<Map<String, dynamic>> categoryimages = [


  {"image": "assets/images/b0.jpg"},

];