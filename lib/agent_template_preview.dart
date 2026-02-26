import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:agenttemplate/utils/app_assets.dart';
import 'package:agenttemplate/utils/app_enums.dart';
import 'package:agenttemplate/utils/form_styles.dart';
import 'package:agenttemplate/widget/preview/button_preview.dart';
import 'package:agenttemplate/widget/preview/card_preview_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgentTemplatePreview extends StatefulWidget {
  final String accountName;
  final String accountImage;
  final String accountPhone;
  final bool accountIsVerified;
  final TemplateObj templateObj;
  final void Function(TemplateButton button)? onButtonTap;
  final void Function(Component buttonsComponent)? onAllButtonsTap;
  final void Function(ListObj listObj)? onListTap;
  final VoidCallback onBackPressed;
  final SendTemplateType sendTemplateType;
  const AgentTemplatePreview({
    super.key,
    required this.templateObj,
    required this.accountName,
    required this.accountImage,
    required this.accountPhone,
    required this.accountIsVerified,
    required this.sendTemplateType,
    this.onButtonTap,
    this.onAllButtonsTap,
    this.onListTap,
    required this.onBackPressed,
  });

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
                child: CardPreviewWidget(components: otherComponents, accountName: widget.accountName),
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

  Widget _buildAccountInfo() {
    return Container(
      height: kToolbarHeight,
      color: FormStyles.whatsappGreen,
      child: Row(
        children: [
          BackButton(
            onPressed: widget.onBackPressed,
            color: Colors.white,
            style: ButtonStyle(
              iconSize: WidgetStateProperty.all(24),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              minimumSize: WidgetStateProperty.all(const Size(40, 40)),
            ),
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            backgroundImage: widget.accountImage.isNotEmpty ? NetworkImage(widget.accountImage) : null,
            child: widget.accountImage.isEmpty ? Icon(Icons.person, color: FormStyles.whatsappGreen, size: 28) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.accountName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.accountIsVerified) ...[
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        AppAssets.verificationBadge,
                        package: AppAssets.packageName,
                        width: 20,
                        height: 20,
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  widget.accountPhone,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 24),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          _buildAccountInfo(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        AppAssets.backgroundImage,
                        package: AppAssets.packageName,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            //shrinkWrap: true,
                            child: _buildCard(),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: SvgPicture.asset(
                                AppAssets.wFooter,
                                package: AppAssets.packageName,
                                fit: BoxFit.contain,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
          color: Colors.grey.shade700.withValues(alpha: 0.3),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
