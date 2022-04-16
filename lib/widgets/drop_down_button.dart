import 'package:flutter/material.dart';
import 'package:wolf_app/models/dropdown_item_model.dart';

class GlobalDropdown extends StatelessWidget {
  const GlobalDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
  }) : super(key: key);
  final List<GlobalModel> items;
  final void Function(String?)? onChanged;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          elevation: 1,
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 30,
            color: Colors.black,
          ),
          value: value ?? items.first.getId(),
          isExpanded: true,
          items: items
              .map(
                (GlobalModel item) => DropdownMenuItem<String>(
                  value: item.getId(),
                  child: Text(
                    item.getValue(),
                    style: const TextStyle(
                      color: Color(0xff2b2b2b),
                      fontSize: 20,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
