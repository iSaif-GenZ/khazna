import 'package:flutter/material.dart';

class SwipeToDeleteTransaction extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;

  const SwipeToDeleteTransaction({
    required this.child,
    required this.onDismissed,
    super.key,
  });

  @override
  State<SwipeToDeleteTransaction> createState() => _SwipeToDeleteTransactionState();
}

class _SwipeToDeleteTransactionState extends State<SwipeToDeleteTransaction>
    with TickerProviderStateMixin {
  late final AnimationController _dragController;
  late final AnimationController _sizeController;
  late final Animation<double> _sizeAnimation;
  Animation<double>? _dragAnimation;
  
  double _dragExtent = 0.0;
  bool _isDismissed = false;

  @override
  void initState() {
    super.initState();
    
    _dragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _dragController.addListener(() {
      if (_dragAnimation != null) {
        setState(() {
          _dragExtent = _dragAnimation!.value;
        });
      }
    });

    _sizeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _sizeAnimation = CurvedAnimation(
      parent: _sizeController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _dragController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_isDismissed) return;
    setState(() {
      _dragExtent += details.primaryDelta!;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details, double screenWidth) {
    if (_isDismissed) return;

    if (_dragExtent.abs() > screenWidth * 0.4) {
      _dragAnimation = Tween<double>(
        begin: _dragExtent,
        end: _dragExtent.sign * screenWidth,
      ).animate(CurvedAnimation(parent: _dragController, curve: Curves.easeOut));

      _dragController.forward(from: 0.0).then((_) {
        if (!mounted) return;
        setState(() {
          _isDismissed = true; // يتم إخفاء الأيقونة فوراً هنا
        });
        
        _sizeController.forward().then((_) {
          if (!mounted) return;
          widget.onDismissed();
        });
      });
    } else {
      _dragAnimation = Tween<double>(
        begin: _dragExtent,
        end: 0.0,
      ).animate(CurvedAnimation(parent: _dragController, curve: Curves.easeOut));
      _dragController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSwipingRight = _dragExtent > 0;
    final dragAbs = _dragExtent.abs();

    return SizeTransition(
      sizeFactor: Tween<double>(begin: 1.0, end: 0.0).animate(_sizeAnimation),
      child: GestureDetector(
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragEnd: (details) => _onHorizontalDragEnd(details, screenWidth),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: isSwipingRight ? Alignment.centerLeft : Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: dragAbs,
                    color: Colors.red,
                    alignment: Alignment.center, 
                    child: Transform.scale(
                      scale: (dragAbs / 60).clamp(0.0, 1.0),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity: _isDismissed ? 0.0 : 1.0, // تخفي الأيقونة عند التمرير الكامل
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            Transform.translate(
              offset: Offset(_dragExtent, 0),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}