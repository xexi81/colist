import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Importa tu servicio de Firestore
import 'package:colist/constants/firestore_service.dart'; // ¡Asegúrate de que esta ruta sea correcta!

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Instancia del servicio de Firestore
  final FirestoreService _firestoreService = FirestoreService();

  // Método para mostrar el diálogo de añadir lista
  void _showAddListDialog(BuildContext context) {
    String newListName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir Nueva Lista'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Nombre de la lista'),
            onChanged: (value) {
              newListName = value;
            },
            onSubmitted: (value) {
              // Permite añadir al presionar Enter/Done
              _addListAction(context, value.trim());
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _addListAction(context, newListName.trim());
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // Lógica para añadir la lista
  void _addListAction(BuildContext context, String title) async {
    if (title.isNotEmpty) {
      // 1. Cierra el diálogo
      Navigator.of(context).pop();

      try {
        // 2. Llama al método addList
        await _firestoreService.addList(title);

        // Opcional: Mostrar un Snackbar de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lista "$title" añadida con éxito!')),
        );
      } catch (e) {
        // Opcional: Mostrar un Snackbar de error
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al añadir la lista: $e')));
      }
    } else {
      // Opcional: Mostrar un mensaje si el campo está vacío
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El nombre de la lista no puede estar vacío.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, ${user?.displayName ?? 'Usuario'}'),
        leading: Builder(
          builder: (BuildContext context) {
            // Se asume que user!.photoURL! es seguro aquí si el usuario está logeado
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 40,
              ),
            );
          },
        ),
      ),
      drawer: const Drawer(child: Text('Probando drawer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user?.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 40,
              ),
            const SizedBox(height: 20),
            Text('Nombre: ${user?.displayName ?? 'No disponible'}'),
            Text('Email: ${user?.email ?? 'No disponible'}'),
            Text('UID: ${user?.uid ?? 'No disponible'}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/welcome');
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
      // --- Floating Action Button Añadido ---
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddListDialog(context),
        tooltip: 'Añadir Nueva Lista',
        child: const Icon(Icons.add),
      ),
    );
  }
}
