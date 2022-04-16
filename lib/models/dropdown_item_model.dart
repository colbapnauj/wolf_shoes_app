class DropDownItemModel {
  DropDownItemModel({
    required this.id,
    required this.value,
  });

  String? id;
  String? value;
}

abstract class GlobalModel {
  String getId();
  String getValue();
}
