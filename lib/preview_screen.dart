import 'dart:math' as math;

import 'package:dessn_loader/dessn_loader.dart';
import 'package:flutter/material.dart';

const double _kPreviewSize = 64;
const int _kPreviewsInRow = 5;
const int _kSpacingsInRow = _kPreviewsInRow - 1;

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: _kPreviewSize * (_kPreviewsInRow + _kSpacingsInRow),
            ),
            child: Builder(
              builder: (context) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.heightOf(context),
                  ),
                  child: const _PreviewsSheet(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewsSheet extends StatelessWidget {
  const _PreviewsSheet();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.widthOf(context);
    final availableSpacing =
        (screenWidth - _kPreviewSize * _kPreviewsInRow) / _kSpacingsInRow;
    final spacing = math.max<double>(
      math.min(_kPreviewSize, availableSpacing),
      0,
    );

    final totalCount = DessnLoaderPattern.values.length;
    final rowsCount = (totalCount / _kPreviewsInRow).ceil();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spacing,
        children: [
          for (var i = 0; i < rowsCount; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var j = 0; j < _kPreviewsInRow; j++)
                  if (i * _kPreviewsInRow + j < totalCount)
                    _LoaderPreview(
                      color: switch (j) {
                        0 => .blue,
                        1 => .orange,
                        2 => .red,
                        3 => .orange,
                        _ => .blue,
                      },
                      pattern:
                          DessnLoaderPattern.values[i * _kPreviewsInRow + j],
                    ),
              ],
            ),
        ],
      ),
    );
  }
}

class _LoaderPreview extends StatelessWidget {
  const _LoaderPreview({
    required this.color,
    required this.pattern,
  });

  final DessnLoaderColor color;

  final DessnLoaderPattern pattern;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size.square(_kPreviewSize)),
      child: DessnLoader(
        color: color,
        pattern: pattern,
      ),
    );
  }
}
