// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleSignInApi {
//   static final _googleSignIn = GoogleSignIn(
//     scopes: ['email'],
//
//   );
//
//   static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
//   static Future logout = _googleSignIn.disconnect();
// }
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
    // Correct format for passing the client ID
    clientId: "1011937444325-u3o4rs4s4o4j7ler1c7p5q48nnh1rpst.apps.googleusercontent.com",
    scopes: ['email'],
  );

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future logout = _googleSignIn.disconnect();
}
