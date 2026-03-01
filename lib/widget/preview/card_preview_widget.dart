import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:agenttemplate/utils/template_preview_styles.dart';
import 'package:agenttemplate/widget/preview/body_preview.dart';
import 'package:agenttemplate/widget/preview/footer_preview.dart';
import 'package:agenttemplate/widget/preview/header_preview.dart';
import 'package:agenttemplate/widget/preview/limited_offer_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardPreviewWidget extends StatefulWidget {
  final List<Component> components;
  final String accountName;
  final bool displayTime;
  const CardPreviewWidget({super.key, required this.components, required this.accountName, required this.displayTime});

  @override
  State<CardPreviewWidget> createState() => _CardPreviewWidgetState();
}

class _CardPreviewWidgetState extends State<CardPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    List<Component> components = widget.components;
    Component? headerComponent = components.firstWhereOrNull((element) => element.type == 'HEADER');
    Component? bodyComponent = components.firstWhereOrNull((element) => element.type == 'BODY');
    Component? limitedTimeOfferComponent = components.firstWhereOrNull((element) => element.type == 'limited_time_offer');
    Component? footerComponent = components.firstWhereOrNull((element) => element.type == 'FOOTER');
    TemplateButton? catalogButton = components.firstWhereOrNull((element) => element.type == 'BUTTONS')?.buttons?.firstWhereOrNull(
          (element) => element.type == "CATALOG",
        );

    return CardComponent(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (catalogButton != null) ...[
            CatalogPreview(catalogButton: catalogButton, accountName: widget.accountName),
          ],
          if (headerComponent != null) ...[
            HeaderPreview(headerComponent: headerComponent),
          ],
          if (limitedTimeOfferComponent != null) ...[
            LimitedOfferPreview(limitedTimeOfferComponent: limitedTimeOfferComponent),
          ],
          if (bodyComponent != null) ...[
            BodyPreview(bodyComponent: bodyComponent),
          ],
          const SizedBox(height: 5),
          FooterPreview(footerComponent: footerComponent, displayTime: widget.displayTime)
        ],
      ),
    );
  }
}

class CatalogPreview extends StatelessWidget {
  final TemplateButton catalogButton;
  final String accountName;
  const CatalogPreview({super.key, required this.catalogButton, required this.accountName});
  final double cardHeight = 150;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: catalogButton.selectedProduct,
      builder: (context, value, child) {
        if (catalogButton.selectedProduct.value == null) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: cardHeight,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: value?.imageUrl ?? "",
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        CupertinoIcons.photo,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "View $accountName's Catalog on WhatsApp",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3),
                    Text("Browse pictures and details of their offerings.", style: Theme.of(context).textTheme.bodySmall)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CardComponent extends StatelessWidget {
  final Widget child;
  const CardComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: TemplatePreviewStyles.cardHorizontalMargin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemplatePreviewStyles.cardBorderRadius),
      ),
      color: TemplatePreviewStyles.cardBackgroundColor,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TemplatePreviewStyles.cardBorderRadius),
        ),
        padding: EdgeInsets.all(TemplatePreviewStyles.cardPadding),
        child: child,
      ),
    );
  }
}
