import 'package:flutter/material.dart';

import 'app_theme.dart';

class SearchHeaderView extends StatelessWidget {
  const SearchHeaderView(
      {Key? key,
      required this.textEditingController,
      required this.onSubmitted})
      : super(key: key);

  final TextEditingController textEditingController;
  final void Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search products, articles, faq, ...',
            ),
            controller: textEditingController,
            onSubmitted: onSubmitted,
          ),
        ),
        if (textEditingController.text.isNotEmpty)
          IconButton(
            onPressed: textEditingController.clear,
            icon: const Icon(Icons.clear),
            color: AppTheme.darkBlue,
          ),
      ],
    );
  }
}
