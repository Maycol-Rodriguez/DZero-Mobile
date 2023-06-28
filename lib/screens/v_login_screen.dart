// import 'package:dzero/config/config.dart';
import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class VLoginScreen extends StatelessWidget {
  static const String name = 'login_screen';

  const VLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(height: 100),
                SizedBox(
                  width: double.infinity,
                  child: LoginForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    final textStyles = Theme.of(context).textTheme;
    final loader = ref.watch(loadingProvider);
    final formLogin = ref.watch(formularioReporteProvider);

    return Form(
      key: ref.read(formularioReporteProvider).formLoginKey,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text('Iniciar Sesión', style: textStyles.titleLarge),
          const SizedBox(height: 90),
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'El campo no puede estar vacío';
              }
              if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) == false) {
                return 'El correo no es válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            validator: (value) {
              if (value!.isEmpty) {
                return 'El campo no puede estar vacío';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
            obscureText: true,
            onChanged: (value) => password = value,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: loader
                ? ElevatedButton(
                    onPressed: () {},
                    child: const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.transparent,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : CustomFilledButton(
                    text: 'Ingresar',
                    buttonColor: colorTerceary,
                    onPressed: () async {
                      if (!formLogin.loginEsValido()) return;
                      formLogin.loginEsValido();
                      ref.read(loadingProvider.notifier).state = true;
                      final usuario = AuthUser(context, email: email, password: password);
                      final cuenta = await ref.read(iniciarSesion(usuario).future);
                      if (cuenta == null) {
                        ref.read(loadingProvider.notifier).state = false;
                        await Future.delayed(const Duration(milliseconds: 1000), () {
                          ref.read(formularioReporteProvider).reset();
                          ref.read(formularioReporteProvider).fijarInput(context);
                        });
                        return;
                      }
                      ref.read(loadingProvider.notifier).state = false;
                      await Future.delayed(
                        const Duration(milliseconds: 300),
                        () => context.goNamed(VHomeScreen.name),
                      );
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¿Aun no tienes cuenta en DZero?',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white),
              ),
              TextButton(
                onPressed: () => context.goNamed(VRegistroScreen.name),
                child: const Text(
                  'Registrese',
                  style: TextStyle(color: colorTerceary, fontSize: 14),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
