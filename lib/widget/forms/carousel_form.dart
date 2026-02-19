import 'dart:convert';
import 'dart:developer';

import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/models/file_object_model.dart';
import 'package:agenttemplate/widget/forms/body_form.dart';
import 'package:agenttemplate/widget/forms/buttons_form.dart';
import 'package:agenttemplate/widget/forms/header_form.dart';
import 'package:agenttemplate/models/file_upload_response.dart';
import 'package:collection/collection.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

class CarouselForm extends StatefulWidget {
  final Component carouselComponent;
  final Color backgroundColor;
  final Map<String, dynamic> predefinedAttributes;
  final String? fileObject;
  final Future<FileUploadResponse?> Function(XFile file)? onFileUpload;
  final String templateType;
  final String shortBaseUrl;

  final ValueNotifier<bool> isSmartUrlEnabled;
  const CarouselForm({
    super.key,
    required this.carouselComponent,
    required this.backgroundColor,
    required this.predefinedAttributes,
    this.fileObject,
    this.onFileUpload,
    required this.templateType,
    required this.isSmartUrlEnabled,
    required this.shortBaseUrl,
  });

  @override
  State<CarouselForm> createState() => _CarouselFormState();
}

class _CarouselFormState extends State<CarouselForm> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<GlobalKey<FormState>> _cardFormKeys;
  final ValueNotifier<Set<int>> _errorCards = ValueNotifier<Set<int>>({});

  List<CarouselCard> get _cards => widget.carouselComponent.cards ?? [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _cards.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _cardFormKeys = List.generate(_cards.length, (_) => GlobalKey<FormState>());
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  void _validateAllCards() {
    final errors = <int>{};
    for (int i = 0; i < _cards.length; i++) {
      final isValid = _cardFormKeys[i].currentState?.validate() ?? true;
      if (!isValid) errors.add(i);
    }
    _errorCards.value = errors;
  }

  bool get _isProductCardCarousel => widget.templateType == 'PRODUCTCARDCAROUSEL';

  static const int _maxCards = 10;

  void _addCard() {
    if (_cards.isEmpty || _cards.length >= _maxCards) return;

    final templateCard = _cards.first;

    widget.carouselComponent.cards?.add(CarouselCard.fromJson(templateCard.toJson(), isAddedExternally: true));

    _rebuildTabController(_cards.length - 1);
  }

  void _removeCard(int index) {
    if (index < 0 || index >= _cards.length) return;
    if (!_cards[index].isAddedExternally) return;

    widget.carouselComponent.cards!.removeAt(index);
    _cardFormKeys.removeAt(index);

    final newIndex = index.clamp(0, _cards.length - 1);
    _rebuildTabController(newIndex);
  }

  void _rebuildTabController(int newIndex) {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();

    _tabController = TabController(length: _cards.length, vsync: this, initialIndex: newIndex);
    _tabController.addListener(_onTabChanged);

    if (_cardFormKeys.length < _cards.length) {
      _cardFormKeys.add(GlobalKey<FormState>());
    }

    setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _errorCards.dispose();
    super.dispose();
  }

  String? getFileObject(int index) {
    if (widget.fileObject == null) return null;
    final fileObjects = FileObjectHelper.parseFileObjects(widget.fileObject);

    if (fileObjects.runtimeType == List<FileObject>) {
      if (index < fileObjects.length) {
        return jsonEncode(fileObjects[index].toJson());
      }
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_cards.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hidden FormField that hooks into the parent Form.validate()
        // to trigger per-card validation and update error tabs.
        FormField<bool>(
          builder: (_) => const SizedBox.shrink(),
          validator: (_) {
            _validateAllCards();
            return _errorCards.value.isNotEmpty ? '' : null;
          },
        ),

        Column(
          children: [
            ValueListenableBuilder<Set<int>>(
              valueListenable: _errorCards,
              builder: (context, errorIndices, _) {
                final tabBar = TabBar(
                  controller: _tabController,
                  isScrollable: _isProductCardCarousel || _cards.length > 3,
                  tabAlignment: (_isProductCardCarousel || _cards.length > 3) ? TabAlignment.start : TabAlignment.fill,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  tabs: List.generate(_cards.length, (index) {
                    final hasError = errorIndices.contains(index);
                    final card = _cards[index];
                    final textStyle = hasError ? const TextStyle(color: Colors.red, fontWeight: FontWeight.bold) : null;

                    if (card.isAddedExternally) {
                      return Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Card ${index + 1}", style: textStyle),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => _removeCard(index),
                              child: const Icon(Icons.close, size: 16, color: Colors.red),
                            ),
                          ],
                        ),
                      );
                    }

                    return Tab(child: Text("Card ${index + 1}", style: textStyle));
                  }),
                );

                if (!_isProductCardCarousel) return tabBar;

                return Row(
                  children: [
                    Expanded(child: tabBar),
                    if (_cards.length < _maxCards) ...[const SizedBox(width: 5), ElevatedButton(onPressed: _addCard, child: Text("Add Card"))],
                  ],
                );
              },
            ),
            // All cards stay in the tree via Offstage so their fields
            // participate in per-card Form.validate().
            ...List.generate(_cards.length, (index) {
              return Offstage(
                offstage: index != _tabController.index,
                child: Form(
                  key: _cardFormKeys[index],
                  child: _CarouselCardContent(
                    card: _cards[index],
                    backgroundColor: widget.backgroundColor,
                    predefinedAttributes: widget.predefinedAttributes,
                    fileObject: getFileObject(index),
                    onFileUpload: widget.onFileUpload,
                    templateType: widget.templateType,
                    isSmartUrlEnabled: widget.isSmartUrlEnabled,
                    shortBaseUrl: widget.shortBaseUrl,
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------

class _CarouselCardContent extends StatelessWidget {
  final CarouselCard card;
  final Color backgroundColor;
  final Map<String, dynamic> predefinedAttributes;
  final String? fileObject;
  final Future<FileUploadResponse?> Function(XFile file)? onFileUpload;
  final String templateType;
  final String shortBaseUrl;
  final ValueNotifier<bool> isSmartUrlEnabled;
  const _CarouselCardContent({
    required this.card,
    required this.backgroundColor,
    required this.predefinedAttributes,
    this.fileObject,
    this.onFileUpload,
    required this.templateType,
    required this.isSmartUrlEnabled,
    required this.shortBaseUrl,
  });

  void onBodyTextChanged() {
    //
    //
    Component? bodyComponent = card.components.firstWhereOrNull((element) => element.type == 'BODY');
    if (bodyComponent?.attributes.isNotEmpty ?? false) {
      //
      Component? buttonComponent = card.components.firstWhereOrNull((element) => element.type == 'BUTTONS');
      if (buttonComponent != null) {
        //
        TemplateButton? urlButton = buttonComponent.buttons?.firstWhereOrNull((element) => element.type == "URL");
        if (urlButton != null) {
          //
          urlButton.buttonTextController.text = bodyComponent?.attributes.firstWhere((element) => element.selectedVariableValue.value != null).selectedVariableValue.value ?? '';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final headerComponent = card.components.firstWhereOrNull((c) => c.type == 'HEADER');
    final bodyComponent = card.components.firstWhereOrNull((c) => c.type == 'BODY');
    final buttonsComponent = card.components.firstWhereOrNull((c) => c.type == 'BUTTONS');

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headerComponent != null) ...[
            HeaderForm(headerComponent: headerComponent, backgroundColor: backgroundColor, predefinedAttributes: predefinedAttributes, fileObject: fileObject, onFileUpload: onFileUpload),
            const SizedBox(height: 10),
          ],
          if (bodyComponent != null) ...[
            BodyForm(
              bodyComponent: bodyComponent,
              backgroundColor: backgroundColor,
              predefinedAttributes: predefinedAttributes,
              isSmartUrlEnabled: isSmartUrlEnabled,
              templateType: templateType,
              onTextChanged: onBodyTextChanged,
            ),
            const SizedBox(height: 10),
          ],
          if (buttonsComponent != null) ...[ButtonsForm(buttonsComponent: buttonsComponent, backgroundColor: backgroundColor, templateType: templateType, shortBaseUrl: shortBaseUrl)],
        ],
      ),
    );
  }
}
