import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  late String email, password; //final bizi göte getirebilir dikkat et
  final formKey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  RegisterPage({super.key});
// In another class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          color: Color.fromARGB(255, 213, 215, 220),
          height: 700,
          padding: EdgeInsets.only(top: 100, left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Yeni Bir \nHesap  Oluştur",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: TextFormField(
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Boş Bırakma";
                      }
                    },
                    onSaved: (value) {
                      email = value!;
                    },
                    decoration: InputDecoration(
                      hintText: "Kullanıcı Adı veya eposta",
                      prefixIcon: Icon(Icons.person, size: 30),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: TextFormField(
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Boş Bırakma";
                      }
                    },
                    onSaved: (value) {
                      password = value!;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Şifre",
                      prefixIcon: Icon(Icons.person, size: 30),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kayıt Ol ",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          try {
                            //var userResult =  belki kullanırım
                            await firebaseAuth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            formKey.currentState!.reset();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Kayıt olundu, giriş safasına yönlendiriliyorsunuz,"),
                              ),
                            );
                            Navigator.pushReplacementNamed(
                                context, "loginPage");
                          } catch (e) {
                            print(e.toString());
                          }
                        } else {}
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
