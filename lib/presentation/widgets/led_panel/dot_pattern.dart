import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/dot_shape_enum.dart';

/// Displays a repeating pattern of shapes as background, rendered via a
/// cached tile + ImageShader so the paint cost is O(1) regardless of
/// screen size.
class DotPattern extends StatefulWidget {
  /// Side length of the repeating tile (the "period" of the pattern).
  final double tileSize;

  /// Empty margin between the shape and the edge of its tile. Controls the
  /// visual gap between repeated shapes, and gives room for shapes whose
  /// silhouette isn't a simple circle (star points, heart lobes, etc.)
  /// so they don't get clipped at the tile boundary.
  final double tilePadding;

  final Color color;
  final DotShapeEnum shape;

  const DotPattern({
    super.key,
    this.tileSize = 15,
    this.tilePadding = 2,
    this.color = const Color(0xFFD9D9D9),
    this.shape = DotShapeEnum.circle,
  });

  @override
  State<DotPattern> createState() => _DotPatternState();
}

class _DotPatternState extends State<DotPattern> {
  ui.Image? _tile;
  double? _tileDpr;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dpr = MediaQuery.of(context).devicePixelRatio;
    if (_tile == null || _tileDpr != dpr) {
      _buildTile(dpr);
    }
  }

  @override
  void didUpdateWidget(covariant DotPattern old) {
    super.didUpdateWidget(old);
    final needsRebuild =
        old.tileSize != widget.tileSize ||
        old.tilePadding != widget.tilePadding ||
        old.color != widget.color ||
        old.shape != widget.shape;
    if (needsRebuild) {
      _buildTile(_tileDpr ?? MediaQuery.of(context).devicePixelRatio);
    }
  }

  @override
  void dispose() {
    _tile?.dispose();
    super.dispose();
  }

  Future<void> _buildTile(double dpr) async {
    _tileDpr = dpr;
    final step = widget.tileSize;
    final px = (step * dpr).ceil().clamp(1, 4096);

    final center = Offset(px / 2, px / 2);
    // Half-extent of the shape itself, after leaving `tilePadding` of
    // breathing room on each side.
    final extent = ((widget.tileSize / 2 - widget.tilePadding) * dpr).clamp(
      0.0,
      px / 2,
    );

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()
      ..color =
          (Color.lerp(widget.color, const Color(0xFFD9D9D9), 0.2) ??
                  widget.color)
              .withAlpha(50);

    canvas.drawPath(_pathFor(widget.shape, center, extent), paint);

    final oldTile = _tile;
    final image = await recorder.endRecording().toImage(px, px);
    if (!mounted) {
      image.dispose();
      return;
    }
    setState(() => _tile = image);
    oldTile?.dispose();
  }

  Path _pathFor(DotShapeEnum shape, Offset c, double r) {
    switch (shape) {
      case DotShapeEnum.circle:
        return Path()..addOval(Rect.fromCircle(center: c, radius: r));

      case DotShapeEnum.square:
        return Path()
          ..addRect(Rect.fromCenter(center: c, width: r * 2, height: r * 2));

      case DotShapeEnum.diamond:
        return Path()
          ..moveTo(c.dx, c.dy - r)
          ..lineTo(c.dx + r, c.dy)
          ..lineTo(c.dx, c.dy + r)
          ..lineTo(c.dx - r, c.dy)
          ..close();

      case DotShapeEnum.cross:
        final thickness = r * 0.6;
        return Path()
          ..addRect(Rect.fromCenter(center: c, width: r * 2, height: thickness))
          ..addRect(
            Rect.fromCenter(center: c, width: thickness, height: r * 2),
          );

      case DotShapeEnum.star:
        return _starPath(c, r);

      case DotShapeEnum.heart:
        return _heartPath(c, r);
    }
  }

  Path _starPath(Offset center, double outerRadius, {int points = 5}) {
    final path = Path();
    final innerRadius = outerRadius * 0.5;
    final angleStep = pi / points;
    for (int i = 0; i < points * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final angle = -pi / 2 + i * angleStep;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    return path..close();
  }

  Path _heartPath(Offset center, double r) {
    return Path()
      ..moveTo(center.dx, center.dy + r * 0.8)
      ..cubicTo(
        center.dx - r * 1.4,
        center.dy - r * 0.2,
        center.dx - r * 0.5,
        center.dy - r * 1.3,
        center.dx,
        center.dy - r * 0.5,
      )
      ..cubicTo(
        center.dx + r * 0.5,
        center.dy - r * 1.3,
        center.dx + r * 1.4,
        center.dy - r * 0.2,
        center.dx,
        center.dy + r * 0.8,
      )
      ..close();
  }

  @override
  Widget build(BuildContext context) {
    final tile = _tile;
    if (tile == null) return const SizedBox.shrink();
    return CustomPaint(
      painter: _TiledPatternPainter(tile, _tileDpr ?? 1.0),
      size: Size.infinite,
    );
  }
}

class _TiledPatternPainter extends CustomPainter {
  final ui.Image tile;
  final double dpr;
  _TiledPatternPainter(this.tile, this.dpr);

  @override
  void paint(Canvas canvas, Size size) {
    final shader = ImageShader(
      tile,
      TileMode.repeated,
      TileMode.repeated,
      Matrix4.diagonal3Values(1 / dpr, 1 / dpr, 1).storage,
    );
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant _TiledPatternPainter old) =>
      old.tile != tile || old.dpr != dpr;
}
