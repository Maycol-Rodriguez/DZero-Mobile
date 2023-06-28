import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VRegistroScreen extends StatelessWidget {
  static const String name = 'registro_screen';
  const VRegistroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              child: RegisterForm(),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends ConsumerState<RegisterForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String usuario = '';
    String email = '';
    String password = '';
    final loader = ref.watch(loadingProvider);
    final textStyles = Theme.of(context).textTheme;
    final formRegistro = ref.watch(formularioReporteProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: ref.watch(formularioReporteProvider).formRegisterKey,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text('Nueva Cuenta', style: textStyles.titleLarge),
            const SizedBox(height: 90),
            CustomTextFormField(
              label: 'Usuario',
              keyboardType: TextInputType.text,
              onChanged: (value) => usuario = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'El campo no puede estar vacío';
                }
                if (value.length < 6) {
                  return 'El usuario debe tener al menos 3 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
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
                      text: 'Crear Cuenta',
                      buttonColor: colorTerceary,
                      onPressed: () async {
                        if (!formRegistro.registroEsValido()) return;
                        formRegistro.registroEsValido();
                        ref.read(loadingProvider.notifier).state = true;
                        final datos = AuthUser(context, email: email, password: password);
                        final cuenta = await ref.read(crearCuenta(datos).future);
                        ref.read(loadingProvider.notifier).state = false;
                        if (cuenta == null) {
                          await Future.delayed(const Duration(milliseconds: 2000), () {
                            ref.read(formularioReporteProvider).reset();
                            ref.read(formularioReporteProvider).fijarInput(context);
                          });
                          return;
                        }
                        await Future.delayed(const Duration(milliseconds: 2000), () {
                          mostrarSnackBar(context, 'Cuenta creada con éxito');
                          ref.read(formularioReporteProvider).reset();
                          ref.read(formularioReporteProvider).fijarInput(context);
                        });
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿Ya tienes una cuenta en DZero?',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white),
                ),
                TextButton(
                  onPressed: () => context.goNamed(VLoginScreen.name),
                  child: const Text(
                    'Inicie Sesión',
                    style: TextStyle(color: colorTerceary, fontSize: 12),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
