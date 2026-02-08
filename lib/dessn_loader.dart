import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

// The delay value which indicates that pixel is disabled.
const _kPixelDisabled = -1;

enum DessnLoaderColor {
  orange,
  red,
  blue
  ;

  Color get _value {
    return switch (this) {
      orange => const Color(0xFFF0C7A5),
      red => const Color(0xFFF0A8A8),
      blue => const Color(0xFFA0D5FF),
    };
  }
}

enum DessnLoaderPattern {
  waveLeftToRight,
  waveRightToLeft,
  waveTopToBottom,
  waveBottomToTop,
  diagonalTopLeft,
  diagonalTopRight,
  diagonalBottomLeft,
  diagonalBottomRight,
  rippleOut,
  rippleIn,
  cross,
  x,
  diamond,
  stripesHorizontal,
  stripesVertical,
  rows,
  spiralClockwise,
  spiralCounterClockwise,
  snake,
  snakeReversed,
  rain,
  rainReversed,
  waterfall,
  breathing,
  heartbeat,
  solo,
  soloTopLeft,
  soloBottomRight,
  lineHorizontalTop,
  lineHorizontalMiddle,
  lineHorizontalBottom,
  lineVerticalLeft,
  lineVerticalMiddle,
  lineVerticalRight,
  lineDiagonalLeftToRight,
  lineDiagonalRightToLeft,
  corners,
  cornersSync,
  plus,
  lTopLeft,
  lTopRight,
  lBottomLeft,
  lBottomRight,
  tTop,
  tBottom,
  duoHorizontal,
  duoVertical,
  frame,
  frameReversed,
  frameSync,
  ;

