import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String currency;

  const User({required this.name, required this.currency});

  Map<String, dynamic> toJson() => {'name': name, 'currency': currency};

  factory User.fromJson(Map<String, dynamic> json) =>
      User(name: json['name'] as String, currency: json['currency'] as String);

  @override
  List<Object?> get props => [name, currency];
}
