import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final bool isScrollable;
  final Widget child;

  const Layout({
    Key? key,
    required this.child,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add new entry',
            splashRadius: 20,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'View entries',
            splashRadius: 20,
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: isScrollable ? SingleChildScrollView(child: child) : child,
      ),
    );
  }
}
