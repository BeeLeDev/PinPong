

class User {
  String name;
  String studentId;
  String? uid;

  User(this.name, this.studentId);

  String getUid() {
    return uid == null ? "Unknown" : uid!;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'studentId': studentId,
    };
  }
}