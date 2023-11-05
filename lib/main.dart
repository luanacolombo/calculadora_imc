import 'package:flutter/material.dart';

//void main, função principal, onde o código começa
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//_ na frente, significa que é privada
class _HomeState extends State<Home> {
  //controlador do peso
  TextEditingController weightController = TextEditingController();
  //controlador da altura
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!"; //modifica o texto

  void _resetFields() {
    weightController.text = ""; //diz que o texto do controlador é vazio
    heightController.text = ""; //diz que o texto do controlador é vazio
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      //pega o texto e transforma em double
      double weight = double.parse(weightController.text);
      double height =
          double.parse(heightController.text) / 100; //p/ transformar em metros
      //calcula o imc
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          centerTitle: true, //centraliza o texto
          backgroundColor: Colors.green, //cor da appBar
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white, //cor do fundo
        //corpo do app
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, //stretch tenta alargar tudo que tem na coluna
              children: [
                const Icon(Icons.person_outline,
                    size: 120.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle:
                          TextStyle(color: Color.fromARGB(235, 76, 175, 79))),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    //chama a função
                    if (value!.isEmpty) {
                      //se o valor estiver vazio
                      return "Insira seu Peso"; //mostra a mensagem de erro
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    //chama a função
                    if (value!.isEmpty) {
                      //se o valor estiver vazio
                      return "Insira sua Altura"; //mostra a mensagem de erro
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.green),
                      ),
                      child: const Text(
                        "Calcular",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //se for válido, calcula
                          _calculate();
                        }
                      },
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
