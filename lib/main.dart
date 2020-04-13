import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Basic Calculator'),
            backgroundColor: Colors.red,
          ),
          body: MyApp(),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCalculator();
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";

  calculatorOperation(String text) {
    setState(() {
      if (text == "C") {
        equation = "0";
        result = "0";
      } else if (text == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (text == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = text;
        } else {
          equation = equation + text;
        }
      }
    });
  }

  Widget appButton(String text, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: FlatButton(
        color: buttonColor,
        shape: CircleBorder(
          side: BorderSide(
              color: Colors.black, width: 1, style: BorderStyle.solid),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onPressed: () {
          calculatorOperation(text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // outer shape
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.00),
          ),
          boxShadow: const [
            BoxShadow(blurRadius: 10),
          ]),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
      child: Column(
        //screen column
        children: <Widget>[
          Container(
            //screen design
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: const [BoxShadow(blurRadius: 2)]),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                  child: Text(
                    equation,
                    style: TextStyle(fontSize: 28.0),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 28.0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        appButton('C', Colors.redAccent),
                        appButton('⌫', Colors.redAccent),
                        appButton('+/-', Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        appButton('7', Colors.white),
                        appButton('8', Colors.white),
                        appButton('9', Colors.white),
                      ],
                    ),
                    TableRow(children: [
                      appButton('4', Colors.white),
                      appButton('5', Colors.white),
                      appButton('6', Colors.white),
                    ]),
                    TableRow(children: [
                      appButton('1', Colors.white),
                      appButton('2', Colors.white),
                      appButton('3', Colors.white),
                    ]),
                    TableRow(children: [
                      appButton('0', Colors.white),
                      appButton('.', Colors.white),
                      appButton('00', Colors.yellowAccent),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: Table(
                  children: [
                    TableRow(children: [
                      appButton('+', Colors.yellowAccent),
                    ]),
                    TableRow(children: [
                      appButton('-', Colors.yellowAccent),
                    ]),
                    TableRow(children: [
                      appButton('÷', Colors.yellowAccent),
                    ]),
                    TableRow(children: [
                      appButton('x', Colors.yellowAccent),
                    ]),
                    TableRow(children: [appButton('=', Colors.yellowAccent)]),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }
}
