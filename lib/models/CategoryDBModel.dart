class CategoryDBModel {
  int id;
  String name;
  String color;

  CategoryDBModel({this.id, this.name, this.color});

  CategoryDBModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
  CategoryDBModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        color = res["color"];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }
}
