import 'package:flutter/material.dart';

class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({super.key});

  @override
  State<CounterFunctionsScreen> createState() =>
      _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {
  int clickCounter = 0;

  // Colores rosa pastel
  static const Color pastelPink = Color(0xFFFFD6E7);
  static const Color darkPink = Color(0xFFE88BAF);
  static const Color lightPink = Color(0xFFFFEEF4);

  // Color del contador según su valor
  Color get counterColor {
    if (clickCounter > 0) {
      return Colors.green.shade600;
    } else if (clickCounter < 0) {
      return Colors.red.shade500;
    }

    return darkPink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPink,

      appBar: AppBar(
        backgroundColor: pastelPink,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Suma y Resta',
          style: TextStyle(
            fontFamily: 'BarlowCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Color(0xFF6D4052),
          ),
        ),

        actions: [
          IconButton(
            tooltip: 'Reiniciar',
            icon: const Icon(
              Icons.restart_alt_rounded,
              color: Color(0xFF6D4052),
            ),
            onPressed: () {
              setState(() {
                clickCounter = 0;
              });
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontFamily: 'BarlowCondensed',
                fontSize: 160,
                fontWeight: FontWeight.bold,
                color: counterColor,
              ),
              child: Text('$clickCounter'),
            ),

            const SizedBox(height: 10),

            Text(
              'Click${clickCounter == 1 ? '' : 's'}',
              style: const TextStyle(
                fontFamily: 'BarlowCondensed',
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6D4052),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'minus',
            backgroundColor: pastelPink,
            foregroundColor: const Color(0xFFB84D72),
            elevation: 4,
            onPressed: () {
              setState(() {
                clickCounter--;
              });
            },
            child: const Icon(
              Icons.remove_rounded,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          FloatingActionButton(
            heroTag: 'plus',
            backgroundColor: darkPink,
            foregroundColor: Colors.white,
            elevation: 4,
            onPressed: () {
              setState(() {
                clickCounter++;
              });
            },
            child: const Icon(
              Icons.add_rounded,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
