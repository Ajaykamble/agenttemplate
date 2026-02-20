import 'dart:developer';

import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:agenttemplate/utils/app_assets.dart';
import 'package:agenttemplate/widget/preview/button_preview.dart';
import 'package:agenttemplate/widget/preview/card_preview_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgentTemplatePreview extends StatefulWidget {
  final TemplateObj templateObj;
  const AgentTemplatePreview({super.key, required this.templateObj});

  @override
  State<AgentTemplatePreview> createState() => _AgentTemplatePreviewState();
}

class _AgentTemplatePreviewState extends State<AgentTemplatePreview> {
  final ScrollController _carouselScrollController = ScrollController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  final GlobalKey _cardKey = GlobalKey();
  double _cardWidth = 0;
  double _cardHeight = 0;
  int _totalCards = 0;

  @override
  void didUpdateWidget(covariant AgentTemplatePreview oldWidget) {
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

  Widget _buildCard() {
    List<Component> components = widget.templateObj.components ?? [];
    List<Component> otherComponents = components.where((element) => element.type != 'CAROUSEL').toList();
    List<CarouselCard> carouselCards = components.firstWhereOrNull((element) => element.type == 'CAROUSEL')?.cards ?? [];
    Component? buttonsComponent = components.firstWhereOrNull((element) => element.type == 'BUTTONS');

    return LayoutBuilder(
      builder: (context, constraints) {
        _cardWidth = constraints.maxWidth * .85;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (otherComponents.isNotEmpty) ...[
              SizedBox(
                width: _cardWidth,
                child: CardPreviewWidget(components: otherComponents),
              ),
              if (buttonsComponent != null) ...[
                const SizedBox(height: 7),
                SizedBox(width: _cardWidth, child: ButtonPreviews(buttonsComponent: buttonsComponent)),
              ],
            ],
            if (carouselCards.isNotEmpty) ...[
              if (otherComponents.isNotEmpty) ...[
                const SizedBox(height: 7),
              ],
              SizedBox(
                width: _cardWidth,
                child: Builder(
                  builder: (_) {
                    _totalCards = carouselCards.length;
                    _carouselScrollController.removeListener(_onCarouselScroll);
                    _carouselScrollController.addListener(_onCarouselScroll);
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
                              child: IntrinsicHeight(
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
                            ),
                            if (_totalCards > 1) ...[
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
                              if (_cardHeight > 0 && currentPage < _totalCards - 1)
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(height: 70, color: Colors.green),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    AppAssets.backgroundImage,
                    package: AppAssets.packageName,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: _buildCard(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: SvgPicture.asset(
                          AppAssets.wFooter,
                          package: AppAssets.packageName,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
          color: Colors.grey.shade700.withOpacity(0.3),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
