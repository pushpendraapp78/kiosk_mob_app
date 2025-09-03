import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipbot_app/Constant/api_dio.dart';
import 'package:ipbot_app/ui/signup/m/signup_response.dart';
import '../model/basic_response.dart';
import '../ui/documents/m/amount_response.dart';
import '../ui/documents/m/document_response.dart';
import '../ui/setting/m/privacy_response.dart';
import '../model/help_support_ticket.dart';
Future<SignupResponse> signUp(Map<String, dynamic> map) async {
  var resp = await httpClient().post('/user-register', data: map);
  return SignupResponse.fromJson(resp.data);
}

Future<SignupResponse> signIn(Map<String, dynamic> map) async {
  var resp = await httpClient().post('/user-login', data: map);
  return SignupResponse.fromJson(resp.data);
}

Future<BasicResponse> updateProfile(Map<String, dynamic> map) async {
  var resp = await httpClientWithHeader().post('/profile-update', data: map);
  return BasicResponse.fromJson(resp.data);
}

Future<SignupResponse> getProfile() async {
  var resp = await httpClientWithHeader().get('/view-profile');
  return SignupResponse.fromJson(resp.data);
}

Future<SignupResponse> getProfileByEmail(String email) async {
  var resp = await httpClient().get('/profile-by-email?email=$email');
  return SignupResponse.fromJson(resp.data);
}

Future<BasicResponse> addDocument(FormData data) async {
  var resp = await httpClientWithHeader().post('/documents/add', data: data);
  return BasicResponse.fromJson(resp.data);
}

Future<DocumentResponse> getDocument() async {
  var resp = await httpClientWithHeader().get('/documents/list');
  return DocumentResponse.fromJson(resp.data);
}

Future<BasicResponse> deleteDocument(id) async {
  var resp = await httpClientWithHeader().delete('/documents/delete/$id');
  return BasicResponse.fromJson(resp.data);
}

Future<BasicResponse> deleteAccount() async {
  var resp = await httpClientWithHeader().delete('/delete-account');
  return BasicResponse.fromJson(resp.data);
}

Future<BasicResponse> changePassword(Map<String, dynamic> map) async {
  var resp = await httpClientWithHeader().post('/change-password', data: map);
  return BasicResponse.fromJson(resp.data);
}

Future<BasicResponse> forgetPassword(Map<String, dynamic> map) async {
  var resp = await httpClientWithHeader().post('/forgot-password', data: map);
  return BasicResponse.fromJson(resp.data);
}

Future<PrivacyResponse> getPrivacyPolicy() async {
  var resp = await httpClientWithHeader().get('/privacy-policy');
  return PrivacyResponse.fromJson(resp.data);
}

Future<PrivacyResponse> getTermCondition() async {
  var resp = await httpClientWithHeader().get('/terms-and-conditions');
  return PrivacyResponse.fromJson(resp.data);
}

Future<AmountResponse> getAmountPerPage() async {
  var resp = await httpClientWithHeader().get('/amount-per-page-black');
  return AmountResponse.fromJson(resp.data);
}

Future<AmountResponse> getAmountPerPageColor() async {
  var resp = await httpClientWithHeader().get('/amount-per-page-color');
  return AmountResponse.fromJson(resp.data);
}

Future<BasicResponse> addHelpSupportTicket(Map<String, dynamic> map) async {
  try {
    var resp = await httpClientWithHeader().post('/help_support/add-help_support', data: map);
    return BasicResponse.fromJson(resp.data);
  } catch (e) {
    print('Add Ticket Error: $e');
    rethrow;
  }
}

Future<List<HelpSupportTicket>> getHelpSupportTickets(Map<String, dynamic> map) async {
  try {
    var resp = await httpClientWithHeader().post('/help_support/get-help_support-list', data: map);
    if (resp.data['success'] == true) {
      final List<dynamic> list = resp.data['data']['data'];
      return list.map((json) => HelpSupportTicket.fromJson(json)).toList();
    }
    return [];
  } catch (e) {
    print('List Tickets Error: $e');
    rethrow;
  }
}

// Future<AmountResponse> getAmountPerPageColor() async {
//   var resp = await httpClientWithHeader().get('/amount-per-page-color');
//   return AmountResponse.fromJson(resp.data);
// }

Future<UserCredential> signInWithGoogle() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
  await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
