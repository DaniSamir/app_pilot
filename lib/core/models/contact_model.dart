import 'dart:convert';
import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  final String nameUser;
  final String phone;
  final String email;
  final String? userId;
  final bool? isFavorite;

  const ContactModel({required this.nameUser, required this.phone, required this.email, this.userId, this.isFavorite});

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    return {
      "nameUser": nameUser,
      "phone": phone,
      "email": email,
      "userId": userId,
      "isFavorite": isFavorite,
    };
  }

  static ContactModel fromMap(Map<String, dynamic> map) {
    return ContactModel(
      nameUser: map['nameUser'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      userId: map['userId'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  static ContactModel fromJson(String source) => fromMap(json.decode(source));
}
