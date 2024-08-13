import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ใช้สำหรับฟอร์แมตตัวเลข

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('แอปรวมราคาสินค้า'),
        ),
        body: const ProductCalculator(),
      ),
    );
  }
}

class ProductCalculator extends StatefulWidget {
  const ProductCalculator({super.key});

  @override
  _ProductCalculatorState createState() => _ProductCalculatorState();
}

class _ProductCalculatorState extends State<ProductCalculator> {
  int ipadCount = 0;
  int ipadMiniCount = 0;
  int ipadAirCount = 0;
  int ipadProCount = 0;

  static const int ipadPrice = 19000;
  static const int ipadMiniPrice = 23000;
  static const int ipadAirPrice = 29000;
  static const int ipadProPrice = 39000;

  int get totalPrice {
    return (ipadCount * ipadPrice) +
        (ipadMiniCount * ipadMiniPrice) +
        (ipadAirCount * ipadAirPrice) +
        (ipadProCount * ipadProPrice);
  }

  String get formattedTotalPrice {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(totalPrice)} บาท';
  }

  void _clearCounts() {
    setState(() {
      ipadCount = 0;
      ipadMiniCount = 0;
      ipadAirCount = 0;
      ipadProCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildProductRow('iPad', ipadCount, ipadPrice, (newCount) {
            setState(() {
              ipadCount = newCount;
            });
          }),
          _buildProductRow('iPad mini', ipadMiniCount, ipadMiniPrice, (newCount) {
            setState(() {
              ipadMiniCount = newCount;
            });
          }),
          _buildProductRow('iPad Air', ipadAirCount, ipadAirPrice, (newCount) {
            setState(() {
              ipadAirCount = newCount;
            });
          }),
          _buildProductRow('iPad Pro', ipadProCount, ipadProPrice, (newCount) {
            setState(() {
              ipadProCount = newCount;
            });
          }),
          const SizedBox(height: 20),
          Text(
            'ราคารวม: $formattedTotalPrice',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _clearCounts,
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(String name, int count, int price, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '$name: ${(price * count).toStringAsFixed(0)} บาท',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                if (count > 0) {
                  onChanged(count - 1);
                }
              },
              icon: const Icon(Icons.remove),
            ),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            IconButton(
              onPressed: () {
                onChanged(count + 1);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
