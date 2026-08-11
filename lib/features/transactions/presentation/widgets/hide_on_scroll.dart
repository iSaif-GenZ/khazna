import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideOnScroll extends StatefulWidget {
  final Widget child;
  final ScrollController controller;

  const HideOnScroll({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<HideOnScroll> createState() => _HideOnScrollState();
}

class _HideOnScrollState extends State<HideOnScroll> {
  double _progress = 0.0;
  double _lastOffset = 0.0;
  final double hideDistance = 100;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant HideOnScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    // لما نبدل التاب، الـ controller المرَّر يتغير - نعيد ربط الـ listener
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
      _lastOffset = 0;
      _setProgress(0.0); // يظهر الشريط فوراً عند فتح تاب جديد
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final offset = widget.controller.offset;
    if (offset <= 0) {
      _lastOffset = 0;
      _setProgress(0.0);
      return;
    }
    if (widget.controller.position.extentAfter < 20) {
      _lastOffset = offset;
      return;
    }
    final delta = offset - _lastOffset;
    _lastOffset = offset;

    if (delta.abs() < 2) return;
    if (widget.controller.position.extentAfter < 20) return;

    final next = _progress + delta / hideDistance;
    _setProgress(next);
  }

  void _setProgress(double value) {
    if (_progress != value) {
      setState(() {
        _progress = value.clamp(0.0, 1.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: Offset(0, _progress * 1.4),
      child: Opacity(opacity: 1 - _progress, child: widget.child),
    );
  }
}