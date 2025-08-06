import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly_ui/widgets/custom_circular_loading.dart' show CustomCircularLoading;

import '../providers/splash_provider.dart' show initialValidationsProvider;

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.watch(initialValidationsProvider).whenData(
          (url) {
            Navigator.pushReplacementNamed(
              context,
              url,
            );
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: FlutterLogo(
                size: 100,
                style: FlutterLogoStyle.stacked,
                textColor: Colors.white,
              ),
            ),

            Positioned(
              bottom: 250,
              left: MediaQuery.of(context).size.width / 2 - 20,
              child: const CustomCircularLoading(
                color: Colors.white,
              ),
            ),

            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  'T A S K L Y',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
