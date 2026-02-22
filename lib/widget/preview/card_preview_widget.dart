import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:agenttemplate/widget/preview/body_preview.dart';
import 'package:agenttemplate/widget/preview/footer_preview.dart';
import 'package:agenttemplate/widget/preview/header_preview.dart';
import 'package:agenttemplate/widget/preview/limited_offer_preview.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CardPreviewWidget extends StatefulWidget {
  final List<Component> components;
  const CardPreviewWidget({
    super.key,
    required this.components,
  });

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

    return CardComponent(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          FooterPreview(footerComponent: footerComponent)
        ],
      ),
    );
  }
}

class CardComponent extends StatelessWidget {
  final Widget child;
  const CardComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}
