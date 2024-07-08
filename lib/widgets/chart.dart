
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expense_tracker/model/expense.dart';

class ExpenseChart extends StatefulWidget {
  final List<Expense> expenses;

  ExpenseChart({required this.expenses});

  @override
  _ExpenseChartState createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  String _selectedPeriod = 'Day';

  List<String> _periods = ['Day', '15 Days', 'Month'];

  Map<String, double> get groupedExpenses {
    Map<String, double> groupedData = {
      'Food': 0.0,
      'Work': 0.0,
      'Leisure': 0.0,
      'Travel': 0.0,
    };

    DateTime now = DateTime.now();
    DateTime startDate;

    switch (_selectedPeriod) {
      case 'Day':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case '15 Days':
        startDate = now.subtract(Duration(days: 15));
        break;
      case 'Month':
        startDate = DateTime(now.year, now.month - 1, now.day);
        break;
      default:
        startDate = DateTime(now.year, now.month, now.day);
    }

    for (var expense in widget.expenses) {
      if (expense.date.isAfter(startDate)) {
        switch (expense.category) {
          case Category.food:
            groupedData['Food'] = groupedData['Food']! + expense.amount;
            break;
          case Category.work:
            groupedData['Work'] = groupedData['Work']! + expense.amount;
            break;
          case Category.leisure:
            groupedData['Leisure'] = groupedData['Leisure']! + expense.amount;
            break;
          case Category.travel:
            groupedData['Travel'] = groupedData['Travel']! + expense.amount;
            break;
        }
      }
    }

    return groupedData;
  }

  double get maxY {
    return groupedExpenses.values.reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroups = [];
    int index = 0;

    groupedExpenses.forEach((category, amount) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: amount,
              color: Theme.of(context).colorScheme.secondary,
              width: 15,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
      );
      index++;
    });

    double interval = (maxY / 5).ceilToDouble(); // Adjust the denominator to change the number of intervals

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: DropdownButton<String>(
            value: _selectedPeriod,
            items: _periods.map((String period) {
              return DropdownMenuItem<String>(
                value: period,
                child: Text(period),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedPeriod = newValue!;
              });
            },
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 350, // Adjusted height to fit the screen better
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final title = groupedExpenses.keys.toList()[value.toInt()];
                          return SideTitleWidget(
                            axisSide: AxisSide.left,
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50, // Increased space for labels
                        interval: interval, // Show labels at calculated interval
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (value % interval == 0) {
                            return Text(
                              value.toStringAsFixed(0), // Show whole numbers
                              style:  TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          }
                          return Container(); // Return an empty container for values not meeting the condition
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    )
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: FlGridData(show: false),
                  barGroups: barGroups,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
