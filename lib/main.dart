import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Sederhana',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,        
        fontFamily: 'Inter', 
      ),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  // STATE UNTUK MENYIMPAN NILAI YANG DITAMPILKAN DI LAYAR
  String output = "0";
  
  // VARIABEL YANG DIGUNAKAN UNTUK MENYIMPAN NILAI SEMENTARA DAN OPERASI  
  String _output = "0"; 
  double num1 = 0.0;     
  double num2 = 0.0;     
  String operand = ""; // (+, -, x, /, =)

  // LOGIKA UTAMA YANG DIPANGGIL SAAT TOMBOL DITEKAN
  void buttonPressed(String buttonText) {
    // 1. LOGIKA TOMBOL C (CLEAR)
    if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } 
    // 2. LOGIKA OPERATOR (+, -, x, /, =)
    else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0"; // RESET OUTPUT UNTUK ANGKA KEDUA
    } 
    // 3. LOGIKA TOMBOL DESIMAL (.)
    else if (buttonText == ".") {
      // PASTIKAN TITIK HANYA ADA SATU KALI
      if (_output.contains(".")) {
        return;
      }
      _output = _output + buttonText;
    } 
    // 4. LOGIKA TOMBOL SAMA DENGAN (=)
    else if (buttonText == "=") {
      num2 = double.parse(output);

      // MENGGUNAKAN PERCABANGAN (IF/ELSE IF) UNTUK MENENTUKAN OPERSAI
      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "x") {
        _output = (num1 * num2).toString();
      } else if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      // ATUR ULANG VARIABEL UNTUK OPERASI BERIKUTNYA
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } 
    // 5. LOGIKA TOMBOL ANGKA (0-9)
    else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    // MENGUBAH HASIL PEMBAGIAN DESIMAL AGAR LEBIH RAPI
    // MISALNYA 5.0 MENJADI 5    
    if (_output.endsWith(".0")) {
      _output = _output.substring(0, _output.length - 2);
    }

    // MEMANGGIL setState() UNTUK MEMPERBARUI UI
    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
      // JIKA HASILNYA INTEGER, TAMPILKAN TANPA DESIMAL
      if (output.endsWith(".00")) {
        output = output.substring(0, output.length - 3);
      }
    });
  }

  // WIDGET UNTUK TOMBOL KALKULATOR YANG BISA DIGUNAKAN KEMBALI (REUSABLE WIDGET)  
  Widget buildButton(String buttonText, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        child: MaterialButton(
          padding: const EdgeInsets.all(24.0),
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), 
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () => buttonPressed(buttonText),        
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(        
        title: Padding(
          padding: EdgeInsets.only(top: 30),          
          child: Center(
            child: Text(
              "Kalkulator",
              style: TextStyle(
                color: Colors.white
              ),              
            ),
          )
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.blueGrey[800],                
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(          
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),              
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                ),
              ),
            ),
            const Expanded(
              child: Divider(),
            ),            
            Column(children: [
              Row(children: [
                buildButton("C", Colors.red),
                buildButton("(", Colors.blueGrey),
                buildButton(")", Colors.blueGrey),
                buildButton("/", Colors.orange),
              ]),
              Row(children: [
                buildButton("7", Colors.blueGrey),
                buildButton("8", Colors.blueGrey),
                buildButton("9", Colors.blueGrey),
                buildButton("x", Colors.orange),
              ]),
              Row(children: [
                buildButton("4", Colors.blueGrey),
                buildButton("5", Colors.blueGrey),
                buildButton("6", Colors.blueGrey),
                buildButton("-", Colors.orange),
              ]),
              Row(children: [
                buildButton("1", Colors.blueGrey),
                buildButton("2", Colors.blueGrey),
                buildButton("3", Colors.blueGrey),
                buildButton("+", Colors.orange),
              ]),
              Row(children: [
                buildButton("0", Colors.blueGrey),
                buildButton(".", Colors.blueGrey),                
                buildButton("=", Colors.green), 
              ])
            ])
          ],
        ),
      ),
    );
  }
}
