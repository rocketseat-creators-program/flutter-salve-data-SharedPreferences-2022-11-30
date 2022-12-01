import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _value = false;
  late SharedPreferences prefs; 
  final controllerUser = TextEditingController();
  final controllerPass = TextEditingController();

  @override
  void initState() {
    super.initState();
   _init(); 
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
    //obter os dados salvos
    controllerUser.text = prefs.getString('user') ?? '';
    controllerPass.text = prefs.getString('pass') ?? '';
    _value = prefs.getBool('remember') ?? false;
    setState(() {
      
    });
  }

  Widget _buildLogin() {
    return Center(
      child: Container(
        height: 300,
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: controllerUser,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Usuário'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controllerPass,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Senha'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              title: const Text('Lembrar'),
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = !_value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  if(_value){
                    prefs.setString('user', controllerUser.text);
                    prefs.setString('pass', controllerPass.text);
                    prefs.setBool('remember', _value);
                  }else{
                    prefs.remove('user');
                    prefs.remove('pass');
                    prefs.remove('remember');  
                  }
                },
                child: const Text('Logar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: _buildLogin(),
    );
  }
}
