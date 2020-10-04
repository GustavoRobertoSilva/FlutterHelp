//https://medium.com/flutter-community/a-deep-dive-into-datepicker-in-flutter-37e84f7d8d6c

import 'package:flutter/material.dart';
import 'package:flutter_app/br/com/input/date/custom_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerPage extends StatelessWidget {
  /// Which holds the selected date
  /// Defaults to today's date.
  DateTime selectedDate = DateTime.now();

  final String labelText = "";
  final DateTime selectedDate2 = null;
  final TimeOfDay selectedTime2 = TimeOfDay.now();
  final ValueChanged<DateTime> selectDate2 = null;
  final ValueChanged<TimeOfDay> selectTime2 = null;

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(1970, 8),
        lastDate: new DateTime(2101));
    if (picked != null && picked != selectedDate) selectDate2(picked);
  }

  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime2);
    if (picked != null && picked != selectedTime2) selectTime2(picked);
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      // setState(() {
      selectedDate = picked;
    print(selectedDate);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Datetime Picker'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  return showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                    helpText: 'Select booking date', // Can be used as title
                    cancelText: 'Not now',
                    confirmText: 'Book',
                  );
                },
                child: Text(
                  'Teste',
                  style: TextStyle(color: Colors.blue),
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  onPressed: () => _selectDate(context), // Refer step 3
                  child: Text(
                    'Select date',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.greenAccent,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    FlatButton(
                        onPressed: () {
                          _selectTime2(context);
                        },
                        child: Text(
                          'Teste',
                          style: TextStyle(color: Colors.blue),
                        )),

                    // new Expanded(
                    //   flex: 4,
                    //   child: new _InputDropdown(
                    //     labelText: labelText,
                    //     valueText: new DateFormat.yMMMd().format(selectedDate2),
                    //     valueStyle: valueStyle,
                    //     onPressed: () {
                    //       _selectDate(context);
                    //     },
                    //   ),
                    // ),
                    const SizedBox(width: 12.0),
                    // new Expanded(
                    //   flex: 3,
                    //   child: new _InputDropdown(
                    //     valueText: selectedTime2.format(context),
                    //     valueStyle: valueStyle,
                    //     onPressed: () {
                    //       _selectTime2(context);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}
