import 'package:colist/constants/app_colors.dart';
import 'package:colist/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:colist/login/auth_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AuthService _authService = AuthService();

  // Método para iniciar sesión con Google
  void _signInWithGoogle() async {
    print('Intentando login con Google...');
    try {
      final userCredential = await _authService.signInWithGoogle();
      print('Resultado de signInWithGoogle: $userCredential');
      if (userCredential != null) {
        // Login exitoso: redirigir a otra pantalla (ej: HomeScreen)
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Login cancelado o fallido
        print('Login cancelado o fallido: userCredential es null');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión con Google')),
        );
      }
    } catch (e, stack) {
      print('Error en Google Sign-In: $e\n$stack');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: SizedBox(
          width: double.infinity,
          child: Text(
            "Listas compartidas",
            style: AppFonts.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Column(
        children: [
          Spacer(),
          Image.asset("assets/images/cesta.png", width: 300, height: 300),
          Text("Empieza a crear tus propias listas", style: AppFonts.subtitle),
          Text(
            "Logueate con una de estas opciones y empieza a compartir",
            style: AppFonts.text,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Spacer(),
          GestureDetector(
            onTap: _signInWithGoogle, // <-- Llama a tu método,
            child: Padding(
              padding: const EdgeInsets.only(right: 32, left: 32),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.button,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 0.3),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Image.asset(
                      "assets/images/google.png",
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Text("Continuar con Google", style: AppFonts.button),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.button,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 0.3),
              ),
              child: Row(
                children: [
                  Spacer(),
                  Spacer(),
                  Image.asset(
                    "assets/images/facebook.png",
                    width: 50,
                    height: 50,
                  ),
                  Text("Continuar con Facebook", style: AppFonts.button),
                  Spacer(),
                  Spacer(),
                ],
              ),
            ),
          ),
          Spacer(),
          Spacer(),
        ],
      ),
    );
  }
}
