import 'package:flutter/material.dart';

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SlideDirection direction;

  SlidePageRoute({
    required this.page,
    this.direction = SlideDirection.right,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin;
            switch (direction) {
              case SlideDirection.right:
                begin = const Offset(1.0, 0.0);
                break;
              case SlideDirection.left:
                begin = const Offset(-1.0, 0.0);
                break;
              case SlideDirection.up:
                begin = const Offset(0.0, 1.0);
                break;
              case SlideDirection.down:
                begin = const Offset(0.0, -1.0);
                break;
            }

            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}

enum SlideDirection {
  right,
  left,
  up,
  down,
}

extension NavigatorExtension on BuildContext {
  Future<T?> slideToPage<T>(Widget page, {SlideDirection? direction}) {
    return Navigator.push<T>(
      this,
      SlidePageRoute(
        page: page,
        direction: direction ?? SlideDirection.right,
      ),
    );
  }

  void slideToPageReplacement(Widget page, {SlideDirection? direction}) {
    Navigator.pushReplacement(
      this,
      SlidePageRoute(
        page: page,
        direction: direction ?? SlideDirection.right,
      ),
    );
  }
}
