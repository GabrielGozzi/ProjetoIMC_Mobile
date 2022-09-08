import 'package:flutter/material.dart';



void main() { 
  runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Home(),
));
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

@override
_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> { 
  String _info = "Informe seus dados. ";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void _resetFields(){
    pesoController.text = '';
    alturaController.text = '';
    setState(() {
      _info = "Informe seus Dados. ";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular(){
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      print(imc);
      if (imc < 18.6){
        _info = 'Abaixo do Peso (${imc.toStringAsPrecision(3)}';
      } else if (imc >= 18.6 && imc < 24.9){
        _info = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
      }else if (imc >= 24.9 && imc < 29.9){
        _info = 'Levemente Acima do Peso (${imc.toStringAsPrecision(3)})';
      }else if (imc >= 29.9 && imc < 34.9){
        _info = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
      }else if (imc >= 34.9 && imc < 39.9){
        _info = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
      }else if (imc >= 40){
        _info = 'Obesidade Grau III(${imc.toStringAsPrecision(3)})';
      }
    });
  }
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: const Text ("Calcular IMC"),
      centerTitle: true,
      backgroundColor: Colors.purple,
      actions: <Widget>[
        IconButton(icon: const Icon(Icons.refresh), onPressed: _resetFields)
      ],
    ),
    backgroundColor: Colors.black,
    body: SingleChildScrollView(
     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
     child: Form(
       key: _formKey,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           const Icon(Icons.person_outline,
           size: 120.0, color: Colors.purple),
           TextFormField(
             keyboardType: TextInputType.number,
             decoration: const InputDecoration(
               labelText: "Peso (kg)",
               labelStyle: TextStyle(color: Colors.purple)),
               textAlign: TextAlign.center,
               style: const TextStyle(color: Colors.purple, fontSize: 25.0),
               controller: pesoController,
               validator: (value){
                 if (value! .isEmpty) {
                   return "Insira seu Peso!";
                 }
                 return null;
               },
             ),
             TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Altura (CM)",
                labelStyle: TextStyle(color: Colors.purple)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: alturaController,
                validator: (value){
                  if (value! .isEmpty){
                    return "Insira sua Altura! ";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: SizedBox(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        _calcular();
                      }
                    },
                    color: Colors.purple,
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )))),
                    Text(
                      _info,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                  ),
                )));

}
}



