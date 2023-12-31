import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  const DefaultLayout({
    super.key,
    required this.child,
    this.title,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppbar(),
      bottomNavigationBar: bottomNavigationBar,
      body: child,
    );
  }

  AppBar? renderAppbar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Center(
          child: Text(
            title!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
  }
}
