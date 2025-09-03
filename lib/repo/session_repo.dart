import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart'; // Not Used
import 'package:ipbot_app/model/user_detail.dart';
import 'package:ipbot_app/repo/setting_repo.dart';

// Future CreateSession(data, isLogin) async { // We need to use 'CreateSession' as createSession
Future CreateSession(data, isLogin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogin", isLogin);
  prefs.setString('data', jsonEncode(data));
  getSession();
}

Future<UserDetail> getSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // print("session ${prefs.getString('data')}");
  log("session ${prefs.getString('data')}");
  UserDetail details =
      UserDetail.fromJson(jsonDecode(prefs.getString('data') ?? "{}"));
  auth.value = details;
  return details;
}

setSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLogin', true);
}

// Logout() async { // We need to use 'Logout' as logout
Logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<bool> isLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("isLogin") ?? false;
}
