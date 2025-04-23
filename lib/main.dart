import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _age;
  double? _salary;
  String _finaloutput = '';

  final TextEditingController _ageCtrl = new TextEditingController(text: '');
  final TextEditingController _salaryCtrl = new TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();
  final _focusNode = new FocusNode();

  void determineResult() {
    if (_age! <= 59) {
      double _salaryInt = _salary! * 0.005;
      double _salaryInt2 = _salary! * 0.0175;
     setState(() {
       _finaloutput =
       'Employee Contribution: 0.5%'
           '\nEmployee Contribution Salary: RM${_salaryInt.toStringAsFixed(2)}'
           '\nEmployer Contribution: 1.75%'
           '\nEmployer Contribution Salary: RM${_salaryInt2.toStringAsFixed(2)}';
     });
    } else {
      double _salaryInt = _salary! * 0.0125;

      setState(() {
        _finaloutput =
        'Employee Contribution: 0%'
            '\nEmployee Contribution Salary: RM0'
            '\nEmployer Contribution: 1.75%'
            '\nEmployer Contribution Salary: RM${_salaryInt.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Age'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _ageCtrl,
                validator: (value) {
                  if (value == '') {
                    return 'Field is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _age = int.parse(_ageCtrl.text);
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(hintText: 'Gross Salary'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _salaryCtrl,
                validator: (value) {
                  if (value == '') {
                    return 'Field is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _salary = double.parse(_salaryCtrl.text);
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        determineResult();
                      }
                    },
                    child: Text('Calculate'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _ageCtrl.text = '';
                      _age = null;
                      _salaryCtrl.text = '';
                      _salary = null;
                      setState(() {
                        _finaloutput = "";
                      });
                    },
                    child: Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(_finaloutput),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ageCtrl.dispose();
    _salaryCtrl.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
