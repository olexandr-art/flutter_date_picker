import 'package:flutter/material.dart';

class DigitBuilder extends StatefulWidget {
  final String selectedValue;
  final List<String> values;
  final double height;
  final Function(String value) onPageChanged;
  final TextStyle textStyle;
  final TextStyle? unselectedTextStyle;

  const DigitBuilder({
    super.key,
    required this.selectedValue,
    required this.values,
    this.height = 40.0,
    required this.onPageChanged,
    required this.textStyle,
    this.unselectedTextStyle,
  });

  @override
  State<DigitBuilder> createState() => _DigitBuilderState();
}

class _DigitBuilderState extends State<DigitBuilder> {
  late final PageController _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.values.indexOf(
      widget.selectedValue,
    );
    _controller = PageController(
      viewportFraction: 0.2,
      initialPage: selectedIndex,
      keepPage: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      scrollDirection: Axis.vertical,
      itemCount: widget.values.length,
      onPageChanged: (index) {
        selectedIndex = index;
        widget.onPageChanged(
          widget.values[index],
        );
        setState(() {});
      },
      itemBuilder: (context, index) {
        final value = widget.values[index];
        final isSelected = index == selectedIndex;
        final textStyle = isSelected
            ? widget.textStyle
            : (widget.unselectedTextStyle ?? widget.textStyle);

        return SizedBox(
          height: widget.height,
          child: Text(
            value,
            style: textStyle,
          ),
        );
      },
    );
  }
}
