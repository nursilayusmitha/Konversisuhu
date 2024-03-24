import 'package:flutter/material.dart';

void main() {
  runApp(SuhuConverterApp());
}

class SuhuConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konverter Suhu - Nursila',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[800],
      ),
      debugShowCheckedModeBanner: false, // Hilangkan debug watermark
      home: SuhuConverterPage(),
    );
  }
}

class SuhuConverterPage extends StatefulWidget {
  @override
  _SuhuConverterPageState createState() => _SuhuConverterPageState();
}

class _SuhuConverterPageState extends State<SuhuConverterPage> {
  double _inputSuhu = 0.0;
  String _selectedInputSuhu = 'Celsius';
  Map<String, String> _outputSuhu = {
    'Celsius': '',
    'Fahrenheit': '',
    'Kelvin': '',
    'Reamur': '',
  };

  void _konversiSuhu(double inputSuhu, String selectedInputSuhu) {
    double celsius;
    switch (selectedInputSuhu) {
      case 'Celsius':
        celsius = inputSuhu;
        break;
      case 'Fahrenheit':
        celsius = (inputSuhu - 32) * (5 / 9);
        break;
      case 'Kelvin':
        celsius = inputSuhu - 273.15;
        break;
      case 'Reamur':
        celsius = inputSuhu * (5 / 4);
        break;
      default:
        celsius = inputSuhu;
    }

    setState(() {
      // Konversi suhu ke format yang diinginkan
      _outputSuhu['Celsius'] = _formatOutput(celsius);
      _outputSuhu['Fahrenheit'] = _formatOutput(celsius * (9 / 5) + 32);
      _outputSuhu['Kelvin'] = _formatOutput(celsius + 273.15);
      _outputSuhu['Reamur'] = _formatOutput(celsius * (4 / 5));
    });
  }

  String _formatOutput(double value) {
    // Mengambil dua angka dibelakang koma, jika ada
    String formattedValue = value.toStringAsFixed(2);
    // Menghapus angka desimal 0 di belakang koma jika ada
    formattedValue = double.parse(formattedValue).toString();
    return formattedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Konverter Suhu',
          style: TextStyle(color: Colors.white,)
          ),
        backgroundColor: Colors.blue[600], 
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Masukkan Suhu',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true), // Memungkinkan input desimal
              onChanged: (value) {
                setState(() {
                  _inputSuhu = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedInputSuhu,
              items: <String>['Celsius', 'Fahrenheit', 'Kelvin', 'Reamur']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white),),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedInputSuhu = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _konversiSuhu(_inputSuhu, _selectedInputSuhu);
              },
              child: Text (
                'Konversi',
                style: TextStyle(color: Colors.white,),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 30, 136, 229)),
              ),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(color: Colors.blue),
              children: _outputSuhu.keys.map((key) {
                return TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '$key:',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          _outputSuhu[key]!,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
