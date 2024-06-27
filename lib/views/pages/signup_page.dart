import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vranchat/views/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String email = _emailController.text;
        String password = _passwordController.text;
        String name = _nameController.text;
        String id = _idController.text;

        // 이름 및 ID 중복 확인
        QuerySnapshot nameQuery = await _firestore
            .collection('mungnyan')
            .where('name', isEqualTo: name)
            .get();

        QuerySnapshot idQuery = await _firestore
            .collection('mungnyan')
            .where('id', isEqualTo: id)
            .get();

        if (nameQuery.docs.isNotEmpty || idQuery.docs.isNotEmpty) {
          setState(() {
            _isLoading = false;
          });

          String duplicateField = nameQuery.docs.isNotEmpty ? '이름' : 'ID';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('이미 사용 중인 $duplicateField입니다.')),
          );
          return;
        }

        // Firebase Auth로 회원가입
        // UserCredential userCredential =
        //     await _auth.createUserWithEmailAndPassword(
        //   email: email,
        //   password: password,
        // );

        // Firestore에 사용자 정보 저장
        await _firestore.collection('mungnyan').doc(name).set({
          'name': name,
          'email': email,
          'id': id,
          'password': password, // 실제 앱에서는 비밀번호를 암호화하여 저장해야 함
        });

        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(), // 로그인 페이지로 이동
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });

        String message;
        switch (e.code) {
          case 'email-already-in-use':
            message = '이미 사용 중인 이메일입니다.';
            break;
          case 'weak-password':
            message = '비밀번호가 너무 약합니다.';
            break;
          case 'invalid-email':
            message = '잘못된 이메일 형식입니다.';
            break;
          default:
            message = '회원가입에 실패했습니다. 다시 시도해주세요.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  // 데이터 조회 함수
  void getData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('mungnyan')
          .doc('Brf2RQtAQX0PHJojcvai')
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          print("Email: ${data['email']}");
          print("Name: ${data['name']}");
          print("ID: ${data['id']}");
          print("Password: ${data['password']}");
        }
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이름을 입력하세요';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이메일을 입력하세요';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return '유효한 이메일 주소를 입력하세요';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _idController,
                        decoration: InputDecoration(labelText: 'ID'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ID를 입력하세요';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호를 입력하세요';
                          }
                          if (value.length < 6) {
                            return '비밀번호는 6자 이상이어야 합니다';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signup,
                        child: Text('Signup'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: getData,
                        child: Text('Get Data'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
