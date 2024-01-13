import 'package:catalog_clone/screen/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: context.theme.canvasColor,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const HeightBox(10),
                Image.asset(
                  "assests/images/login.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Welcome $name",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: context.theme.hintColor,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(
                            "UserName",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          hintText: "Enter UserName",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;

                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text(
                            "Password",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          hintText: "Enter password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is empty";
                          } else if (value.length < 5) {
                            return "password length should be atleast 5";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // used for inbuilt botton
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, MyRoutes.catalogRoute);
                      //   }, // change screen,
                      //   style:
                      //       TextButton.styleFrom(minimumSize: const Size(100, 40)),
                      //   child: const Text("Sign In"),
                      // ),

                      // create a customize buttom

                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // async is used for await
                            setState(() {
                              changeButton = true;
                            });
                            // wait to travel from one page to another
                            await Future.delayed(const Duration(seconds: 1));
                            // ignore:

                            // ignore: use_build_context_synchronously
                            await Navigator.pushNamed(
                                context, MyRoutes.catalogRoute);

                            // we cant go back to the previous page

                            // await Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const CatalogScreen()),
                            // );

                            setState(() {
                              changeButton = false;
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: changeButton ? 0 : 100,
                          height: changeButton ? 0 : 40,
                          alignment: Alignment.center,
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
