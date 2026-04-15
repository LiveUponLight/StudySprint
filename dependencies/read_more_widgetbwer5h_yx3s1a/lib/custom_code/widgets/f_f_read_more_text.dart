// Automatic FlutterFlow imports
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:ui' as ui show TextDirection;

class FFReadMoreText extends StatefulWidget {
  const FFReadMoreText({
    Key? key,
    this.width,
    this.height,
    required this.text,
    this.maxLines = 3,
    this.initiallyExpanded = false,
    this.expandLabel = 'Читать дальше',
    this.collapseLabel = 'Свернуть',
    this.labelColor = const Color(0xFF0066FF),
    this.labelSize = 14.0,
    this.textColor = const Color(0xFF111111),
    this.textSize = 14.0,
    this.lineHeight = 1.4,
    this.textAlignStr = 'left', // "left" | "center" | "right" | "justify"
    this.labelAlignStr = 'left', // "left" | "center" | "right"
    this.showFadeWhileCollapsed = true,
    this.fadeHeight = 28.0,
    this.fadeColor = const Color(0xFFFFFFFF),
    this.animationMs = 220,
    this.expandOnTextTap = false,
    this.gapBetweenTextAndLabel = 8.0,
    this.labelIcon,
    this.rotateIconOnToggle = true,
    this.iconTurnsCollapsed = 0.0, // 0 * 360° = 0°
    this.iconTurnsExpanded = 0.5, // 0.5 * 360° = 180°
  }) : super(key: key);

  final double? width;
  final double? height;

  final String text;
  final int maxLines;
  final bool initiallyExpanded;

  final String expandLabel;
  final String collapseLabel;

  final Color labelColor;
  final double labelSize;

  final Color textColor;
  final double textSize;
  final double lineHeight;

  final String textAlignStr;
  final String labelAlignStr;

  final bool showFadeWhileCollapsed;
  final double fadeHeight;
  final Color fadeColor;

  final int animationMs;
  final bool expandOnTextTap;
  final double gapBetweenTextAndLabel;

  final Widget? labelIcon;

  // NEW: вращать ли иконку и на сколько(turns)
  final bool rotateIconOnToggle;
  final double iconTurnsCollapsed;
  final double iconTurnsExpanded;

  @override
  State<FFReadMoreText> createState() => _FFReadMoreTextState();
}

class _FFReadMoreTextState extends State<FFReadMoreText>
    with TickerProviderStateMixin {
  late bool _expanded;
  bool _isOverflowing = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  TextAlign _mapTextAlign(String v) {
    switch (v.trim().toLowerCase()) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'justify':
        return TextAlign.justify;
      case 'left':
      default:
        return TextAlign.left;
    }
  }

  MainAxisAlignment _mapLabelAlign(String v) {
    switch (v.trim().toLowerCase()) {
      case 'center':
        return MainAxisAlignment.center;
      case 'right':
        return MainAxisAlignment.end;
      case 'left':
      default:
        return MainAxisAlignment.start;
    }
  }

  void _toggle() => setState(() => _expanded = !_expanded);

  bool _computeOverflow({
    required BuildContext context,
    required String text,
    required TextStyle style,
    required double maxWidth,
    required int maxLines,
    required double textScale,
  }) {
    final ui.TextDirection dir = Directionality.of(context);
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: dir, // ui.TextDirection
      maxLines: maxLines,
      textAlign: _mapTextAlign(widget.textAlignStr),
      textScaleFactor: textScale,
    );
    tp.layout(maxWidth: maxWidth);
    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    final ui.TextDirection dir = Directionality.of(context);
    final textStyle = TextStyle(
      color: widget.textColor,
      fontSize: widget.textSize,
      height: widget.lineHeight,
    );

    final labelTextStyle = TextStyle(
      color: widget.labelColor,
      fontSize: widget.labelSize,
      height: 1.2,
      decoration: TextDecoration.none,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = (widget.width ?? constraints.maxWidth);
        final textScale = MediaQuery.of(context).textScaleFactor;
        final effectiveMaxW =
            maxW.isFinite ? maxW : MediaQuery.of(context).size.width;

        _isOverflowing = _computeOverflow(
          context: context,
          text: widget.text,
          style: textStyle,
          maxWidth: effectiveMaxW,
          maxLines: widget.maxLines,
          textScale: textScale,
        );

        final textWidget = GestureDetector(
          onTap: widget.expandOnTextTap && _isOverflowing ? _toggle : null,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              AnimatedSize(
                duration: Duration(milliseconds: widget.animationMs),
                alignment: Alignment.topLeft,
                curve: Curves.easeInOut,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _expanded
                        ? double.infinity
                        : _estimatedMaxHeightForLines(
                            context: context,
                            style: textStyle,
                            maxWidth: effectiveMaxW,
                            lines: widget.maxLines,
                            textScale: textScale,
                            dir: dir,
                          ),
                  ),
                  child: Text(
                    widget.text,
                    textAlign: _mapTextAlign(widget.textAlignStr),
                    style: textStyle,
                    softWrap: true,
                  ),
                ),
              ),
              if (widget.showFadeWhileCollapsed &&
                  !_expanded &&
                  _isOverflowing &&
                  widget.fadeHeight > 0)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: widget.fadeHeight,
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            widget.fadeColor.withOpacity(0.0),
                            widget.fadeColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );

        final hasToggle = _isOverflowing;
        final label = _expanded ? widget.collapseLabel : widget.expandLabel;

        final labelRow = hasToggle
            ? Row(
                mainAxisAlignment: _mapLabelAlign(widget.labelAlignStr),
                children: [
                  InkWell(
                    onTap: _toggle,
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(label, style: labelTextStyle),
                          if (widget.labelIcon != null) ...[
                            const SizedBox(width: 6),
                            // NEW: плавная ротация на 180°
                            widget.rotateIconOnToggle
                                ? AnimatedRotation(
                                    turns: _expanded
                                        ? widget.iconTurnsExpanded
                                        : widget.iconTurnsCollapsed,
                                    duration: Duration(
                                        milliseconds: widget.animationMs),
                                    curve: Curves.easeInOut,
                                    child: widget.labelIcon!,
                                  )
                                : widget.labelIcon!,
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink();

        return Container(
          width: widget.width ?? constraints.maxWidth,
          height: widget.height,
          clipBehavior: widget.height != null ? Clip.hardEdge : Clip.none,
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              textWidget,
              if (hasToggle) SizedBox(height: widget.gapBetweenTextAndLabel),
              labelRow,
            ],
          ),
        );
      },
    );
  }

  double _estimatedMaxHeightForLines({
    required BuildContext context,
    required TextStyle style,
    required double maxWidth,
    required int lines,
    required double textScale,
    required ui.TextDirection dir,
  }) {
    final sample = TextPainter(
      text: TextSpan(text: 'A', style: style),
      textDirection: dir,
      maxLines: 1,
      textScaleFactor: textScale,
    )..layout(maxWidth: maxWidth);
    final lineHeightPx = sample.preferredLineHeight;
    return lineHeightPx * lines + 2.0;
  }
}
