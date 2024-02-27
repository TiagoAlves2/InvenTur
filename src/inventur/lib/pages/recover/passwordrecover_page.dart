import 'package:flutter/material.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/pages/widgets/custom_text_field_widget.dart';
import 'package:inventur/pages/auth/email_validator_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class RecuperarSenha extends StatelessWidget {
  final EmailValidator _emailValidator = EmailValidator();
   final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: const EdgeInsets.all(45),
          child: Center(
          child: Container(
              padding: const EdgeInsets.all(20),
              height: sizeScreen.height * 0.35,
              width: sizeScreen.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              child: Expanded(
                  child: Column(children: [
                Image.asset(
                  'assets/images/novo.png', 
                  height: 40,
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child:  Text(
                      'Para garantir a segurança da sua conta, enviaremos um código de 6 dígitos para o e-mail cadastrado. Por favor, insira o código no aplicativo. O código tem validade de 15 minutos.',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),)
              ]))))),
    Padding(
          padding: EdgeInsets.all(25),
          child: CustomTextField(
                            labelText: 'E-mail',
                            controller: _emailController,
                            prefixIcon: FontAwesomeIcons.solidEnvelope,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              return _emailValidator.validate(email: email);
                            },
                          ),),
      Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 120),
          child: SizedBox(
            height: 50,
            width: 250,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => {
               
                     Navigator.pushNamed(context, '/ConfirmarCodigo')
              },
              child: const Text(
                'OBTER CÓDIGO',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ),
          )),
      SizedBox(
          height: 50,
          width: 250,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => {Navigator.pop(context)},
              child: const Text(
                'CANCELAR',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              )))
    ])));
  }
}