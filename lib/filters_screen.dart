import 'package:algolia_devcon_workshop/product_repository.dart';
import 'package:algolia_devcon_workshop/provided/selectable_facet_row.dart';
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

enum FiltersSection { none, sort, brand }

class _FiltersScreenState extends State<FiltersScreen> {
  final _indicesTitles = const <String, String>{
    'STAGING_native_ecom_demo_products': 'Most popular',
    'STAGING_native_ecom_demo_products_products_price_asc': 'Price Low to High',
    'STAGING_native_ecom_demo_products_products_price_desc':
        'Price High to Low',
  };

  FiltersSection activeSection = FiltersSection.none;

  bool _isActive(FiltersSection section) => section == activeSection;

  _toggleSection(FiltersSection section) => setState(
      () => activeSection = _isActive(section) ? FiltersSection.none : section);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 10, right: 10),
        child: Column(
          children: [
            const Text(
              "Filter & Sort",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  _sortHeader(context),
                  if (_isActive(FiltersSection.sort)) _sortSelector(context),
                  _brandHeader(context),
                  if (_isActive(FiltersSection.brand)) _brandSelector(context),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _expandableRowHeader(Widget title, FiltersSection section,
          Stream<List<SelectableFacet>>? facetsStream) =>
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          child: Row(
            children: [
              title,
              const Spacer(),
              Icon(_isActive(section) ? Icons.remove : Icons.add)
            ],
          ),
          onTap: () => _toggleSection(section),
        ),
      ));

  Widget _sortHeader(BuildContext context) => _expandableRowHeader(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sort',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          if (!_isActive(FiltersSection.sort))
            StreamBuilder<String>(
                stream: context.read<ProductRepository>().selectedIndexName,
                builder: (context, snapshot) => Text(snapshot.hasData
                    ? '${_indicesTitles[snapshot.data!]}'
                    : '')),
        ],
      ),
      FiltersSection.sort,
      null);

  Widget _sortSelector(BuildContext context) => StreamBuilder<String>(
      stream: context.read<ProductRepository>().selectedIndexName,
      builder: (context, snapshot) {
        final selectedIndexName = snapshot.data;
        return SliverFixedExtentList(
            itemExtent: 40,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = _indicesTitles.entries.toList()[index];
                final productRepository = context.read<ProductRepository>();
                return InkWell(
                    onTap: () => productRepository.selectIndexName(item.key),
                    child: Text(
                      item.value,
                      style: TextStyle(
                          fontWeight: item.key == selectedIndexName
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ));
              },
              childCount: _indicesTitles.length,
            ));
      });

  Widget _brandHeader(BuildContext context) => _expandableRowHeader(
      const Text('Brand',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      FiltersSection.brand,
      context.read<ProductRepository>().brandFacets);

  Widget _brandSelector(BuildContext context) {
    final productRepository = context.read<ProductRepository>();
    return StreamBuilder<List<SelectableFacet>>(
        stream: productRepository.brandFacets,
        builder: (context, snapshot) {
          final facets = snapshot.data ?? [];
          return SliverFixedExtentList(
              itemExtent: 44,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final facet = facets[index];
                  return InkWell(
                    child: SelectableFacetRow(
                      selectableFacet: facet,
                    ),
                    onTap: () =>
                        productRepository.toggleBrand(facet.item.value),
                  );
                },
                childCount: facets.length,
              ));
        });
  }
}