  _DessnLoaderPatterConfig get _config {
    return switch (this) {
      waveLeftToRight => const _DessnLoaderPatterConfig(
        duration: 600,
        delays: [0, 100, 200, 0, 100, 200, 0, 100, 200],
      ),
      waveRightToLeft => const _DessnLoaderPatterConfig(
        duration: 600,
        delays: [200, 100, 0, 200, 100, 0, 200, 100, 0],
      ),
      waveTopToBottom => const _DessnLoaderPatterConfig(
        duration: 600,
        delays: [0, 0, 0, 100, 100, 100, 200, 200, 200],
      ),
      waveBottomToTop => const _DessnLoaderPatterConfig(
        duration: 600,
        delays: [200, 200, 200, 100, 100, 100, 0, 0, 0],
      ),
      diagonalTopLeft => const _DessnLoaderPatterConfig(
        duration: 500,
        delays: [0, 100, 200, 100, 200, 300, 200, 300, 400],
      ),
      diagonalTopRight => const _DessnLoaderPatterConfig(
        duration: 500,
        delays: [200, 100, 0, 300, 200, 100, 400, 300, 200],
      ),
      diagonalBottomLeft => const _DessnLoaderPatterConfig(
        duration: 500,
        delays: [200, 300, 400, 100, 200, 300, 0, 100, 200],
      ),
      diagonalBottomRight => const _DessnLoaderPatterConfig(
        duration: 500,
        delays: [400, 300, 200, 300, 200, 100, 200, 100, 0],
      ),
      rippleOut => const _DessnLoaderPatterConfig(
        duration: 700,
        delays: [300, 150, 300, 150, 0, 150, 300, 150, 300],
      ),
      rippleIn => const _DessnLoaderPatterConfig(
        duration: 700,
        delays: [0, 150, 0, 150, 300, 150, 0, 150, 0],
      ),
      cross => const _DessnLoaderPatterConfig(
        duration: 600,
        delays: [300, 0, 300, 0, 0, 0, 300, 0, 300],
      ),
      x => const _DessnLoaderPatterConfig(
        duration: 600,
        delays: [0, 300, 0, 300, 0, 300, 0, 300, 0],
      ),
      diamond => const _DessnLoaderPatterConfig(
        duration: 625,
        delays: [400, 200, 400, 200, 0, 200, 400, 200, 400],
      ),
      stripesHorizontal => const _DessnLoaderPatterConfig(
        duration: 500,
        delays: [200, 200, 200, 0, 0, 0, 300, 300, 300],
      ),
      stripesVertical => const _DessnLoaderPatterConfig(
        duration: 500,
        delays: [300, 0, 200, 300, 0, 200, 300, 0, 200],
      ),
      rows => const _DessnLoaderPatterConfig(
        duration: 500,
        delays: [300, 300, 300, 0, 0, 0, 300, 300, 300],
      ),
      spiralClockwise => const _DessnLoaderPatterConfig(
        duration: 900,
        delays: [0, 100, 200, 700, 800, 300, 600, 500, 400],
      ),
      spiralCounterClockwise => const _DessnLoaderPatterConfig(
        duration: 900,
        delays: [200, 100, 0, 300, 800, 700, 400, 500, 600],
      ),
      snake => const _DessnLoaderPatterConfig(
        duration: 900,
        delays: [0, 100, 200, 500, 400, 300, 600, 700, 800],
      ),
      snakeReversed => const _DessnLoaderPatterConfig(
        duration: 900,
        delays: [800, 700, 600, 300, 400, 500, 200, 100, 0],
      ),
      rain => const _DessnLoaderPatterConfig(
        duration: 700,
        delays: [0, 100, 200, 200, 300, 400, 400, 500, 600],
      ),
      rainReversed => const _DessnLoaderPatterConfig(
        duration: 700,
        delays: [600, 500, 400, 400, 300, 200, 200, 100, 0],
      ),
      waterfall => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [0, 50, 100, 100, 150, 200, 200, 250, 300],
      ),
      breathing => const _DessnLoaderPatterConfig(
        duration: 1200,
        delays: [0, 0, 0, 0, 0, 0, 0, 0, 0],
      ),
      heartbeat => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [0, 0, 0, 0, 0, 0, 0, 0, 0],
      ),
      solo => const _DessnLoaderPatterConfig(
        duration: 700,
        delays: [
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, 0, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      soloTopLeft => const _DessnLoaderPatterConfig(
        duration: 700,
        delays: [
          0, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      soloBottomRight => const _DessnLoaderPatterConfig(
        duration: 700,
        delays: [
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, 0, //
        ],
      ),
      lineHorizontalTop => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          0, 100, 200, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      lineHorizontalMiddle => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          0, 100, 200, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      lineHorizontalBottom => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          0, 100, 200, //
        ],
      ),
      lineVerticalLeft => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          0, _kPixelDisabled, _kPixelDisabled, //
          100, _kPixelDisabled, _kPixelDisabled, //
          200, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      lineVerticalMiddle => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, 0, _kPixelDisabled, //
          _kPixelDisabled, 100, _kPixelDisabled, //
          _kPixelDisabled, 200, _kPixelDisabled, //
        ],
      ),
      lineVerticalRight => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, _kPixelDisabled, 0, //
          _kPixelDisabled, _kPixelDisabled, 100, //
          _kPixelDisabled, _kPixelDisabled, 200, //
        ],
      ),
      lineDiagonalLeftToRight => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          0, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, 100, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, 200, //
        ],
      ),
      lineDiagonalRightToLeft => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, _kPixelDisabled, 0, //
          _kPixelDisabled, 100, _kPixelDisabled, //
          200, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      corners => const _DessnLoaderPatterConfig(
        duration: 550,
        delays: [
          0, _kPixelDisabled, 100, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          200, _kPixelDisabled, 300, //
        ],
      ),
      cornersSync => const _DessnLoaderPatterConfig(
        duration: 700,
        delays: [
          0, _kPixelDisabled, 0, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          0, _kPixelDisabled, 0, //
        ],
      ),
      plus => const _DessnLoaderPatterConfig(
        duration: 550,
        delays: [
          _kPixelDisabled, 0, _kPixelDisabled, //
          100, _kPixelDisabled, 200, //
          _kPixelDisabled, 300, _kPixelDisabled, //
        ],
      ),
      lTopLeft => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          0, 100, _kPixelDisabled, //
          200, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      lTopRight => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, 100, 0, //
          _kPixelDisabled, _kPixelDisabled, 200, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      lBottomLeft => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          200, _kPixelDisabled, _kPixelDisabled, //
          0, 100, _kPixelDisabled, //
        ],
      ),
      lBottomRight => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, 200, //
          _kPixelDisabled, 100, 0, //
        ],
      ),
      tTop => const _DessnLoaderPatterConfig(
        duration: 550,
        delays: [
          0, 100, 200, //
          _kPixelDisabled, 300, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      tBottom => const _DessnLoaderPatterConfig(
        duration: 550,
        delays: [
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, 0, _kPixelDisabled, //
          100, 200, 300, //
        ],
      ),
      duoHorizontal => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          0, _kPixelDisabled, 100, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
        ],
      ),
      duoVertical => const _DessnLoaderPatterConfig(
        duration: 450,
        delays: [
          _kPixelDisabled, 0, _kPixelDisabled, //
          _kPixelDisabled, _kPixelDisabled, _kPixelDisabled, //
          _kPixelDisabled, 100, _kPixelDisabled, //
        ],
      ),
      frame => const _DessnLoaderPatterConfig(
        duration: 800,
        delays: [0, 100, 200, 700, _kPixelDisabled, 300, 600, 500, 400],
      ),
      frameReversed => const _DessnLoaderPatterConfig(
        duration: 800,
        delays: [200, 100, 0, 300, _kPixelDisabled, 700, 400, 500, 600],
      ),
      frameSync => const _DessnLoaderPatterConfig(
        duration: 900,
        delays: [0, 0, 0, 0, _kPixelDisabled, 0, 0, 0, 0],
      ),
    };
  }
}

