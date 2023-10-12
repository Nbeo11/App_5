class LopHocModel {
  int? id;
  String? name;


  LopHocModel({
     this.id,
     this.name,
  });

  factory LopHocModel.fromMap(Map<String, dynamic> json) => LopHocModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
