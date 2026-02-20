import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/provider/agent_template_provider.dart';
import 'package:agenttemplate/utils/form_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LimitedTimeOfferForm extends StatefulWidget {
  final Component limitedTimeOfferComponent;
  final Color backgroundColor;
  const LimitedTimeOfferForm({super.key, required this.limitedTimeOfferComponent, required this.backgroundColor});

  @override
  State<LimitedTimeOfferForm> createState() => _LimitedTimeOfferFormState();
}

class _LimitedTimeOfferFormState extends State<LimitedTimeOfferForm> {
  late AgentTemplateProvider _provider;
  DateTime _selectedDate = DateTime.now();
  int _selectedHour = DateTime.now().hour;
  int _selectedMinute = DateTime.now().minute;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<AgentTemplateProvider>(context, listen: false);
    _provider.getDateTime();
  }

  String _formatDateTime() {
    final dt = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedHour, _selectedMinute);

    return DateFormat("MM/dd/yyyy hh:mm a").format(dt);
  }

  void _updateComponent() {
    final formatted = _formatDateTime();
    widget.limitedTimeOfferComponent.offerExpiryDateController.text = formatted;
    widget.limitedTimeOfferComponent.selectedOfferExpiryDateTime.value = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedHour,
      _selectedMinute,
    );
  }

  Future<void> _showDateTimePicker() async {
    final minDateTime = _provider.dateTimeResponse?.dateTime ?? DateTime.now();

    final result = await showDialog<DateTime>(
      context: context,
      builder: (context) => _DateTimePickerDialog(initialDate: _selectedDate, initialHour: _selectedHour, initialMinute: _selectedMinute, minDateTime: minDateTime),
    );

    if (result != null) {
      setState(() {
        _selectedDate = DateTime(result.year, result.month, result.day);
        _selectedHour = result.hour;
        _selectedMinute = result.minute;
        _updateComponent();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lto = widget.limitedTimeOfferComponent.limitedTimeOffer;
    if (lto == null || !lto.hasExpiration) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Offer Expiry Date:", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
        const SizedBox(height: 8),
        Selector<AgentTemplateProvider, ApiStatus>(
          selector: (_, p) => p.dateTimeStatus,
          builder: (context, status, child) {
            if (status == ApiStatus.loading) {
              return const Center(
                child: Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator()),
              );
            }
            if (status == ApiStatus.error) {
              return Text("Failed to load date/time", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red));
            }
            return TextFormField(
              controller: widget.limitedTimeOfferComponent.offerExpiryDateController,
              readOnly: true,
              onTap: _showDateTimePicker,
              decoration: FormStyles.buildInputDecoration(
                context,
                hintText: "(Required)",
                suffixIcon: Icon(Icons.calendar_month, color: Colors.grey.shade600, size: 20),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }
}

class _DateTimePickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final int initialHour;
  final int initialMinute;
  final DateTime minDateTime;

  const _DateTimePickerDialog({required this.initialDate, required this.initialHour, required this.initialMinute, required this.minDateTime});

  @override
  State<_DateTimePickerDialog> createState() => _DateTimePickerDialogState();
}

class _DateTimePickerDialogState extends State<_DateTimePickerDialog> {
  late DateTime _selectedDate;
  late int _selectedHour;
  late int _selectedMinute;
  late ScrollController _timeScrollController;

  static const double _kTimeItemHeight = 40.0;
  static const double _kTimeListHeight = 160.0;

  DateTime get _minDateOnly => DateTime(widget.minDateTime.year, widget.minDateTime.month, widget.minDateTime.day);

  bool get _isSelectedDateMinDate => _selectedDate.year == _minDateOnly.year && _selectedDate.month == _minDateOnly.month && _selectedDate.day == _minDateOnly.day;

  int get _selectedTimeIndex => _selectedHour * 60 + _selectedMinute;

  bool _isTimeDisabled(int hour, int minute) {
    if (!_isSelectedDateMinDate) return false;
    final minTotal = widget.minDateTime.hour * 60 + widget.minDateTime.minute;
    return (hour * 60 + minute) < minTotal;
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _selectedHour = widget.initialHour;
    _selectedMinute = widget.initialMinute;
    _clampTimeIfNeeded();
    _timeScrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_timeScrollController.hasClients) return;
      final offset = (_selectedTimeIndex * _kTimeItemHeight) - (_kTimeListHeight / 2) + (_kTimeItemHeight / 2);
      _timeScrollController.jumpTo(offset.clamp(0.0, _timeScrollController.position.maxScrollExtent));
    });
  }

  void _clampTimeIfNeeded() {
    if (_isSelectedDateMinDate && _isTimeDisabled(_selectedHour, _selectedMinute)) {
      _selectedHour = widget.minDateTime.hour;
      _selectedMinute = widget.minDateTime.minute;
    }
  }

  @override
  void dispose() {
    _timeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final maxDialogHeight = mq.size.height * 0.85;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400, maxHeight: maxDialogHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CalendarDatePicker(
              initialDate: _selectedDate.isBefore(_minDateOnly) ? _minDateOnly : _selectedDate,
              firstDate: _minDateOnly,
              lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
              onDateChanged: (date) {
                setState(() {
                  _selectedDate = date;
                  _clampTimeIfNeeded();
                });
              },
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text("Time", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const Divider(height: 1),
            SizedBox(
              height: _kTimeListHeight,
              child: ListView.builder(
                controller: _timeScrollController,
                itemCount: 24 * 60,
                itemExtent: _kTimeItemHeight,
                itemBuilder: (context, index) {
                  final hour = index ~/ 60;
                  final minute = index % 60;
                  final isSelected = hour == _selectedHour && minute == _selectedMinute;
                  final disabled = _isTimeDisabled(hour, minute);
                  final timeStr = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';

                  return InkWell(
                    onTap: disabled
                        ? null
                        : () {
                            setState(() {
                              _selectedHour = hour;
                              _selectedMinute = minute;
                            });
                          },
                    child: Container(
                      alignment: Alignment.center,
                      color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
                      child: Text(
                        timeStr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: disabled
                                  ? Colors.grey.shade400
                                  : isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey.shade700,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedHour, _selectedMinute));
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
