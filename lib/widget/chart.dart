import 'package:exp8/entity/transaction.dart';
import 'package:exp8/widget/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _last7DaysTx;

  Chart(this._last7DaysTx);

  List<Map<String, Object>> get totalPerDayLast7Days {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalWeekDay = 0.0;

      for (var tx in _last7DaysTx) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalWeekDay += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalWeekDay
      };
    }).reversed.toList();
  }

  double get totalLast7Days {
    return totalPerDayLast7Days.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build - Chart');
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: totalPerDayLast7Days.map((data) {
          return ChartBar(
              data['day'],
              data['amount'],
              totalLast7Days == 0
                  ? 0.0
                  : (data['amount'] as double) / totalLast7Days);
        }).toList(),
      ),
    );
  }
}
