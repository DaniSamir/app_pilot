import 'dart:convert';
import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  final String nameUser;
  final String phone;
  final String email;

  const ContactModel({
    required this.nameUser,
    required this.phone,
    required this.email,
  });

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    return {
      "nameUser": nameUser,
      "phone": phone,
      "email": email,
    };
  }

  static ContactModel fromMap(Map<String, dynamic> map) {
    return ContactModel(
      nameUser: map['nameUser'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  static ContactModel fromJson(String source) => fromMap(json.decode(source));
}
