part of '../registration_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  static final _loginFormKey = GlobalKey<FormBuilderState>();

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isLoading = false;

  String errorMessage = '';

  void storeErrorMsg(String errorMsg) {
    setState(() {
      errorMessage = AuthErrorTranslator.getErrorDescription(errorMsg) ?? '';
    });
  }

  void showErrorSnacbar() {
    if (errorMessage == '' || errorMessage.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: LogIn._loginFormKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: FormBuilderTextField(
              name: 'email',
              textInputAction: TextInputAction.next,
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: AppColors.textColor),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: FormBuilderTextField(
              name: 'password',
              obscureText: true,
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration: const InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: AppColors.textColor),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                ),
                errorMaxLines: 2,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(6),
              ]),
            ),
          ),
          mediumVertSpace,
          isLoading
              ? const CircularProgressIndicator()
              : OutlinedButton(
                  onPressed: () async {
                    final form = LogIn._loginFormKey.currentState;
                    final isValid = form!.saveAndValidate();
                    if (!isValid) return;

                    final data = form.value;
                    setState(() {
                      isLoading = true;
                    });

                    await AuthProvider.login(
                      password: data['password'],
                      email: data['email'],
                      storeError: storeErrorMsg,
                    );

                    setState(() {
                      isLoading = false;
                    });

                    showErrorSnacbar();
                  },
                  child: const Text("Log In"),
                ),
          smallVertSpace,
          const OutlinedButton(
            onPressed: AuthProvider.signInWithGoogle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FontAwesomeIcons.google, size: 18),
                smallHorzSpace,
                Text("Sign in with Google"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
