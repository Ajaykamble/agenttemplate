import 'dart:math' as math;

import 'package:agenttemplate/l10n/app_localizations.dart';
import 'package:agenttemplate/models/template_obj_model.dart';
import 'package:agenttemplate/utils/file_downloader.dart';
import 'package:agenttemplate/utils/form_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderPreview extends StatefulWidget {
  final Component headerComponent;
  const HeaderPreview({super.key, required this.headerComponent});

  @override
  State<HeaderPreview> createState() => _HeaderPreviewState();
}

class _HeaderPreviewState extends State<HeaderPreview> {
  final double cardHeight = 150;
  @override
  Widget build(BuildContext context) {
    switch (widget.headerComponent.format) {
      case "IMAGE":
        return _CommonCard(
          cardHeight: cardHeight,
          child: _ImageHeaderPreview(
            headerComponent: widget.headerComponent,
          ),
        );
      case "VIDEO":
        return _CommonCard(
          cardHeight: cardHeight,
          child: _VideoHeaderPreview(
            headerComponent: widget.headerComponent,
          ),
        );
      case "DOCUMENT":
        return _CommonCard(
          cardHeight: cardHeight,
          child: _DocumentHeaderPreview(
            headerComponent: widget.headerComponent,
          ),
        );
      case "LOCATION":
        return _CommonCard(
          cardHeight: cardHeight,
          child: _LocationHeaderPreview(
            headerComponent: widget.headerComponent,
          ),
        );
      case "PRODUCT":
        return _CommonCard(
          cardHeight: cardHeight,
          child: _ProductHeaderPreview(
            headerComponent: widget.headerComponent,
          ),
        );
      case "TEXT":
        return _TextHeaderPreview(
          headerComponent: widget.headerComponent,
        );
      default:
        return SizedBox.shrink();
    }
  }
}

class _CommonCard extends StatelessWidget {
  final Widget child;
  final double cardHeight;
  const _CommonCard({super.key, required this.child, required this.cardHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class _VideoHeaderPreview extends StatefulWidget {
  final Component headerComponent;
  const _VideoHeaderPreview({super.key, required this.headerComponent});

  @override
  State<_VideoHeaderPreview> createState() => _VideoHeaderPreviewState();
}

class _VideoHeaderPreviewState extends State<_VideoHeaderPreview> {
  bool _isDownloading = false;
  double _progress = 0.0;

  Future<void> _downloadVideo(String url) async {
    setState(() {
      _isDownloading = true;
      _progress = 0.0;
    });

    final path = await FileDownloader.downloadAndOpen(
      url: url,
      onProgress: (received, total) {
        if (total > 0 && mounted) {
          setState(() => _progress = received / total);
        }
      },
    );

    if (!mounted) return;

    setState(() => _isDownloading = false);

    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)?.downloadFailed ?? 'Download failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.headerComponent.headerFileUrlController,
      builder: (context, url, child) {
        String videoUrl = url.text;
        if (videoUrl.isEmpty) {
          return Icon(CupertinoIcons.video_camera, size: 50, color: Colors.white);
        }
        return AbsorbPointer(
          absorbing: _isDownloading,
          child: InkWell(
            onTap: () => _downloadVideo(videoUrl),
            child: _isDownloading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: _progress > 0 ? _progress : null,
                          strokeWidth: 3,
                          color: FormStyles.whatsappGreen,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _progress > 0 ? '${(_progress * 100).toInt()}%' : (AppLocalizations.of(context)?.downloading ?? 'Downloading…'),
                        style: const TextStyle(color: FormStyles.whatsappGreen, fontSize: 12),
                      ),
                    ],
                  )
                : Icon(CupertinoIcons.video_camera, size: 50, color: Colors.white),
          ),
        );
      },
    );
  }
}

class _DocumentHeaderPreview extends StatefulWidget {
  final Component headerComponent;
  const _DocumentHeaderPreview({super.key, required this.headerComponent});

  @override
  State<_DocumentHeaderPreview> createState() => _DocumentHeaderPreviewState();
}

class _DocumentHeaderPreviewState extends State<_DocumentHeaderPreview> {
  bool _isDownloading = false;

  double _progress = 0.0;

  Future<void> _downloadVideo(String url) async {
    setState(() {
      _isDownloading = true;
      _progress = 0.0;
    });

    final path = await FileDownloader.downloadAndOpen(
      url: url,
      onProgress: (received, total) {
        if (total > 0 && mounted) {
          setState(() => _progress = received / total);
        }
      },
    );

    if (!mounted) return;

    setState(() => _isDownloading = false);

    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)?.downloadFailed ?? 'Download failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.headerComponent.headerFileUrlController,
      builder: (context, url, child) {
        String videoUrl = url.text;
        if (videoUrl.isEmpty) {
          return Icon(CupertinoIcons.doc, size: 50, color: Colors.white);
        }
        return AbsorbPointer(
          absorbing: _isDownloading,
          child: InkWell(
            onTap: () => _downloadVideo(videoUrl),
            child: _isDownloading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: _progress > 0 ? _progress : null,
                          strokeWidth: 3,
                          color: FormStyles.whatsappGreen,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _progress > 0 ? '${(_progress * 100).toInt()}%' : (AppLocalizations.of(context)?.downloading ?? 'Downloading…'),
                        style: const TextStyle(color: FormStyles.whatsappGreen, fontSize: 12),
                      ),
                    ],
                  )
                : Icon(CupertinoIcons.doc, size: 50, color: Colors.white),
          ),
        );
      },
    );
  }
}

class _LocationHeaderPreview extends StatelessWidget {
  final Component headerComponent;
  const _LocationHeaderPreview({super.key, required this.headerComponent});

