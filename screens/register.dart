import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../model/profile.dart';
import '../screens/profileForm.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Register Page",
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.blue.shade200,
                ),
                body: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue.shade200, Colors.blueGrey],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your email'),
                                EmailValidator(
                                    errorText:
                                        'Please enter the correct form of email')
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String? email) {
                                profile.email = email!;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            TextFormField(
                                validator: RequiredValidator(
                                    errorText: 'Please enter your password'),
                                obscureText: true,
                                onSaved: (String? password) {
                                  profile.password = password!;
                                }),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      formkey.currentState!.save();
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: profile.email,
                                                password: profile.password)
                                            .then((value) {
                                          formkey.currentState!.reset();
                                          Fluttertoast.showToast(
                                              msg:
                                                  'User account has been created',
                                              gravity: ToastGravity.CENTER);
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return profileForm();
                                          }));
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        //print(e.code);
                                        //print(e.message);
                                        Fluttertoast.showToast(
                                            msg: e.message!,
                                            gravity: ToastGravity.CENTER);
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(fontSize: 20.0),
                                  )),
                            )
                          ],
                        )),
                  ),
                ));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
