import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets/digit_builder.dart';

enum EPickerStyle {
  monthDay,
}

class FlutterDatePicker extends StatefulWidget {
  final EdgeInsets? padding;
  final double height;
  final double width;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime currentDate;
  final EPickerStyle style;
  final TextStyle digitStyle;
  final BoxDecoration? centerDecoration;
  final Function(
    DateTime date,
  )?
  onDateChanged;
  final TextStyle? unselectedTextStyle;

  const FlutterDatePicker({
    super.key,
    this.padding = const EdgeInsets.symmetric(
      vertical: 25.0,
      horizontal: 20.0,
    ),
    this.height = 245.0,
    this.width = 341.0,
    required this.firstDate,
    required this.lastDate,
    required this.currentDate,
    this.onDateChanged,
    required this.digitStyle,
    this.style = EPickerStyle.monthDay,
    this.centerDecoration,
    this.unselectedTextStyle,
  });

  @override
  State<FlutterDatePicker> createState() => _FlutterDatePickerState();
}

class _FlutterDatePickerState extends State<FlutterDatePicker> {
  late DateTime _pickedDate;

  @override
  void initState() {
    _pickedDate = widget.currentDate;
    super.initState();
  }

  String _formatMonth(DateTime month) =>
      DateFormat(
        'MMMM',
      ).format(
        month,
      );

  String _formatYear(DateTime year) =>
      DateFormat(
        'yyyy',
      ).format(
        year,
      );

  List<String> calculateYearsValues() {
    final startYear = widget.firstDate.year;
    final endYear = widget.lastDate.year;

    return List.generate(
      endYear - startYear + 1,
      (i) {
        final date = DateTime(
          startYear + i,
        );
        return _formatYear(date);
      },
    );
  }

  List<String> calculateMonthValues() {
    return List.generate(
      12,
      (i) {
        final date = DateTime(
          2025,
          i + 1,
        );
        return _formatMonth(date);
      },
    );
  }

  void _monthChanged(String value) {
    final month =
        calculateMonthValues().indexOf(
          value,
        ) +
        1;
    _pickedDate = _pickedDate.copyWith(
      month: month,
    );
    setState(() {});
    widget.onDateChanged?.call(
      _pickedDate,
    );
  }

  void _yearChanged(String value) {
    _pickedDate = _pickedDate.copyWith(
      year: int.parse(
        value,
      ),
    );
    setState(() {});
    widget.onDateChanged?.call(
      _pickedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 40.0,
              decoration:
                  widget.centerDecoration ??
                  BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 150.0,
                child: DigitBuilder(
                  onPageChanged: _monthChanged,
                  selectedValue: _formatMonth(
                    widget.currentDate,
                  ),
                  values: calculateMonthValues(),
                  textStyle: widget.digitStyle,
                  unselectedTextStyle: widget.unselectedTextStyle,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 80.0,
                child: DigitBuilder(
                  onPageChanged: _yearChanged,
                  selectedValue: _formatYear(
                    widget.currentDate,
                  ),
                  values: calculateYearsValues(),
                  textStyle: widget.digitStyle,
                  unselectedTextStyle: widget.unselectedTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
