import 'dart:developer';

import 'package:agenttemplate/models/catalogue_response_model.dart';
import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:agenttemplate/provider/agent_template_provider.dart';
import 'package:agenttemplate/utils/form_styles.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CatalogForm extends StatefulWidget {
  //final TemplateObj templateObj;
  final Component component;
  const CatalogForm({super.key, required this.component});

  @override
  State<CatalogForm> createState() => _CatalogFormState();
}

class _CatalogFormState extends State<CatalogForm> {
  late AgentTemplateProvider agentTemplateProvider;

  @override
  void initState() {
    super.initState();
    agentTemplateProvider = Provider.of<AgentTemplateProvider>(context, listen: false);
    agentTemplateProvider.getCatalogue();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Select Thumbnail Product ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF64748B)), // Light blue/grey
              ),
              TextSpan(
                text: "*",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Selector<AgentTemplateProvider, Tuple2<ApiStatus, int>>(
          selector: (_, agentTemplateProvider) => Tuple2(agentTemplateProvider.catalogueStatus, agentTemplateProvider.catalogueResponse?.productDetails?.data?.length ?? 0),
          builder: (context, value, child) {
            if (agentTemplateProvider.catalogueStatus == ApiStatus.loading) {
              return const CircularProgressIndicator();
            }
            if (agentTemplateProvider.catalogueStatus == ApiStatus.error) {
              return Text("Error loading catalogue", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red));
            }
            if (value.item2 == 0) {
              return Text("No products found", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red));
            }

            TemplateButton? catalogButton = widget.component.buttons?.firstWhereOrNull((element) => element.type == "CATALOG");

            if (catalogButton == null) {
              return SizedBox();
            }
            return ValueListenableBuilder<ProductDetailsDatum?>(
              valueListenable: catalogButton.selectedProduct,
              builder: (context, selectedValue, child) {
                return DropdownButtonFormField2<ProductDetailsDatum>(
                  value: selectedValue,
                  decoration: FormStyles.buildInputDecoration(context, hintText: 'Select'),
                  items: (agentTemplateProvider.catalogueResponse?.productDetails?.data ?? [])
                      .map((product) => DropdownMenuItem<ProductDetailsDatum>(value: product, child: Text(product.name ?? product.id ?? '')))
                      .toList(),
                  onChanged: (value) {
                    catalogButton.selectedProduct.value = value;
                  },
                  dropdownStyleData: FormStyles.buildDropdownStyleData(context),
                  menuItemStyleData: FormStyles.buildMenuItemStyleData(context),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a thumbnail product';
                    }
                    return null;
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
