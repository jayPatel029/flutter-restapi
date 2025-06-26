import 'dart:convert';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  //base endpoint to fetch users
  static const String url = 'https://jsonplaceholder.typicode.com/users';

  //? fetch users from api and decode json to map it with User Model
  
  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