class _DessnLoaderPatterConfig {
  const _DessnLoaderPatterConfig({
    required this.duration,
    required this.delays,
  });

  // The duration of the pixel animation in milliseconds . Half of this time
  // the pixel will fade in, and half of it fade out.
  final int duration;

  // The list of delays in milliseconds each pixel has to wait before start
  // animating.
  final List<int> delays;
}

class DessnLoader extends StatefulWidget {
  const DessnLoader({
    required this.color,
    required this.pattern,
    super.key,
  });

  final DessnLoaderColor color;

  final DessnLoaderPattern pattern;

  @override
  State<DessnLoader> createState() => _DessnLoaderState();
}

class _DessnLoaderState extends State<DessnLoader>
    with TickerProviderStateMixin {
  late final _colorController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  late final _colorTween = _ColorTween(
    begin: widget.color._value,
    end: widget.color._value,
  );

  late final Animation<Color> _color = _colorTween
      .chain(CurveTween(curve: Curves.ease))
      .animate(_colorController);

  late final Ticker _ticker = createTicker(_onTick);

  final _elapsedMilliseconds = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _ticker.start();
  }

  @override
  void didUpdateWidget(DessnLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != oldWidget.color) {
      _colorTween
        ..begin = _color.value
        ..end = widget.color._value;
      _colorController.forward(from: 0);
    }
    if (widget.pattern != oldWidget.pattern) {
      _ticker
        ..stop()
        ..start();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _elapsedMilliseconds.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsedDuration) {
    _elapsedMilliseconds.value = elapsedDuration.inMilliseconds;
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.pattern._config;

    return ShaderBuilder(
      assetKey: 'assets/shaders/bloom.frag',
      (context, shader, child) {
        return AnimatedSampler(
          (image, size, canvas) {
            shader
              ..setFloat(0, size.width)
              ..setFloat(1, size.height)
              ..setImageSampler(0, image);

            canvas.drawRect(
              Rect.fromLTWH(0, 0, size.width, size.height),
              Paint()..shader = shader,
            );
          },
          child: child!,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.5),
        child: Column(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          children: [
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisSize: .min,
                children: [
                  _Pixel(
                    elapsedMilliseconds: _elapsedMilliseconds,
                    color: _color,
                    delay: config.delays[i * 3],
                    duration: config.duration,
                  ),
                  _Pixel(
                    elapsedMilliseconds: _elapsedMilliseconds,
                    color: _color,
                    delay: config.delays[i * 3 + 1],
                    duration: config.duration,
                  ),
                  _Pixel(
                    elapsedMilliseconds: _elapsedMilliseconds,
                    color: _color,
                    delay: config.delays[i * 3 + 2],
                    duration: config.duration,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ColorTween extends Tween<Color> {
  _ColorTween({required Color super.begin, required Color super.end});

  @override
  Color lerp(double t) => Color.lerp(begin, end, t)!;
}

class _Pixel extends StatelessWidget {
  const _Pixel({
    required this.elapsedMilliseconds,
    required this.color,
    required this.delay,
    required this.duration,
  });

  static const _kSize = 9.0;

  final ValueListenable<int> elapsedMilliseconds;

  final Animation<Color> color;

  final int delay;

  final int duration;

  @override
  Widget build(BuildContext context) {
    if (delay == _kPixelDisabled) {
      return const _PixelPlaceholder();
    }

    return ListenableBuilder(
      listenable: Listenable.merge([elapsedMilliseconds, color]),
      builder: (context, child) {
        final progress =
            ((elapsedMilliseconds.value - delay).clamp(0, double.maxFinite) %
                duration) /
            duration;
        final opacity = math.sin(
          Curves.easeInOut.transform(progress) * math.pi,
        );
        final effectiveColor = color.value.withValues(alpha: opacity);

        return DecoratedBox(
          decoration: BoxDecoration(
            color: effectiveColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 9,
                spreadRadius: 1,
                color: effectiveColor,
              ),
            ],
          ),
          child: child,
        );
      },
      child: const SizedBox.square(dimension: _kSize),
    );
  }
}

class _PixelPlaceholder extends StatelessWidget {
  const _PixelPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(dimension: _Pixel._kSize);
  }
}
