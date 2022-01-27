import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import '../model/profile.dart';
import '../no_internet.dart';
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
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? FutureBuilder(
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
                          backgroundColor: Colors.blue.shade100,
                          appBar: AppBar(
                            title: Text("Register Page",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold)),
                            iconTheme: IconThemeData(color: Colors.black54),
                            backgroundColor: Colors.blue.shade100,
                            elevation: 0,
                          ),
                          body: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    scale: 5,
                                    image: AssetImage('assets/images/cut.png'),
                                    alignment: Alignment.bottomCenter),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Form(
                                    key: formkey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.person_outline),
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  child: TextFormField(
                                                    validator: MultiValidator([
                                                      RequiredValidator(
                                                          errorText:
                                                              'Please enter your email'),
                                                      EmailValidator(
                                                          errorText:
                                                              'Please enter the correct form of email')
                                                    ]),
                                                    maxLines: 1,
                                                    decoration:
                                                        const InputDecoration(
                                                      label: Text(" Email"),
                                                      border: InputBorder.none,
                                                    ),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    onSaved: (String? email) {
                                                      profile.email = email!;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.lock_outline),
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  child: TextFormField(
                                                      validator: RequiredValidator(
                                                          errorText:
                                                              'Please enter your password'),
                                                      maxLines: 1,
                                                      decoration:
                                                          const InputDecoration(
                                                        label:
                                                            Text(" Password"),
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      obscureText: true,
                                                      onSaved:
                                                          (String? password) {
                                                        profile.password =
                                                            password!;
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: TextButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Color(0xFF2C72CE),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 50,
                                                    vertical: 10),
                                              ),
                                              onPressed: () async {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  formkey.currentState!.save();
                                                  try {
                                                    await FirebaseAuth.instance
                                                        .createUserWithEmailAndPassword(
                                                            email:
                                                                profile.email,
                                                            password: profile
                                                                .password)
                                                        .then((value) {
                                                      formkey.currentState!
                                                          .reset();
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Enter your information to complete the registration.',
                                                          gravity: ToastGravity
                                                              .CENTER);
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return profileForm();
                                                      }));
                                                    });
                                                  } on FirebaseAuthException catch (e) {
                                                    //print(e.code);
                                                    //print(e.message);
                                                    Fluttertoast.showToast(
                                                        msg: e.message!,
                                                        gravity: ToastGravity
                                                            .CENTER);
                                                  }
                                                }
                                              },
                                              child: Text(
                                                'Sign Up',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    )),
                              )));
                    }
                    return Container(
                      child: Center(
                        child: NoInternet(),
                      ),
                    );
                  })
              : NoInternet();
        }
        return Container(
          child: Center(
            child: NoInternet(),
          ),
        );
      },
    );
  }
}
