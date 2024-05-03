import 'dart:convert';

class Contact {
  final String name;
  final String email;
  final String address;
  final String number;
  final String photo;

  Contact({
    required this.name,
    required this.email,
    required this.address,
    required this.number,
    required this.photo,
  });

  Contact copyWith({
    String? name,
    String? email,
    String? address,
    String? number,
    String? photo,
  }) {
    return Contact(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      number: number ?? this.number,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'address': address,
      'number': number,
      'photo': photo,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name:  map['name'] as String,
      email:  map['email'] as String,
      address:  map['address'] as String,
      number:  map['number'] as String,
      photo:  map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(name: $name, email: $email, address: $address, number: $number, photo: $photo)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.address == address &&
        other.number == number &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        address.hashCode ^
        number.hashCode ^
        photo.hashCode;
  }
}