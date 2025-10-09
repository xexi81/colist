import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;

/// Servicio de autenticación con Firebase + Google
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Stream que notifica los cambios de estado de autenticación
  Stream<User?> get userChanges => _auth.authStateChanges();

  /// Inicia sesión con Google y conecta con Firebase
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Iniciar el flujo de Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Usuario canceló el login
        return null;
      }

      // 2. Obtener los tokens de autenticación
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Crear credencial de Firebase con los tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Iniciar sesión en Firebase con la credencial
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      developer.log('Firebase Auth Error: ${e.code}');
      return null;
    } catch (e) {
      developer.log('Error desconocido al iniciar sesión con Google: $e');
      return null;
    }
  }

  /// Cierra sesión tanto en Google como en Firebase
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    developer.log("Sesión cerrada con éxito.");
  }
}
