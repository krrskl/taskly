import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/router/routes.dart' show AppRoutes;
import 'package:taskly/presentation/i18n/translations.g.dart' show t;
import 'package:taskly_ui/taskly_ui.dart';

import '../widgets/dot_indicator.dart' show DotIndicator;
import '../widgets/onboarding_content.dart' show OnboardingContent;

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int currentPage = 0;
  List<Map<String, dynamic>> onboardingSteps = [
    {
      'title': t.onboarding.steps.welcome.title,
      'text': t.onboarding.steps.welcome.description,
      'icon': Icons.waving_hand,
    },
    {
      'title': t.onboarding.steps.features.title,
      'text': t.onboarding.steps.features.description,
      'icon': Icons.featured_play_list,
    },
    {
      'title': t.onboarding.steps.get_started.title,
      'text': t.onboarding.steps.get_started.description,
      'icon': Icons.get_app,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Padding(
        padding: paddingAllRegular,
        child: Column(
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 14,
              child: PageView.builder(
                itemCount: onboardingSteps.length,
                onPageChanged: (value) => setState(
                  () {
                    currentPage = value;
                  },
                ),
                itemBuilder: (context, index) => OnboardingContent(
                  icon: onboardingSteps[index]['icon'],
                  title: onboardingSteps[index]['title'],
                  text: onboardingSteps[index]['text'],
                ),
              ),
            ),
            const Spacer(),
            if (currentPage == onboardingSteps.length - 1) ...[
              CustomPrimaryButton(
                onPressed: () async {
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  }
                },
                text: t.onboarding.steps.get_started.button,
              )
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingSteps.length,
                (index) => DotIndicator(isActive: index == currentPage),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
