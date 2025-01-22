import 'package:flutter/material.dart';
import 'package:gambling_game/app/config/app_colors.dart';

final GlobalKey<_LoaderContentState> _loaderKey =
    GlobalKey<_LoaderContentState>();

class Loader {
  static show([String message = 'Cargando']) {
    if (_loaderKey.currentState != null) {
      _loaderKey.currentState!.show(message);
    }
  }

  static dissmiss() {
    if (_loaderKey.currentState != null) {
      _loaderKey.currentState!.dismiss();
    }
  }
}

class LoaderProvider extends StatelessWidget {
  const LoaderProvider({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _LoaderContent(
      key: _loaderKey,
      child: child,
    );
  }
}

class _LoaderContent extends StatefulWidget {
  const _LoaderContent({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<_LoaderContent> createState() => _LoaderContentState();
}

class _LoaderContentState extends State<_LoaderContent> {
  bool showLoader = false;
  String message = 'Loading';

  show([String message = 'Loading']) {
    setState(() {
      showLoader = true;
      this.message = message;
    });
  }

  dismiss() {
    setState(() {
      showLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.child != null) widget.child!,
        if (showLoader)
          Container(
            color: AppColors.gray3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 150,
                      child: Image.asset(
                        'assets/gifs/loading.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
