class RegistrationModel{

  final String? registrationId;
  final String name;
  final String email;
  final String password;

  RegistrationModel({required this.name, required this.email, required this.password, this.registrationId});

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    registrationId: json['registrationId'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'registrationId':registrationId,
    'name':name,
    'email':email,
    'password':password
  };

}