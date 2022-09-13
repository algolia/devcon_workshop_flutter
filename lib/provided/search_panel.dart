

import 'package:flutter/material.dart';

class SearchPanel extends StatefulWidget implements PreferredSizeWidget {

  const SearchPanel({Key? key, this.onSearch}) : super(key: key);

  final VoidCallback? onSearch;

  @override
  State<SearchPanel> createState() => _SearchPanelState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 44);
}

class _SearchPanelState extends State<SearchPanel> {
  @override
  PreferredSize build(BuildContext context) =>
    PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey.withOpacity(0.5)),
            IntrinsicHeight(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                        label: const Text("MENU")),
                  ),
                  VerticalDivider(
                      width: 20,
                      indent: 12,
                      endIndent: 12,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.5)),
                  Flexible(
                    child: TextField(
                      readOnly: true,
                      onTap: widget.onSearch,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary),
                          hintText:
                          "Search products, articles, faq, ..."),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
}