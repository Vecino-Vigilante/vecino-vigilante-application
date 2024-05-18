import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:vecino_vigilante/configurations/routes_enum.dart';
import 'package:vecino_vigilante/http/login.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    void submit() {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        late SnackBar snackBar;

        login(
          _formKey.currentState!.value["email"],
          _formKey.currentState!.value["password"],
        ).then((response) {
          if (response != null) {
            AuthUtils.setAuthenticatedUser(response).then((success) {
              _formKey.currentState!.reset();
              context.go(RoutesEnum.home.path);
            });
          } else {
            snackBar = const SnackBar(
              content: Text(
                "¡Oh no! Algo salió mal mientras intentabamos iniciar tu sesión. Revisa tus datos e intenta más tarde.",
              ),
              backgroundColor: Colors.red,
              showCloseIcon: true,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 31,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset("assets/logo.png"),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Vecino Vigilante",
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Autenticación",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "ejemplo@email.com",
                      labelText: "Correo electrónico",
                    ),
                    name: "email",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FormBuilderTextField(
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "•••••••••••••",
                      labelText: "Contraseña",
                    ),
                    obscureText: true,
                    name: "password",
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: submit,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          theme.colorScheme.primary,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          theme.colorScheme.onPrimary,
                        ),
                      ),
                      child: const Text("Iniciar sesión"),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿No tienes una cuenta? ",
                      ),
                      InkWell(
                        onTap: () => context.push(RoutesEnum.signup.path),
                        child: Text(
                          "Regístrate",
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
