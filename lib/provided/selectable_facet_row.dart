import 'package:flutter/material.dart';
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

class SelectableFacetRow extends StatelessWidget {
  const SelectableFacetRow({Key? key, required this.selectableFacet})
      : super(key: key);

  final SelectableFacet selectableFacet;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        selectableFacet.isSelected
            ? Icons.check_box
            : Icons.check_box_outline_blank,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(selectableFacet.item.value),
      const Spacer(),
      Text('${selectableFacet.item.count}'),
    ]);
  }
}