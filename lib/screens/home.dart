import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, ${user?.displayName ?? 'Usuario'}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user?.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 40,
              ),
            SizedBox(height: 20),
            Text('Nombre: ${user?.displayName ?? 'No disponible'}'),
            Text('Email: ${user?.email ?? 'No disponible'}'),
            Text('UID: ${user?.uid ?? 'No disponible'}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!context.mounted) return;
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
