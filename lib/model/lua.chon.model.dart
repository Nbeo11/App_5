
class LuaChonModel {
  int id;
  int type;
  String content;
  int point;

  LuaChonModel({
    required this.id,
    required this.type,
    required this.content,
    required this.point,
  });

  factory LuaChonModel.fromMap(Map<String, dynamic> json) => LuaChonModel(
        id: json["id"]??0,
        type: json["type"]??0,
        content: json["content"] ?? "",
        point: json["point"]??0,

      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "content": content,
        "point": point,
      };
}