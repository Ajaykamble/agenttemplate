import 'package:flutter/material.dart';

/// A single item in the [MultiSelectDropdown].
class MultiSelectItem<T> {
  final T value;
  final String label;

  const MultiSelectItem({required this.value, required this.label});

  @override
  bool operator ==(Object other) => identical(this, other) || other is MultiSelectItem<T> && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// A dropdown widget that supports selecting multiple items.
///
/// Displays selected items as chips with an overflow indicator ("+ N more").
/// The dropdown list shows checkboxes next to each option.
///
/// ```dart
/// MultiSelectDropdown<String>(
///   items: [
///     MultiSelectItem(value: 'a', label: 'Apple'),
///     MultiSelectItem(value: 'b', label: 'Banana'),
///   ],
///   initialValues: ['a'],
///   hintText: 'Select fruits',
///   onChanged: (selected) => print(selected),
/// )
/// ```
class MultiSelectDropdown<T> extends StatefulWidget {
  /// All available items.
  final List<MultiSelectItem<T>> items;

  /// Initially selected values (matched by [MultiSelectItem.value]).
  final List<T> initialValues;

  /// Hint text shown when nothing is selected.
  final String hintText;

  /// Called whenever the selection changes.
  final ValueChanged<List<T>>? onChanged;

  /// Maximum number of chips visible before the "+ N more" label is shown.
  final int maxVisibleChips;

  /// Optional validator for form integration.
  final FormFieldValidator<List<T>>? validator;

  /// Decoration applied to the outer container. When `null` a sensible
  /// default is used.
  final InputDecoration? decoration;

  /// Whether the dropdown is enabled.
  final bool enabled;

  /// When `true`, a "Select All" option is shown at the top of the dropdown.
  final bool isSelectAllEnabled;

