import 'dart:io'; // Added for File class
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipbot_app/Constant/api_dio.dart';
import 'package:ipbot_app/repo/session_repo.dart';
import 'package:ipbot_app/ui/signup/m/signup_response.dart';
import '../model/basic_response.dart';
import '../ui/documents/m/amount_response.dart';
import '../ui/documents/m/document_response.dart';
import '../ui/login/login_view.dart';
import '../ui/setting/m/privacy_response.dart';
import '../model/help_support_ticket.dart';
import '../ui/hair_changer/m/hair_changer_response.dart';

Future<SignupResponse> signUp(Map<String, dynamic> map) async {
  var resp = await httpClient().post('/admin/users', data: map);
  return SignupResponse.fromJson(resp.data);
}

Future<SignupResponse> signIn(Map<String, dynamic> map) async {
  var resp = await httpClient().post('/admin/user-login', data: map);
  return SignupResponse.fromJson(resp.data);
}

Future<BasicResponse> updateProfile(Map<String, dynamic> map) async {
  var resp = await httpClientWithHeader().post('/admin/profile-update', data: map);
  await checkInvalidToken(resp);
  return BasicResponse.fromJson(resp.data);
}

Future<SignupResponse> getProfile() async {
  var resp = await httpClientWithHeader().get('/admin/view-profile');
  await checkInvalidToken(resp);
  return SignupResponse.fromJson(resp.data);
}

Future<SignupResponse> getProfileByEmail(String email) async {
  var resp = await httpClient().get('/profile-by-email?email=$email');
  return SignupResponse.fromJson(resp.data);
}

Future<BasicResponse> addDocument(FormData data) async {
  var resp = await httpClientWithHeader().post('/documents/add-documents', data: data);
  await checkInvalidToken(resp);
  return BasicResponse.fromJson(resp.data);
}

Future<DocumentResponse> getDocument(Map<String, dynamic> map) async {
  var resp = await httpClientWithHeader().post('/documents/get-documents-list', data: map);
  await checkInvalidToken(resp);
  return DocumentResponse.fromJson(resp.data);
}

Future<BasicResponse> deleteDocument(id) async {
  var resp = await httpClientWithHeader().delete('/documents/delete/$id');
  await checkInvalidToken(resp);
  return BasicResponse.fromJson(resp.data);
}

Future<BasicResponse> deleteAccount() async {
  var resp = await httpClientWithHeader().delete('/admin/delete-account');
  await checkInvalidToken(resp);
  return BasicResponse.fromJson(resp.data);
}

Future<BasicResponse> changePassword(Map<String, dynamic> map) async {
  var resp = await httpClientWithHeader().post('/admin/change-password', data: map);
  await checkInvalidToken(resp);
  return BasicResponse.fromJson(resp.data);
}

Future<BasicResponse> forgetPassword(Map<String, dynamic> map) async {
  var resp = await httpClientWithHeader().post('/admin/forgot-password', data: map);
  return BasicResponse.fromJson(resp.data);
}

Future<PrivacyResponse> getPrivacyPolicy() async {
  var resp = await httpClientWithHeader().get('/settings/privacy-policy');
  await checkInvalidToken(resp);
  return PrivacyResponse.fromJson(resp.data);
}

Future<PrivacyResponse> getTermCondition() async {
  var resp = await httpClientWithHeader().get('/settings/terms-and-conditions');
  await checkInvalidToken(resp);
  return PrivacyResponse.fromJson(resp.data);
}

Future<AmountResponse> getAmountPerPage() async {
  var resp = await httpClientWithHeader().get('/settings/amount-per-page-black');
  return AmountResponse.fromJson(resp.data);
}

Future<AmountResponse> getAmountPerPageColor() async {
  var resp = await httpClientWithHeader().get('/settings/amount-per-page-color');
  return AmountResponse.fromJson(resp.data);
}

Future<BasicResponse> addHelpSupportTicket(Map<String, dynamic> map) async {
  try {
    var resp = await httpClientWithHeader().post('/help_support/add-help_support', data: map);
    await checkInvalidToken(resp);
    return BasicResponse.fromJson(resp.data);
  } catch (e) {
    print('Add Ticket Error: $e');
    rethrow;
  }
}

Future<List<HelpSupportTicket>> getHelpSupportTickets(Map<String, dynamic> map) async {
  try {
    var resp = await httpClientWithHeader().post('/help_support/get-help_support-list', data: map);
    await checkInvalidToken(resp);
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

Future<Map<String, dynamic>> getRazorpayCredentials() async {
  try {
    var resp = await httpClient().post(
      '/razorpay/get-credentails',
      data: {"status": "active"},
    );
    await checkInvalidToken(resp);
    if (resp.statusCode == 200 && resp.data['success'] == true) {
      final List<dynamic> credsList = resp.data['data'];
      if (credsList.isNotEmpty) {
        return credsList.first;
      } else {
        throw Exception("No Razorpay credentials found");
      }
    } else {
      throw Exception(resp.data['message'] ?? "Failed to fetch Razorpay credentials");
    }
  } catch (e) {
    print("Error fetching Razorpay credentials: $e");
    rethrow;
  }
}

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


Future<HairChangerResponse> processHairTransformation({
  required File imageFile,
  required String? userId,
  required String transformationType,
  String? colorDescription,
  String? hairstyleDescription,
}) async {
  try {
    final FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: 'hair_changer_${DateTime.now().millisecondsSinceEpoch}.jpg',
        contentType: DioMediaType('image', 'jpeg'),
      ),
      'user_id': userId ?? '',
      'transformation_type': transformationType,
    });

    if (colorDescription != null && colorDescription.trim().isNotEmpty) {
      formData.fields.add(MapEntry('color_description', colorDescription.trim()));
    }

    if (hairstyleDescription != null && hairstyleDescription.trim().isNotEmpty) {
      formData.fields.add(MapEntry('hairstyle_description', hairstyleDescription.trim()));
    }

    final response = await httpClientWithHeader().post(
      '/hair-changer/change-hair',
      data: formData,
      options: Options(contentType: 'multipart/form-data',
        receiveTimeout: const Duration(minutes: 5)),
    );

    print('Hair transformation response: ${response.data}');
    if (response.statusCode == 200 && response.data['success'] == true) {
      return HairChangerResponse(
        success: true,
        referenceId: response.data['data']?['referenceId'],
        originalImageUrl: response.data['data']?['originalImageUrl'],
        resultUrl: response.data['data']?['resultImageUrl'],
        status: response.data['data']?['status'],
        message: response.data['message'],
      );
    } else {
      return HairChangerResponse(
        success: false,
        error: response.data['message'] ?? 'Failed to process hair transformation',
      );
    }
  } on DioException catch (e) {
    print('Hair transformation Dio error: ${e.response?.data ?? e.message}');
    return HairChangerResponse(
      success: false,
      error: _parseDioError(e),
    );
  } catch (e) {
    print('Hair transformation error: $e');
    return HairChangerResponse(
      success: false,
      error: e.toString(),
    );
  }
}


/// Utility Classes and Methods
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

String _parseDioError(DioException dioError) {
  if (dioError.response?.data != null) {
    final data = dioError.response!.data;
    if (data is Map<String, dynamic> && data['message'] != null) {
      return data['message'].toString();
    }
  }
  return dioError.message ?? 'Unknown network error';
}

Future<void> checkInvalidToken(Response response) async {
  if (response.data != null && response.data['message'] == 'Invalid Token') {
    await Logout();
    Get.offAll(() => const LoginPage());
    return;
  }
}