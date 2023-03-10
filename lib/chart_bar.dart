import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;

  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context1, constraints) {
      return Column(
        children: [
          FittedBox(
            child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
          ),
           SizedBox(
            height: constraints.maxHeight*0.08,
          ),
          Container(
             height: constraints.maxHeight*0.5,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            ),
          ),
           SizedBox(
            height: constraints.maxHeight*0.1,
          ),
          Text(label)
        ],
      );
    });
  }
}