  /// When `true`, a search field is shown at the top of the dropdown.
  final bool isSearchEnabled;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    this.initialValues = const [],
    this.hintText = 'Select',
    this.onChanged,
    this.maxVisibleChips = 1,
    this.validator,
    this.decoration,
    this.enabled = true,
    this.isSelectAllEnabled = false,
    this.isSearchEnabled = true,
  });

  @override
  State<MultiSelectDropdown<T>> createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late List<T> _selectedValues;
  late List<T> _pendingValues;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedValues = List<T>.from(widget.initialValues);
    _pendingValues = List<T>.from(_selectedValues);
  }

  @override
  void didUpdateWidget(covariant MultiSelectDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValues != oldWidget.initialValues) {
      _selectedValues = List<T>.from(widget.initialValues);
      _pendingValues = List<T>.from(_selectedValues);
    }
  }

  @override
  void dispose() {
    // Clean up overlay directly without calling setState (which is invalid
    // during dispose — the element is already defunct even though `mounted`
    // still reports true at this point).
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Overlay management
  // ---------------------------------------------------------------------------

  void _toggleOverlay() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _pendingValues = List<T>.from(_selectedValues);
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => _DropdownOverlay<T>(
        link: _layerLink,
        targetWidth: size.width,
        items: widget.items,
        selectedValues: _pendingValues,
        onItemToggled: _onItemToggled,
        onDismiss: _removeOverlay,
        isSelectAllEnabled: widget.isSelectAllEnabled,
        onSelectAll: _onSelectAll,
        isSearchEnabled: widget.isSearchEnabled,
      ),
    );

    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOpen = false);
  }

  // ---------------------------------------------------------------------------
  // Callbacks
  // ---------------------------------------------------------------------------

  void _onItemToggled(T value) {
    setState(() {
      if (_pendingValues.contains(value)) {
        _pendingValues.remove(value);
      } else {
        _pendingValues.add(value);
      }
      _selectedValues = List<T>.from(_pendingValues);
    });
    _overlayEntry?.markNeedsBuild();
    widget.onChanged?.call(List<T>.unmodifiable(_selectedValues));
  }

  void _onSelectAll() {
    final allValues = widget.items.map((item) => item.value).toList();
    final allSelected = allValues.every((v) => _pendingValues.contains(v));
    setState(() {
      if (allSelected) {
        _pendingValues.clear();
      } else {
        _pendingValues = List<T>.from(allValues);
      }
      _selectedValues = List<T>.from(_pendingValues);
    });
    _overlayEntry?.markNeedsBuild();
    widget.onChanged?.call(List<T>.unmodifiable(_selectedValues));
  }

  void _onClear() {
    _pendingValues.clear();
    _selectedValues.clear();
    widget.onChanged?.call(List<T>.unmodifiable(_selectedValues));
    _removeOverlay();
  }

  void _removeChip(T value) {
    setState(() {
      _selectedValues.remove(value);
      _pendingValues.remove(value);
    });
    widget.onChanged?.call(List<T>.unmodifiable(_selectedValues));
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _labelFor(T value) {
    return widget.items
        .firstWhere(
          (item) => item.value == value,
          orElse: () => MultiSelectItem(value: value, label: value.toString()),
        )
        .label;
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget fieldContent;

    if (_selectedValues.isEmpty) {
      fieldContent = Text(widget.hintText, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey));
    } else {
      final visible = _selectedValues.take(widget.maxVisibleChips).toList();
      final remaining = _selectedValues.length - visible.length;

      fieldContent = Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                for (final val in visible)
                  Chip(
                    label: Text(_labelFor(val), style: theme.textTheme.bodySmall),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: widget.enabled ? () => _removeChip(val) : null,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                if (remaining > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 2, top: 4),
                    child: Text('+ $remaining more', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
                  ),
              ],
            ),
          ),
        ],
      );
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: FormField<List<T>>(
        validator: widget.validator != null ? (_) => widget.validator!(_selectedValues) : null,
        builder: (formState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: widget.enabled ? _toggleOverlay : null,
                borderRadius: BorderRadius.circular(8),
                child: InputDecorator(
                  decoration: (widget.decoration ?? const InputDecoration()).copyWith(
                    hintText: widget.hintText,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                    ),
                    errorText: formState.errorText,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_selectedValues.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: widget.enabled ? _onClear : null,
                            splashRadius: 18,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          ),
                        Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  child: fieldContent,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// Dropdown overlay (the floating list with checkboxes)
// =============================================================================

class _DropdownOverlay<T> extends StatefulWidget {
  final LayerLink link;
  final double targetWidth;
  final List<MultiSelectItem<T>> items;
  final List<T> selectedValues;
  final ValueChanged<T> onItemToggled;
  final VoidCallback onDismiss;
  final bool isSelectAllEnabled;
  final VoidCallback? onSelectAll;
  final bool isSearchEnabled;

  const _DropdownOverlay({
    required this.link,
    required this.targetWidth,
    required this.items,
    required this.selectedValues,
    required this.onItemToggled,
    required this.onDismiss,
    this.isSelectAllEnabled = false,
    this.onSelectAll,
    this.isSearchEnabled = true,
  });

  @override
  State<_DropdownOverlay<T>> createState() => _DropdownOverlayState<T>();
}

class _DropdownOverlayState<T> extends State<_DropdownOverlay<T>> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MultiSelectItem<T>> get _filteredItems {
    if (_searchQuery.isEmpty) return widget.items;
    final query = _searchQuery.toLowerCase();
    return widget.items.where((item) => item.label.toLowerCase().contains(query)).toList();
  }

  Widget _buildSelectAllRow(ThemeData theme) {
    final allSelected = widget.items.every((item) => widget.selectedValues.contains(item.value));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: widget.onSelectAll,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(value: allSelected, onChanged: (_) => widget.onSelectAll?.call(), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text('Select All', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredItems = _filteredItems;

    return Stack(
      children: [
        // Dismiss on tap outside
        Positioned.fill(
          child: GestureDetector(behavior: HitTestBehavior.translucent, onTap: widget.onDismiss),
        ),

        // The dropdown itself
        CompositedTransformFollower(
          link: widget.link,
          showWhenUnlinked: false,
          offset: const Offset(0, 4),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widget.targetWidth, minWidth: widget.targetWidth, maxHeight: 320),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search field
                  if (widget.isSearchEnabled) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search, size: 20),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        onChanged: (value) => setState(() => _searchQuery = value),
                      ),
                    ),
                    const Divider(height: 1),
                  ],

                  // Select All option
                  if (widget.isSelectAllEnabled && filteredItems.isNotEmpty) _buildSelectAllRow(theme),

                  // Items list
                  Flexible(
                    child: filteredItems.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('No items found', style: TextStyle(color: Colors.grey)),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              final item = filteredItems[index];
                              final isSelected = widget.selectedValues.contains(item.value);
                              return InkWell(
                                onTap: () => widget.onItemToggled(item.value),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                          value: isSelected,
                                          onChanged: (_) => widget.onItemToggled(item.value),
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(item.label, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
