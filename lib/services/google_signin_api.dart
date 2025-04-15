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
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '1011937444325-u3o4rs4s4o4j7ler1c7p5q48nnh1rpst.apps.googleusercontent.com',
    scopes: ['email', 'openid', 'profile'], // make sure to include 'openid'
  );


  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout = _googleSignIn.disconnect();
}
