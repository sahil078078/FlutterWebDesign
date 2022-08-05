import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserDetails {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;
  UserDetails({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: Address.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      company: Company.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'phone': phone,
        'website': website,
        'address': address.toJson(),
        'company': company.toJson(),
      };
}

class Address {
  final String street, suite, city, zipcode;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
    );
  }

  Map<String, dynamic> toJson() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
      };
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };
}

Future<List<UserDetails>?> getUserDetails() async {
  Dio dio = Dio();
  const String url = 'http://jsonplaceholder.typicode.com/users';

  try {
    Response response = await dio.get(
      url,
      options: Options(
        validateStatus: (status) {
          return (status == 200 || status == 404);
        },
      ),
    );

    log('statusCode : ${response.statusCode}');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => UserDetails.fromJson(e))
          .toList();
    } else {
      return null;
    }
  } on DioError catch (e) {
    if (kDebugMode) {
      log('DioCatchError : $e');
    }
    return null;
  } catch (e) {
    if (kDebugMode) {
      log('CatchError : $e');
    }
    return null;
  }
}
