import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../theme/app_colors.dart';
import '../../theme/spaces.dart';
import '../../widgets/design/animated_button.dart';
import '../../widgets/design/app_logo.dart';
import '../../../services/auth/auth_provider.dart';
import '../../../utils/auth_error_translator.dart';

part 'widgets/log_in.dart';
part 'widgets/sign_up.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int selectedPage = 0;

  void switchToLogin() {
    setState(() {
      selectedPage = 0;
    });
  }

  List<Widget> registrationOptions = [];

  @override
  void initState() {
    super.initState();

    registrationOptions = [
      const LogIn(),
      SignUp(switchToLogin: switchToLogin),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final keyboardClosed = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment(0, 6),
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        keyboardClosed
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(),
                                        children: const [
                                          TextSpan(
                                              text:
                                                  "Elevate your productivity with "),
                                          WidgetSpan(child: AppLogo()),
                                        ])),
                              )
                            : const Column(
                                children: [
                                  mediumVertSpace,
                                  AppLogo(),
                                ],
                              ),
                        bigVertSpace,
                        mediumVertSpace,
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            AnimatedButton(
                              selectedPage: selectedPage,
                              onTapAction: () => setState(() {
                                selectedPage = 0;
                              }),
                              buttonText: "Log in",
                              textColor: selectedPage == 0
                                  ? AppColors.primaryColor
                                  : null,
                              backgroundColor: selectedPage == 0
                                  ? AppColors.textColor
                                  : null,
                            ),
                            AnimatedButton(
                              selectedPage: selectedPage,
                              onTapAction: () => setState(() {
                                selectedPage = 1;
                              }),
                              buttonText: "Sign Up",
                              textColor: selectedPage == 1
                                  ? AppColors.primaryColor
                                  : null,
                              backgroundColor: selectedPage == 1
                                  ? AppColors.textColor
                                  : null,
                            ),
                          ],
                        ),
                        mediumVertSpace,
                        SizedBox(
                            height: 323,
                            child: registrationOptions[selectedPage]),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
