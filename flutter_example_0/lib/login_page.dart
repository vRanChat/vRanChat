import 'package:flutter/material.dart';
import 'common/input_field.dart';
import 'common/button.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TEST_ID = "test";
  final TEST_PW = "1234";

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
              'assets/images/logo.png',
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120, // 첫 번째 텍스트의 너비 설정
                  child: const Text(
                    '비밀번호 찾기',
                    textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                  ),
                ),
                const SizedBox(width: 20), // 텍스트 사이에 간격 추가
                SizedBox(
                  width: 120, // 두 번째 텍스트의 너비 설정
                  child: const Text(
                    '회원가입',
                    textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // 상단 패딩 추가
            ElevatedButton(
              onPressed: () {
                String enteredUsername = _usernameController.text;
                String enteredPassword = _passwordController.text;

                // ID와 PW가 각각 "test"와 "1234"인 경우에만 메인 페이지로 이동
                if (enteredUsername == TEST_ID && enteredPassword == TEST_PW) {
                  Navigator.pushNamed(context, '/main');
                } else {
                  // 아니면 경고 메시지 출력 혹은 다른 조치를 취할 수 있음
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
              },
              // Expanded를 사용하여 버튼의 너비를 부모에 맞춤
              child: SizedBox(
                width: double.infinity, // 부모 위젯의 너비를 채움
                child: const Text(
                  'Login',
                  textAlign: TextAlign.center, // 텍스트를 가운데 정렬
                ),
              ),
            ),
            const SizedBox(height: 15), // 버튼 아래에 추가적인 공간을 주기 위한 패딩
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 30),
                Expanded(
                  child: Container(
                    width: 50, // 원의 지름
                    height: 50, // 원의 지름
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50, // 원의 지름
                    height: 50, // 원의 지름
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50, // 원의 지름
                    height: 50, // 원의 지름
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50, // 원의 지름
                    height: 50, // 원의 지름
                    decoration: BoxDecoration(
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
