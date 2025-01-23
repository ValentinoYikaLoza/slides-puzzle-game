import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum SnackbarType {
  normal,
  animated, // For Snackbar with text animation
}

final GlobalKey<_SnackbarContentState> _snackbarKey = GlobalKey<_SnackbarContentState>();

class SnackbarService {
  static SnackbarModel? show(
    String message, {
    SnackbarType type = SnackbarType.normal,
  }) {
    if (_snackbarKey.currentState != null) {
      final newSnackbar = _snackbarKey.currentState!.addSnackbar(message, type);
      return newSnackbar;
    }
    return null;
  }

  static remove(SnackbarModel? snackbar) {
    if (_snackbarKey.currentState != null) {
      _snackbarKey.currentState!.removeSnackbar(snackbar);
    }
  }
}

class SnackbarProvider extends StatelessWidget {
  const SnackbarProvider({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _SnackbarContent(
      key: _snackbarKey,
      child: child,
    );
  }
}

class _SnackbarContent extends StatefulWidget {
  const _SnackbarContent({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<_SnackbarContent> createState() => _SnackbarContentState();
}

class _SnackbarContentState extends State<_SnackbarContent> {
  List<SnackbarModel> snackbars = [];

  SnackbarModel addSnackbar(String message, SnackbarType type) {
    final SnackbarModel newSnackbar = SnackbarModel(
      id: _generateRandomString(10),
      message: message,
      type: type,
    );

    setState(() {
      snackbars.clear(); // Clear existing snackbars
      snackbars.add(newSnackbar);
    });

    if (type == SnackbarType.normal || type == SnackbarType.animated) {
      Future.delayed(const Duration(seconds: 4), () {
        removeSnackbar(newSnackbar);
      });
    }

    return newSnackbar;
  }

  removeSnackbar(SnackbarModel? snackbar) {
    if (snackbar == null) return;
    setState(() {
      snackbars.remove(snackbar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          if (widget.child != null) widget.child!,
          Positioned(
            top: 20,
            left: screenWidth / 2 - (screenWidth * 0.5 / 2),
            child: Wrap(
              direction: Axis.vertical,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              children: snackbars.reversed.toList().map((snackbar) {
                if (snackbar.type == SnackbarType.normal) {
                  return _CustomSnackbar(
                    message: snackbar.message,
                    type: snackbar.type,
                    onClose: () {
                      removeSnackbar(snackbar);
                    },
                  );
                } else if (snackbar.type == SnackbarType.animated) {
                  return _AnimatedSnackbar(
                    message: snackbar.message,
                    onClose: () {
                      removeSnackbar(snackbar);
                    },
                  );
                }
                return Container();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

String _generateRandomString(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}

class _CustomSnackbar extends StatelessWidget {
  const _CustomSnackbar({
    required this.message,
    required this.onClose,
    this.type = SnackbarType.normal,
  });

  final String message;
  final SnackbarType type;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 20),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
            minHeight: 74,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.green.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.blue.shade800,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.extension,
                color: Colors.blue.shade800,
                size: 30,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.blue.shade800,
                ),
                onPressed: onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedSnackbar extends StatefulWidget {
  const _AnimatedSnackbar({
    required this.message,
    required this.onClose,
  });

  final String message;
  final void Function() onClose;

  @override
  State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<_AnimatedSnackbar> {
  late String displayedText = '';
  late Timer _textTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTextAnimation();
  }

  void _startTextAnimation() {
    _textTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_currentIndex < widget.message.length) {
        setState(() {
          displayedText += widget.message[_currentIndex];
          _currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _textTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 20),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
            minHeight: 74,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.green.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.blue.shade800,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.extension, // Puzzle piece icon
                color: Colors.blue.shade800,
                size: 30,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  displayedText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.blue.shade800,
                ),
                onPressed: widget.onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SnackbarModel {
  final String id;
  final String message;
  final SnackbarType type;

  SnackbarModel({
    required this.id,
    required this.message,
    required this.type,
  });
}