import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double spendPercTotalWeek;
  final List<double> propsLayout = [0.15, 0.05, 0.6, 0.05, 0.15];

  ChartBar(this.label, this.spendAmount, this.spendPercTotalWeek);

  @override
  Widget build(BuildContext context) {
    print('Build - ChartBar');
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          //-----------------
          Container(
            height: constraints.maxHeight * propsLayout[0],
            child: FittedBox(
                child: Text('\$${this.spendAmount.toStringAsFixed(0)}')),
          ),

          //-----------------
          SizedBox(
            height: constraints.maxHeight * propsLayout[1],
          ),

          //-----------------
          Container(
            height: constraints.maxHeight * propsLayout[2],
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

          //-----------------
          SizedBox(
            height: constraints.maxHeight * propsLayout[3],
          ),

          //-----------------
          Container(
            height: constraints.maxHeight * propsLayout[4],
            child: FittedBox(
              child: Text(this.label),
            ),
          ),
        ],
      );
    });
  }
}
