part of '../registration_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.switchToLogin});

  final VoidCallback switchToLogin;

  static final _signUpformKey = GlobalKey<FormBuilderState>();

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
      key: SignUp._signUpformKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: FormBuilderTextField(
              name: 'name',
              textInputAction: TextInputAction.next,
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration: const InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: AppColors.textColor),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.secondaryColor,
                  ),
                ),
                errorStyle: TextStyle(height: 0.1),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ),
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
                errorStyle: TextStyle(height: 0.1),
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
                errorStyle: TextStyle(height: 0.1),
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
                    final form = SignUp._signUpformKey.currentState;
                    final isValid = form!.saveAndValidate();
                    if (!isValid) return;

                    final data = form.value;
                    setState(() {
                      isLoading = true;
                    });

                    await AuthProvider.register(
                      password: data['password'],
                      email: data['email'],
                      name: data['name'],
                      storeError: storeErrorMsg,
                    );
                    showErrorSnacbar();

                    setState(() {
                      isLoading = false;
                      errorMessage.isEmpty ? widget.switchToLogin() : null;
                      errorMessage = '';
                    });
                  },
                  child: const Text("Sign Up"),
                )
        ],
      ),
    );
  }
}
