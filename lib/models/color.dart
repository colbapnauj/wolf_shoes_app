import 'package:wolf_app/models/dropdown_item_model.dart';

class ColorModel extends GlobalModel {
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

  @override
  String getId() {
    return uid;
  }

  @override
  String getValue() {
    return nameColor;
  }
}
