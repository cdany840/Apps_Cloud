import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/custom/widgets/custom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();
    final txtUser = CustomTextField(
      controller: txtConUser
    );
    final txtPass = CustomTextField(
      controller: txtConPass
    );

    final imgLogo = Container(
      width: 160,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://cdn-icons-png.flaticon.com/512/1090/1090806.png')
          // image: NetworkImage('https://static.vecteezy.com/system/resources/previews/022/911/694/large_2x/cute-cartoon-burger-icon-free-png.png')
          )
        ),
    );

    final btnEntrar = CustomFloatingActionButton(
      icon: Icons.login,
      text: 'Login',
      onPressed: () => Navigator.pushNamed(context, '/dash')
    );

    final checkSesion = Checkbox(
      activeColor: const Color.fromARGB(255, 234, 111, 166),
      value: GlobalValues.prefsCheck.getBool('checkValue') ?? false,
      onChanged: (bool? value) {
        setState(() {
          GlobalValues.prefsCheck.setBool('checkValue', value!);
          // isChecked = value!;
        });
      },
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('https://www.xtrafondos.com/wallpapers/vertical/el-hombre-arana-de-cabeza-7051.jpg')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // imgFondo,
              Container(
                height: 200,
                padding: const EdgeInsets.all(30),
                margin:  const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 180, 24, 204)
                ),
                // color: Colors.red,
                child: Column(
                  // padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    txtUser,
                    const SizedBox(height: 10),
                    txtPass
                  ],
                ),
              ),
              imgLogo
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          btnEntrar,
          checkSesion,
          const Text('Recordar')
        ],
      )
      // FloatingActionButtonLocation.centerDocked,
    );
  }
}