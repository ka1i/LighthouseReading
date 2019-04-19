import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


enum SidebarAlignment {
  start,
  end,
}

const double _kWidth = 280.0;
const double _kEdgeDragWidth = 20.0;
const double _kMinFlingVelocity = 365.0;
const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

class Sidebar extends StatelessWidget {

  const Sidebar({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
  }) : super(key: key);

  final double elevation;

  final Widget child;

  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
    }
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(width: _kWidth),
        child: Material(
          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}

typedef SidebarCallback = void Function(bool isOpened);

class SidebarController extends StatefulWidget {

  const SidebarController({
    GlobalKey key,
    @required this.child,
    @required this.alignment,
    this.drawerCallback,
  }) : assert(child != null),
       assert(alignment != null),
       super(key: key);

  final Widget child;

  final SidebarAlignment alignment;

  final SidebarCallback drawerCallback;

  @override
  SidebarControllerState createState() => SidebarControllerState();
}

class SidebarControllerState extends State<SidebarController> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kBaseSettleDuration, vsync: this)
      ..addListener(_animationChanged)
      ..addStatusListener(_animationStatusChanged);
  }

  @override
  void dispose() {
    _historyEntry?.remove();
    _controller.dispose();
    super.dispose();
  }

  void _animationChanged() {
    setState(() {
      // The animation controller's state is our build state, and it changed already.
    });
  }

  LocalHistoryEntry _historyEntry;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  void _ensureHistoryEntry() {
    if (_historyEntry == null) {
      final ModalRoute<dynamic> route = ModalRoute.of(context);
      if (route != null) {
        _historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(_historyEntry);
        FocusScope.of(context).setFirstFocus(_focusScopeNode);
      }
    }
  }

  void _animationStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.forward:
        _ensureHistoryEntry();
        break;
      case AnimationStatus.reverse:
        _historyEntry?.remove();
        _historyEntry = null;
        break;
      case AnimationStatus.dismissed:
        break;
      case AnimationStatus.completed:
        break;
    }
  }

  void _handleHistoryEntryRemoved() {
    _historyEntry = null;
    close();
  }

  AnimationController _controller;

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
    _ensureHistoryEntry();
  }

  void _handleDragCancel() {
    if (_controller.isDismissed || _controller.isAnimating)
      return;
    if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  final GlobalKey _drawerKey = GlobalKey();

  double get _width {
    final RenderBox box = _drawerKey.currentContext?.findRenderObject();
    if (box != null)
      return box.size.width;
    return _kWidth; // drawer not being shown currently
  }

  bool _previouslyOpened = false;

  void _move(DragUpdateDetails details) {
    double delta = details.primaryDelta / _width;
    switch (widget.alignment) {
      case SidebarAlignment.start:
        break;
      case SidebarAlignment.end:
        delta = -delta;
        break;
    }
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta;
        break;
      case TextDirection.ltr:
        _controller.value += delta;
        break;
    }

    final bool opened = _controller.value > 0.5 ? true : false;
    if (opened != _previouslyOpened && widget.drawerCallback != null)
      widget.drawerCallback(opened);
    _previouslyOpened = opened;
  }

  void _settle(DragEndDetails details) {
    if (_controller.isDismissed)
      return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / _width;
      switch (widget.alignment) {
        case SidebarAlignment.start:
          break;
        case SidebarAlignment.end:
          visualVelocity = -visualVelocity;
          break;
      }
      switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.fling(velocity: -visualVelocity);
        break;
      case TextDirection.ltr:
        _controller.fling(velocity: visualVelocity);
        break;
      }
    } else if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  void open() {
    _controller.fling(velocity: 1.0);
    if (widget.drawerCallback != null)
      widget.drawerCallback(true);
  }

  void close() {
    _controller.fling(velocity: -1.0);
    if (widget.drawerCallback != null)
      widget.drawerCallback(false);
  }

  final ColorTween _color = ColorTween(begin: Colors.transparent, end: Colors.black54);
  final GlobalKey _gestureDetectorKey = GlobalKey();

  AlignmentDirectional get _drawerOuterAlignment {
    assert(widget.alignment != null);
    switch (widget.alignment) {
      case SidebarAlignment.start:
        return AlignmentDirectional.centerStart;
      case SidebarAlignment.end:
        return AlignmentDirectional.centerEnd;
    }
    return null;
  }

  AlignmentDirectional get _drawerInnerAlignment {
    assert(widget.alignment != null);
    switch (widget.alignment) {
      case SidebarAlignment.start:
        return AlignmentDirectional.centerEnd;
      case SidebarAlignment.end:
        return AlignmentDirectional.centerStart;
    }
    return null;
  }

  Widget _buildSidebar(BuildContext context) {
    final bool sidebarIsStart = widget.alignment == SidebarAlignment.start;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    double dragAreaWidth = sidebarIsStart ? padding.left : padding.right;

    if (Directionality.of(context) == TextDirection.rtl)
      dragAreaWidth = sidebarIsStart ? padding.right : padding.left;

    dragAreaWidth = max(dragAreaWidth, _kEdgeDragWidth);
    if (_controller.status == AnimationStatus.dismissed) {
      return Align(
        alignment: _drawerOuterAlignment,
        child: GestureDetector(
          key: _gestureDetectorKey,
          onHorizontalDragUpdate: _move,
          onHorizontalDragEnd: _settle,
          behavior: HitTestBehavior.translucent,
          excludeFromSemantics: true,
          child: Container(width: dragAreaWidth),
        ),
      );
    } else {
      return GestureDetector(
        key: _gestureDetectorKey,
        onHorizontalDragDown: _handleDragDown,
        onHorizontalDragUpdate: _move,
        onHorizontalDragEnd: _settle,
        onHorizontalDragCancel: _handleDragCancel,
        excludeFromSemantics: true,
        child: RepaintBoundary(
          child: Stack(
            children: <Widget>[
              BlockSemantics(
                child: GestureDetector(
                  // On Android, the back button is used to dismiss a modal.
                  excludeFromSemantics: defaultTargetPlatform == TargetPlatform.android,
                  onTap: close,
                  child: Semantics(
                    label: MaterialLocalizations.of(context)?.modalBarrierDismissLabel,
                    child: Container(
                      color: _color.evaluate(_controller),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: _drawerOuterAlignment,
                child: Align(
                  alignment: _drawerInnerAlignment,
                  widthFactor: _controller.value,
                  child: RepaintBoundary(
                    child: FocusScope(
                      key: _drawerKey,
                      node: _focusScopeNode,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return ListTileTheme(
      style: ListTileStyle.drawer,
      child: _buildSidebar(context),
    );
  }
}
