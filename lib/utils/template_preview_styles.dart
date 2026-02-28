import 'package:flutter/material.dart';

/// Shared styles for template preview display - used in agenttemplate
/// preview AND in all chat views (My Chats, Live, Pending, Closed, Missed).
class TemplatePreviewStyles {
  TemplatePreviewStyles._();

  static const double cardBorderRadius = 8;
  static const double cardPadding = 10;
  static const double cardHorizontalMargin = 15;
  static const double contentHorizontalPadding = 14;
  static const double contentVerticalPadding = 12;
  static const double sectionSpacing = 10;
  static const double buttonBorderRadius = 6;
  static const double buttonVerticalPadding = 10;
  static const double buttonHorizontalPadding = 16;
  static const double buttonSpacing = 8;
  static const Color cardBackgroundColor = Colors.white;
  static const Color buttonBackgroundColor = Colors.white;
  static const Color buttonTextColor = Color(0xFF1B70D3);

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12,
          offset: const Offset(0, 2),
        ),
      ];

  static BoxDecoration get cardDecoration => BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: cardShadow,
      );
}
