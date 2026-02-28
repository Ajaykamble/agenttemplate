
import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/l10n/app_localizations.dart';
import 'package:agenttemplate/models/catalogue_response_model.dart';
import 'package:agenttemplate/provider/agent_template_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class MPMForm extends StatefulWidget {
  final Component buttonsComponent;
  final Color backgroundColor;
  final String templateType;
  const MPMForm({super.key, required this.buttonsComponent, required this.backgroundColor, required this.templateType});

  @override
  State<MPMForm> createState() => _MPMFormState();
}

class _MPMFormState extends State<MPMForm> {
  late AgentTemplateProvider agentTemplateProvider;
  TemplateButton? mpmButton;
  @override
  void initState() {
    super.initState();
    agentTemplateProvider = Provider.of<AgentTemplateProvider>(context, listen: false);
    agentTemplateProvider.getCatalogue();
    mpmButton = widget.buttonsComponent.buttons?.firstWhereOrNull((element) => element.type == "MPM");
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AgentTemplateProvider, Tuple2<ApiStatus, int>>(
      selector: (_, agentTemplateProvider) => Tuple2(agentTemplateProvider.catalogueStatus, agentTemplateProvider.catalogueResponse?.productDetails?.data?.length ?? 0),
      builder: (context, value, child) {
        if (agentTemplateProvider.catalogueStatus == ApiStatus.loading) {
          return const CircularProgressIndicator();
        }
        if (agentTemplateProvider.catalogueStatus == ApiStatus.error) {
          return Text(AppLocalizations.of(context)?.errorLoadingCatalogue ?? "Error loading catalogue", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red));
        }
        if (value.item2 == 0) {
          return Text(AppLocalizations.of(context)?.noProductsFound ?? "No products found", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red));
        }

        final products = agentTemplateProvider.catalogueResponse?.productDetails?.data ?? [];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  mpmButton?.addMPMAttributes();
                },
                label: Text(AppLocalizations.of(context)?.addCategory ?? "Add Category"),
                icon: Icon(Icons.add),
              ),
            ),
            const SizedBox(height: 8),
            if (mpmButton != null)
              ValueListenableBuilder<int>(
                valueListenable: mpmButton!.mpmAttributesNotifier,
                builder: (context, _, __) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final attr = mpmButton!.mpmAttributes[index];
                      return _MPMCategoryCard(
                        attr: attr,
                        index: index,
                        products: products,
                        onRemove: attr.isExternallyAdded ? () => mpmButton!.removeMPMAttributes(index) : null,
                        backgroundColor: widget.backgroundColor,
                        mpmButton: mpmButton!,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemCount: mpmButton?.mpmAttributes.length ?? 0,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

/// An expandable card for each MPM category with a category text field,
/// a multi-select product dropdown, and a product details table.
class _MPMCategoryCard extends StatefulWidget {
  final MPMAttributes attr;
  final int index;
  final List<ProductDetailsDatum> products;
  final VoidCallback? onRemove;
  final Color backgroundColor;
  final TemplateButton mpmButton;
  const _MPMCategoryCard({required this.attr, required this.index, required this.products, this.onRemove, required this.backgroundColor, required this.mpmButton});
  @override
  State<_MPMCategoryCard> createState() => _MPMCategoryCardState();
}

class _MPMCategoryCardState extends State<_MPMCategoryCard> {
  final GlobalKey<FormFieldState<List<ProductDetailsDatum>>> _productFieldKey = GlobalKey<FormFieldState<List<ProductDetailsDatum>>>();

  @override
  void initState() {
    super.initState();
    // Listen for product selection changes to revalidate the FormField
    widget.attr.selectedProductsNotifier.addListener(_onProductsChanged);
  }

  @override
  void dispose() {
    widget.attr.selectedProductsNotifier.removeListener(_onProductsChanged);
    super.dispose();
  }

  void _onProductsChanged() {
    _productFieldKey.currentState?.didChange(widget.attr.selectedProductsNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormField<List<ProductDetailsDatum>>(
      key: _productFieldKey,
      initialValue: widget.attr.selectedProductsNotifier.value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)?.selectAtLeastOneProduct ?? 'Please select at least one product';
        }
        return null;
      },
      builder: (FormFieldState<List<ProductDetailsDatum>> fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: fieldState.hasError ? Colors.red : Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: ExpansionTile(
                initiallyExpanded: false,
                tilePadding: EdgeInsets.symmetric(horizontal: 10),
                childrenPadding: EdgeInsets.zero,
                shape: Border.all(color: widget.backgroundColor),
                collapsedShape: Border.all(color: widget.backgroundColor),
                dense: true,
                backgroundColor: widget.backgroundColor,
                collapsedBackgroundColor: widget.backgroundColor,
                title: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: widget.attr.categoryController,
                        decoration: InputDecoration(hintText: AppLocalizations.of(context)?.categoryName ?? 'Category Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)?.thisFieldIsRequired ?? 'Category name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (widget.onRemove != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: widget.onRemove,
                          tooltip: AppLocalizations.of(context)?.removeCategory ?? 'Remove category',
                        ),
                      ),
                  ],
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Multi-select products dropdown ──
                        Row(
                          children: [
                            Text(AppLocalizations.of(context)?.products ?? "Products", style: theme.textTheme.bodyMedium),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ValueListenableBuilder<List<ProductDetailsDatum>>(
                                valueListenable: widget.attr.selectedProductsNotifier,
                                builder: (context, value, child) {
                                  //

                                  List<MultiSelectItem<String>> items = widget.products.map((p) => MultiSelectItem(value: p.id ?? '', label: p.name ?? p.id ?? '')).toList();
                                  //
                                  for (int i = 0; i < widget.mpmButton.mpmAttributes.length; i++) {
                                    if (i != widget.index) {
                                      //
                                      MPMAttributes attr = widget.mpmButton.mpmAttributes[i];
                                      List<String?> idList = attr.selectedProductsNotifier.value.map((e) => e.id).toList();

                                      items.removeWhere((item) => idList.contains(item.value));
                                    }
                                  }

                                  return MultiSelectDropdown<String>(
                                    items: items,
                                    initialValues: widget.attr.selectedProductsNotifier.value.map((p) => p.id ?? '').toList(),
                                    hintText: AppLocalizations.of(context)?.selectProduct ?? 'Select Product',
                                    isSearchEnabled: true,
                                    onChanged: (selectedIds) {
                                      final selected = widget.products.where((p) => selectedIds.contains(p.id)).toList();
                                      widget.attr.selectedProductsNotifier.value = selected;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // ── Selected products table ──
                        ValueListenableBuilder<List<ProductDetailsDatum>>(
                          valueListenable: widget.attr.selectedProductsNotifier,
                          builder: (context, selectedProducts, _) {
                            if (selectedProducts.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: DataTable(
                                  headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
                                  columnSpacing: 24,
                                  horizontalMargin: 16,
                                  dataRowHeight: 100,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        AppLocalizations.of(context)?.productName ?? 'product Name',
                                        style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(AppLocalizations.of(context)?.description ?? 'Description', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text(AppLocalizations.of(context)?.availability ?? 'Availability', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                  rows: selectedProducts.map((product) {
                                    return DataRow(cells: [DataCell(Text(product.name ?? '')), DataCell(Text(product.description ?? '')), DataCell(Text(product.availability ?? ''))]);
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 6),
                child: Text(fieldState.errorText!, style: TextStyle(color: Colors.red, fontSize: 12)),
              ),
          ],
        );
      },
    );
  }
}
