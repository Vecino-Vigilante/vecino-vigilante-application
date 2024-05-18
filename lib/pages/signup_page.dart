import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:vecino_vigilante/configurations/routes_enum.dart';
import 'package:vecino_vigilante/http/signup.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    void submit() {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        setState(() {
          _isSubmitting = true;
        });

        late SnackBar snackBar;

        signup(_formKey.currentState!.value).then((response) {
          if (response != null) {
            snackBar = const SnackBar(
              content: Text("¡Usuario registrado correctamente!"),
              backgroundColor: Colors.green,
              showCloseIcon: true,
            );

            AuthUtils.setAuthenticatedUser(response).then((success) {
              _formKey.currentState!.reset();
              context.go(RoutesEnum.home.path);
            });
          } else {
            snackBar = const SnackBar(
              content: Text(
                "¡Oh no! Algo salió mal mientras intentabamos registrar tu información. Intenta más tarde.",
              ),
              backgroundColor: Colors.red,
              showCloseIcon: true,
            );
          }

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }).whenComplete(() {
          setState(() {
            _isSubmitting = false;
          });
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Juan",
                            labelText: "Nombre",
                          ),
                          name: "name",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Pérez",
                            labelText: "Apellido",
                          ),
                          name: "lastname",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                      ),
                    ],
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
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
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
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(8),
                    ]),
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
                      labelText: "Confirma tu contraseña",
                    ),
                    name: "confirm-password",
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      (passwordConfirm) => passwordConfirm !=
                              _formKey.currentState?.fields['password']?.value
                          ? "La confirmación de la contraseña y la contraseña deben coincidir."
                          : null,
                    ]),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: _isSubmitting
                          ? Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(2.0),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Container(),
                      label: const Text("Regístrate"),
                      onPressed: _isSubmitting ? null : submit,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          theme.colorScheme.primary,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿Ya tienes una cuenta? ",
                      ),
                      InkWell(
                        onTap: () => context.push(RoutesEnum.login.path),
                        child: Text(
                          "Inicia sesión",
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
