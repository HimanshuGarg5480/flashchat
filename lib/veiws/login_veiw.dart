import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_notes/firebase_options.dart';

class login_veiw extends StatefulWidget {
  const login_veiw({Key? key}) : super(key: key);

  @override
  State<login_veiw> createState() => _login_veiwState();
}

class _login_veiwState extends State<login_veiw> {
  late final TextEditingController _email;

  late final TextEditingController _password;
  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                // TODO: Handle this case.
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'enter your email'),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration:
                          InputDecoration(hintText: 'enter your password'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _email.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('user-not-found');
                          } else if (e.code == 'wrong-password') {
                            print('wrong-password');
                          } else {
                            print('Something bad happen');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('login'),
                    )
                  ],
                );

              default:
                return const Text('LODING');
            }
          },
        ),
      ),
    );
  }
}
