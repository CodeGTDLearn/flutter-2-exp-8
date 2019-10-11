import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double spendPercTotalWeek;

  ChartBar(this.label, this.spendAmount, this.spendPercTotalWeek);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
              child: Text('\$${this.spendAmount.toStringAsFixed(0)}')),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    border: Border.all(
                      color: Colors.cyan,
                      width: 1,
                    )),
              ),
              FractionallySizedBox(
                heightFactor: spendPercTotalWeek,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  width: 8,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(this.label),
      ],
    );
  }
}
