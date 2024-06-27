class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  // Firestore로 저장할 때 사용하는 Map 형태로 변환
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  // Firestore로부터 데이터를 받아올 때 사용하는 팩토리 생성자
  factory User.fromMap(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      name: data['name'],
      email: data['email'],
    );
  }
}
