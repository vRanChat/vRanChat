import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../component/input_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void checkUserAndPassword(BuildContext context) async {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    try {
      // Firestore에서 users 컬렉션에서 username과 password가 일치하는 문서를 조회합니다.
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('mungnyan')
          .where('id', isEqualTo: enteredUsername)
          .where('password', isEqualTo: enteredPassword)
          .get();

      print(querySnapshot.docs.isNotEmpty);
      // 조회된 문서가 하나라도 있는지 확인합니다.
      if (querySnapshot.docs.isNotEmpty) {
        // 로그인 성공 시 '/main' 페이지로 이동
        Navigator.pushNamed(context, '/main');
      } else {
        // 일치하는 데이터가 없을 때 실행할 코드
        print('No matching user found.');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('로그인 실패'),
              content: const Text('올바른 ID와 PW를 입력하세요.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login Page'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'asset/images/logo.png',
              height: 50,
            ),
            const Text(
              '멍냥랜챗',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  top: 15.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18, // 텍스트 크기 설정
                  ),
                ),
              ),
            ),
            RoundedInputField(
              controller: _usernameController,
              labelText: 'ID',
            ),
            const SizedBox(height: 10),
            RoundedInputField(
              controller: _passwordController,
              labelText: 'PW',
              isPassword: true,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: 120,
                  child: Text(
                    '비밀번호 찾기',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 120,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      '회원가입',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // 상단 패딩 추가
            ElevatedButton(
              onPressed: () => checkUserAndPassword(context),
              // Expanded를 사용하여 버튼의 너비를 부모에 맞춤
              child: const SizedBox(
                width: double.infinity, // 부모 위젯의 너비를 채움
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 30),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