  static const int _zoom = 15;
  static const int _tileSize = 256;

  /// Converts lat/lng to the OSM tile (x, y) and the pixel offset within that
  /// tile so we can position the marker precisely.
  static ({int tileX, int tileY, double offsetX, double offsetY}) _latLngToTile(
    double lat,
    double lng,
  ) {
    final n = math.pow(2, _zoom).toDouble();
    final latRad = lat * math.pi / 180;

    final exactX = (lng + 180) / 360 * n;
    final exactY = (1 - math.log(math.tan(latRad) + 1 / math.cos(latRad)) / math.pi) / 2 * n;

    return (
      tileX: exactX.floor(),
      tileY: exactY.floor(),
      offsetX: (exactX - exactX.floor()) * _tileSize,
      offsetY: (exactY - exactY.floor()) * _tileSize,
    );
  }

  static String _tileUrl(int x, int y) {
    return 'https://tile.openstreetmap.org/$_zoom/$x/$y.png';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: headerComponent.latitudeController,
      builder: (context, _, __) {
        return ValueListenableBuilder(
          valueListenable: headerComponent.longitudeController,
          builder: (context, _, __) {
            final latText = headerComponent.latitudeController.text.trim();
            final lngText = headerComponent.longitudeController.text.trim();

            final lat = double.tryParse(latText);
            final lng = double.tryParse(lngText);

            if (lat == null || lng == null) {
              return Center(
                child: Icon(Icons.location_on, size: 50, color: Colors.white),
              );
            }

            final tile = _latLngToTile(lat, lng);

            return InkWell(
              onTap: () => launchUrl(
                Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng'),
                mode: LaunchMode.externalApplication,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final w = constraints.maxWidth;
                    final h = constraints.maxHeight;

                    // Shift the 3x3 tile grid so the pin coordinate is centred.
                    final gridLeft = w / 2 - tile.offsetX - _tileSize;
                    final gridTop = h / 2 - tile.offsetY - _tileSize;

                    return Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        // 3x3 tile grid for full coverage
                        for (int dy = -1; dy <= 1; dy++)
                          for (int dx = -1; dx <= 1; dx++)
                            Positioned(
                              left: gridLeft + (dx + 1) * _tileSize,
                              top: gridTop + (dy + 1) * _tileSize,
                              width: _tileSize.toDouble(),
                              height: _tileSize.toDouble(),
                              child: CachedNetworkImage(
                                imageUrl: _tileUrl(tile.tileX + dx, tile.tileY + dy),
                                fit: BoxFit.cover,
                                placeholder: (_, __) => ColoredBox(color: Colors.grey.shade300),
                                errorWidget: (_, __, ___) => ColoredBox(color: Colors.grey.shade300),
                              ),
                            ),
                        // Red pin centred on the coordinate
                        Positioned(
                          left: w / 2 - 16,
                          top: h / 2 - 32,
                          child: Icon(Icons.location_on, size: 32, color: Colors.red),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ProductHeaderPreview extends StatelessWidget {
  final Component headerComponent;
  const _ProductHeaderPreview({super.key, required this.headerComponent});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: headerComponent.selectedProduct,
      builder: (context, product, child) {
        if (product == null) {
          return Icon(CupertinoIcons.photo, size: 50, color: Colors.white);
        }
        return CachedNetworkImage(
          imageUrl: product.imageUrl ?? "",
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Icon(
            CupertinoIcons.photo,
            size: 50,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class _TextHeaderPreview extends StatefulWidget {
  final Component headerComponent;
  const _TextHeaderPreview({super.key, required this.headerComponent});

  @override
  State<_TextHeaderPreview> createState() => _TextHeaderPreviewState();
}

class _TextHeaderPreviewState extends State<_TextHeaderPreview> {
  late List<ValueNotifier<String?>> _notifiers;

  @override
  void initState() {
    super.initState();
    _notifiers = widget.headerComponent.attributes.map((a) => a.selectedVariableValue).toList();
    for (final notifier in _notifiers) {
      notifier.addListener(_onChanged);
    }
  }

  @override
  void didUpdateWidget(covariant _TextHeaderPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.headerComponent != widget.headerComponent) {
      for (final notifier in _notifiers) {
        notifier.removeListener(_onChanged);
      }
      _notifiers = widget.headerComponent.attributes.map((a) => a.selectedVariableValue).toList();
      for (final notifier in _notifiers) {
        notifier.addListener(_onChanged);
      }
    }
  }

  @override
  void dispose() {
    for (final notifier in _notifiers) {
      notifier.removeListener(_onChanged);
    }
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  String _resolveText() {
    String text = widget.headerComponent.text ?? "";

    for (int i = 0; i < widget.headerComponent.attributes.length; i++) {
      final value = widget.headerComponent.attributes[i].selectedVariableValue.value;

      if (value != null && value.isNotEmpty) {
        text = text.replaceAll('{{${i + 1}}}', value);
      }
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _resolveText(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ImageHeaderPreview extends StatelessWidget {
  final Component headerComponent;
  const _ImageHeaderPreview({
    super.key,
    required this.headerComponent,
  });

  static final _cacheManager = CacheManager(
    Config(
      'imageHeaderCache',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: headerComponent.headerFileUrlController,
      builder: (context, url, child) {
        final imageUrl = url.text.trim();
        if (imageUrl.isEmpty) {
          return Icon(CupertinoIcons.photo, size: 50, color: Colors.white);
        }
        return CachedNetworkImage(
          cacheManager: _cacheManager,
          imageUrl: imageUrl,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Icon(
            CupertinoIcons.photo,
            size: 50,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
