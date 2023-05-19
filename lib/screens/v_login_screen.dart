import 'package:dzero/config/routes/app_router.dart';
import 'package:dzero/config/themes/colors_theme.dart';
import 'package:dzero/controllers/controllers.dart';
import 'package:dzero/screens/v_registro_screen.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VLoginScreen extends StatelessWidget {
  static const String name = 'login_screen';

  const VLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Container(
                  height: size.height, //80 los dos sizebox y 100 el ícono
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: const _LoginForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final textStyles = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 30),
        Text('Iniciar Sesión', style: textStyles.titleLarge),
        const SizedBox(height: 90),
        CustomTextFormField(
          label: 'Correo',
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) =>
              ref.read(loginFormProvider.notifier).onEmailChanged(value),
          errorMessage:
              loginForm.isFormPosted ? loginForm.email.errorMessage : null,
        ),
        const SizedBox(height: 30),
        CustomTextFormField(
          label: 'Contraseña',
          obscureText: true,
          onChanged: (value) =>
              ref.read(loginFormProvider.notifier).onPasswordChanged(value),
          errorMessage:
              loginForm.isFormPosted ? loginForm.password.errorMessage : null,
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: CustomFilledButton(
            text: 'Ingresar',
            buttonColor: colorTerceary,
            onPressed: () {
              ref.read(loginFormProvider.notifier).onFormSubmit();
            },
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: CustomFilledButton(
            icon: FontAwesomeIcons.google,
            text: 'Iniciar Sesion con Google',
            buttonColor: colorSecondary,
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: CustomFilledButton(
            icon: FontAwesomeIcons.facebook,
            text: 'Iniciar Sesion con Facebook',
            buttonColor: colorSecondary,
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Aun no tienes cuenta en DZero?',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
            TextButton(
              onPressed: () => ref
                  .read(routesProvider)
                  .pushReplacementNamed(VRegistroScreen.name),
              child: const Text(
                'Registrese',
                style: TextStyle(color: colorTerceary),
              ),
            )
          ],
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
