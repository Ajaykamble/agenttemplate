import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:agenttemplate/widget/preview/button_preview.dart';
import 'package:agenttemplate/widget/preview/card_preview_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardPreview extends StatefulWidget {
  final TemplateObj templateObj;
  final String accountName;
  final void Function(TemplateButton button)? onButtonTap;
  final void Function(Component buttonsComponent)? onAllButtonsTap;
  final void Function(ListObj listObj)? onListTap;
  final bool displayTime;
  const CardPreview({super.key, required this.templateObj, required this.accountName, this.onButtonTap, this.onAllButtonsTap, this.onListTap, this.displayTime = true});

  @override
  State<CardPreview> createState() => _CardPreviewState();
}

class _CardPreviewState extends State<CardPreview> {
  final ScrollController _carouselScrollController = ScrollController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  final GlobalKey _cardKey = GlobalKey();
  double _cardWidth = 0;
  double _cardHeight = 0;
  int _totalCards = 0;

  @override
  void didUpdateWidget(covariant CardPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.templateObj.id != widget.templateObj.id) {
      _currentPage.value = 0;
      _cardWidth = 0;
      _cardHeight = 0;
      _totalCards = 0;
      if (_carouselScrollController.hasClients) {
        _carouselScrollController.jumpTo(0);
      }
    }
  }

  @override
  void dispose() {
    _carouselScrollController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  void _onCarouselScroll() {
    if (_cardWidth <= 0) return;
    final page = (_carouselScrollController.offset / _cardWidth).round().clamp(0, _totalCards - 1);
    if (page != _currentPage.value) {
      _currentPage.value = page;
    }
  }

  void _scrollToPage(int page) {
    if (_cardWidth <= 0) return;
    page = page.clamp(0, _totalCards - 1);
    _carouselScrollController.animateTo(
      page * _cardWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Component> components = widget.templateObj.components ?? [];
    List<Component> otherComponents = components.where((element) => element.type != 'CAROUSEL').toList();
    Component? carouselComponent = components.firstWhereOrNull((element) => element.type == 'CAROUSEL');
    Component? buttonsComponent = components.firstWhereOrNull((element) => element.type == 'BUTTONS');
    Component? listComponent = components.firstWhereOrNull((element) => element.type == 'LIST');

    return LayoutBuilder(
      builder: (context, constraints) {
        _cardWidth = constraints.maxWidth * .85;
        // Fallback: if no components, show placeholder with min height
        if (components.isEmpty) {
          return Container(
            width: _cardWidth,
            height: 220,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'No preview available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (otherComponents.isNotEmpty) ...[
              SizedBox(
                width: _cardWidth,
                child: CardPreviewWidget(components: otherComponents, accountName: widget.accountName, displayTime: widget.displayTime),
              ),
              if (buttonsComponent != null) ...[
                const SizedBox(height: 7),
                SizedBox(
                  width: _cardWidth,
                  child: ButtonPreviews(
                    buttonsComponent: buttonsComponent,
                    onButtonTap: (component) {
                      widget.onButtonTap?.call(component);
                    },
                    onAllButtonsTap: (component) {
                      widget.onAllButtonsTap?.call(component);
                    },
                  ),
                ),
              ],
              if (listComponent != null) ...[
                const SizedBox(height: 7),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: _cardWidth,
                  child: ButtonWidget(
                    icon: CupertinoIcons.list_bullet,
                    title: listComponent.listObj?.name ?? "",
                    onTap: () {
                      //
                      if (listComponent.listObj != null) {
                        widget.onListTap?.call(listComponent.listObj!);
                      }
                    },
                  ),
                )
              ],
            ],
            if (carouselComponent != null) ...[
              if (otherComponents.isNotEmpty) ...[
                const SizedBox(height: 7),
              ],
              SizedBox(
                width: _cardWidth,
                child: ValueListenableBuilder<int>(
                  valueListenable: carouselComponent.totalCardsNotifier,
                  builder: (_, totalCards, __) {
                    final carouselCards = carouselComponent.cards ?? [];
                    if (carouselCards.isEmpty) return const SizedBox.shrink();
                    _totalCards = totalCards;
                    _carouselScrollController.removeListener(_onCarouselScroll);
                    _carouselScrollController.addListener(_onCarouselScroll);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_currentPage.value >= totalCards && totalCards > 0) {
                        _currentPage.value = totalCards - 1;
                      }
                    });
                    return ValueListenableBuilder<int>(
                      valueListenable: _currentPage,
                      builder: (context, currentPage, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final box = _cardKey.currentContext?.findRenderObject() as RenderBox?;
                          if (box != null && box.hasSize && box.size.height != _cardHeight) {
                            setState(() => _cardHeight = box.size.height);
                          }
                        });

                        return Stack(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _carouselScrollController,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(carouselCards.length, (index) {
                                  final components = carouselCards[index].components;
                                  final buttonsComponent = components.firstWhereOrNull((e) => e.type == 'BUTTONS');
                                  return SizedBox(
                                    width: _cardWidth,
                                    child: Column(
                                      children: [
                                        CardPreviewWidget(
                                          key: index == currentPage ? _cardKey : null,
                                          components: components,
                                          accountName: widget.accountName,
                                          displayTime: widget.displayTime,
                                        ),
                                        const SizedBox(height: 7),
                                        if (buttonsComponent != null) ...[
                                          ButtonPreviews(buttonsComponent: buttonsComponent),
                                        ],
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            if (totalCards > 1) ...[
                              if (_cardHeight > 0 && currentPage > 0)
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  height: _cardHeight,
                                  child: Center(
                                    child: _CarouselArrowButton(
                                      icon: Icons.arrow_left,
                                      onTap: () => _scrollToPage(currentPage - 1),
                                    ),
                                  ),
                                ),
                              if (_cardHeight > 0 && currentPage < totalCards - 1)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  height: _cardHeight,
                                  child: Center(
                                    child: _CarouselArrowButton(
                                      icon: Icons.arrow_right,
                                      onTap: () => _scrollToPage(currentPage + 1),
                                    ),
                                  ),
                                ),
                            ]
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _CarouselArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CarouselArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade700.withValues(alpha: 0.3),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
