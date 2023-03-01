import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: SvgPicture.asset(
          height: 48,
          'assets/logo.svg',
        ),
        leading: Image.asset(
          height: 36,
          'assets/profile-image-placeholder.png',
        ),
        actions: [
          IconButton(
            // TODO: extract color
            icon: const Icon(Icons.add, color: Color.fromRGBO(28, 27, 31, 1)),
            tooltip: 'Add new entry',
            splashRadius: 20,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: Color.fromRGBO(28, 27, 31, 1),
            ),
            tooltip: 'View entries',
            splashRadius: 20,
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(top: 16.0),
          child: isScrollable ? SingleChildScrollView(child: child) : child,
        ),
      ),
    );
  }
}
