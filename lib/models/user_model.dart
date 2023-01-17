class AuthUser {
  final String id;
  final String email;
  final String? name;

  AuthUser({required this.id, required this.email, this.name});

  Map<String, dynamic> toJson() => {'username': name, 'id': id, 'email': email};
}
