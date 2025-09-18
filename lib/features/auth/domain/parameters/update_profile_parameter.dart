import 'package:equatable/equatable.dart';

class UpdateProfileParameter extends Equatable {
  final String email;
  final String phone;
  final String? iin;
  final String firstName;
  final String lastName;
  final String? patronymic;

  const UpdateProfileParameter({
    required this.email,
    required this.phone,
    this.iin,
    required this.firstName,
    required this.lastName,
    this.patronymic,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'iin': iin,
      'first_name': firstName,
      'last_name': lastName,
      'patronymic': patronymic,
    };
  }

  UpdateProfileParameter copyWith({
    String? email,
    String? phone,
    String? iin,
    String? firstName,
    String? lastName,
    String? patronymic,
  }) {
    return UpdateProfileParameter(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      iin: iin ?? this.iin,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      patronymic: patronymic ?? this.patronymic,
    );
  }

  @override
  List<Object?> get props =>
      [email, phone, iin, firstName, lastName, patronymic];
}
