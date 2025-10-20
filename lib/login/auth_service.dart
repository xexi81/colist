import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;
import '../constants/firestore_service.dart';

/// Servicio de autenticación con Firebase + Google
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // El webClientId se configura en Android a través de strings.xml
  // y en iOS a través de GoogleService-Info.plist
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // instanciamos variable para firestore
  final _firestoreService = FirestoreService();

  /// Stream que notifica los cambios de estado de autenticación
  Stream<User?> get userChanges => _auth.authStateChanges();

  /// Inicia sesión con Google y conecta con Firebase
  Future<UserCredential?> signInWithGoogle() async {
    try {
      developer.log('🔵 Iniciando Google Sign-In...');

      // 1. Iniciar el flujo de Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        developer.log('⚠️ Usuario canceló el login');
        return null;
      }

      developer.log('✅ Google user obtenido: ${googleUser.email}');

      // 2. Obtener los tokens de autenticación
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      developer.log(
        '✅ Tokens obtenidos - AccessToken: ${googleAuth.accessToken != null}, IdToken: ${googleAuth.idToken != null}',
      );

      // 3. Crear credencial de Firebase con los tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      developer.log('🔵 Iniciando sesión en Firebase...');

      // 4. Iniciar sesión en Firebase con la credencial
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      developer.log('✅ Login exitoso! Usuario: ${userCredential.user?.email}');

      // 5. Grabamos en firestore
      await _firestoreService.saveUserData();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      developer.log('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      return null;
    } catch (e, stackTrace) {
      developer.log('❌ Error desconocido: $e\nStack trace: $stackTrace');
      return null;
    }
  }

  /// Cierra sesión tanto en Google como en Firebase
  Future<void> signOut() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      await _auth.signOut();
      developer.log("✅ Sesión cerrada con éxito.");
    } catch (e) {
      developer.log("❌ Error al cerrar sesión: $e");
    }
  }
}
