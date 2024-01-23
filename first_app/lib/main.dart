import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculatrice());
}

class Calculatrice extends StatelessWidget {
  const Calculatrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculatrice",
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(color: Colors.blue),
        primarySwatch: Colors.cyan,
        // Changez la couleur de fond de l'AppBar ici
      ),
      home: const SimpleCalculatrice(),
      // On doit créer le widget de type stateful, ce widget pourra changer d'état
    );
  }
}

class SimpleCalculatrice extends StatefulWidget {
  const SimpleCalculatrice({Key? key}) : super(key: key);

  @override
  _SimpleCalculatriceState createState() => _SimpleCalculatriceState();
}

class _SimpleCalculatriceState extends State<SimpleCalculatrice> {

  String expression ="0";
  String equation = "0";
  String resultat = "0";

Boutonpresse(String textBouton) {
    print(textBouton);
    setState(() { // setSate se défini à l'interieur de la Class et dans un widget statefulwidget permet de mettre à jour l'écran

      if(textBouton=="C"){
       equation="0";
       resultat="0";
       //on remet tout à zéro
      }else if (textBouton=="⌦"){
        equation = equation.substring(0, equation.length-1);
        if(equation.isEmpty){
          equation="0";
        }
      }else if(textBouton=="="){
        //expression math
        expression = equation;
        expression = expression.replaceAll("✕", "*");
try{

  Parser p = Parser();
  Expression exp = p.parse(expression);
  ContextModel  cm = ContextModel();
  resultat = "${exp.evaluate(EvaluationType.REAL, cm)}";

} catch(e) {
  resultat ="Erreur de syntaxe";
  print(e);


}
      }else{
        if (equation=="0"){
          equation = textBouton;
        }else{
          equation = equation + textBouton; // Le plus ici vu que c'est un text correspond à une concatenation
        }
      }
      //equation = equation + textBouton;
    });
  }


//fonction pour générer des boutons j'y fais appelle dans le build plus bas
  Widget BoutonCalculatrice(String textBouton, Color couleurText, Color couleurBouton){
    return Container(

      height: MediaQuery.of(context).size.height*0.1,
      color: couleurBouton,
      child: MaterialButton(
        onPressed: ()=> Boutonpresse(textBouton),
        padding: EdgeInsets.all(16),
        child: Text(textBouton, style: TextStyle(color: couleurText, fontSize: 30, fontWeight: FontWeight.normal),),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculatrice"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child:  Text(equation, style: TextStyle(fontSize: 35)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
            child: Text(resultat, style: TextStyle(fontSize: 35)),
          ),
          const Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Table(
                  children: [

                    TableRow( //premiere ligne
                      children: [
                        BoutonCalculatrice("C", Colors.red,Colors.white),
                        BoutonCalculatrice("⌦", Colors.blue,Colors.white),
                        BoutonCalculatrice("%", Colors.blue,Colors.white),
                        BoutonCalculatrice("/", Colors.blue,Colors.white),

                      ],
                    ),

                    TableRow(// deuxieme ligne
                      children: [
                        BoutonCalculatrice("7", Colors.blue,Colors.white),
                        BoutonCalculatrice("8", Colors.blue,Colors.white),
                        BoutonCalculatrice("9", Colors.blue,Colors.white),
                        BoutonCalculatrice("✕", Colors.blue,Colors.white),

                      ],
                    ),

                    TableRow(// 3e ligne
                      children: [
                        BoutonCalculatrice("4", Colors.blue,Colors.white),
                        BoutonCalculatrice("5", Colors.blue,Colors.white),
                        BoutonCalculatrice("6", Colors.blue,Colors.white),
                        BoutonCalculatrice("-", Colors.blue,Colors.white),

                      ],
                    ),

                    TableRow(// 4e ligne
                      children: [
                        BoutonCalculatrice("1", Colors.blue,Colors.white),
                        BoutonCalculatrice("2", Colors.blue,Colors.white),
                        BoutonCalculatrice("3", Colors.blue,Colors.white),
                        BoutonCalculatrice("+", Colors.blue,Colors.white),

                      ],
                    ),

                    TableRow(// 5e ligne
                      children: [
                        BoutonCalculatrice("C", Colors.blue,Colors.white),
                        BoutonCalculatrice("0", Colors.blue,Colors.white),
                        BoutonCalculatrice(".", Colors.blue,Colors.white),
                        BoutonCalculatrice("=", Colors.white,Colors.blue),

                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

