import 'dart:developer';

import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LimitedOfferPreview extends StatelessWidget {
  final Component limitedTimeOfferComponent;

  const LimitedOfferPreview({super.key, required this.limitedTimeOfferComponent});

  static const _maxDaysForRelativeLabel = 14;
  static final _dateFormat = DateFormat('MMMM dd');

  @override
  Widget build(BuildContext context) {
    final offer = limitedTimeOfferComponent.limitedTimeOffer;
    final theme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            padding: const EdgeInsets.all(12),
            child: const Icon(Icons.local_offer_outlined, color: Colors.black, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  offer?.text ?? "",
                  style: theme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (offer?.hasExpiration == true) ...[
                  const SizedBox(height: 2),
                  _buildExpiryLabel(context, theme),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryLabel(BuildContext context, TextTheme theme) {
    return ValueListenableBuilder<DateTime?>(
      valueListenable: limitedTimeOfferComponent.selectedOfferExpiryDateTime,
      builder: (context, value, _) {
        if (value == null) return const SizedBox.shrink();

        return Text(
          _formatExpiryLabel(context, value),
          style: theme.bodySmall?.copyWith(color: Colors.black87),
        );
      },
    );
  }

  String _formatExpiryLabel(BuildContext context, DateTime expiry) {
    final now = DateTime.now();
    final today = DateUtils.dateOnly(now);
    final expiryDate = DateUtils.dateOnly(expiry);
    final daysRemaining = expiryDate.difference(today).inDays;

    if (daysRemaining < 0 || (daysRemaining == 0 && expiry.isBefore(now))) {
      return 'Offer ended';
    }

    if (daysRemaining == 0) {
      return 'Ends today at ${TimeOfDay.fromDateTime(expiry).format(context)}';
    }

    if (daysRemaining == 1) return 'Ends in 1 day';

    if (daysRemaining <= _maxDaysForRelativeLabel) {
      return 'Ends in $daysRemaining days';
    }

    return 'Ends on ${_dateFormat.format(expiry)}';
  }
}
