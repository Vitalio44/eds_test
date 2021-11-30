import 'dart:convert';

import 'address.dart';
import 'company.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Address address;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address.toMap(),
      'company': company.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      website: map['website'],
      address: Address.fromMap(map['address']),
      company: Company.fromMap(map['company']),
    );
  }

  static List<User> fromList(String source) {
    final userList = json.decode(source) as List;
    return userList
        .map((user) => User(
              id: user['id'],
              name: user['name'],
              username: user['username'],
              email: user['email'],
              phone: user['phone'],
              website: user['website'],
              address: Address.fromMap(user['address']),
              company: Company.fromMap(user['company']),
            ))
        .toList();
  }

  List paramsToList() =>
      [name, username, email, phone, website, company, address];

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
