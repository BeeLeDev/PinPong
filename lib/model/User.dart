

class User {
  String name;
  String studentId;
  String? uid;

  User({required this.name, required this.studentId});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      studentId: map['studentId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'studentId': studentId,
    };
  }
}