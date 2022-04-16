class ColorModel {
  ColorModel({
    required this.uid,
    required this.nameColor,
  });

  String uid;
  String nameColor;

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        nameColor: json["name_color"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name_color": nameColor,
        "uid": uid,
      };
}
