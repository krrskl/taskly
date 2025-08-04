import 'package:flutter/material.dart';

import '../extensions/build_context.extensions.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    super.key,
    required this.child,
    this.title,
    this.floatingActionButton,
    this.actions,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: CustomAppBar(title: title, actions: actions),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.colorScheme.primary.withValues(alpha: 0.1),
              context.colorScheme.surfaceContainerLowest,
              context.colorScheme.surfaceContainerLowest,
            ],
            stops: const [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(child: child),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar({super.key, this.title, this.leading, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            )
          : null,
      leading: leading,
      actions: actions,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
