import 'package:flutter/material.dart';
import 'package:flutter_app_230770/presentation/screens/counter/counter_screen.dart';

class CounterScreen extends StatefulWidget {


  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}



class _CounterScreenState extends State<CounterScreen> {
  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$clickCounter',
          style: const TextStyle(fontSize: 160, fontWeight: FontWeight.w100)),
         Text('Click${clickCounter == 1 ? '':'s' }', style: const TextStyle( fontSize: 25))
        ],
      ),
     ),
    floatingActionButton: FloatingActionButton(
      onPressed:(){
        setState(() {
          clickCounter++;
        });
      },
      child: Icon( Icons.plus_one), 
    ),
    );
  }
} 