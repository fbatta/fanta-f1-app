import 'package:flutter/material.dart';

class SpinnerCentered extends StatelessWidget {
  final String? text;

  const SpinnerCentered({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60.0,
            width: 60.0,
            child: CircularProgressIndicator(strokeWidth: 7.0),
          ),
          text != null
              ? Column(
                  children: [
                    SizedBox(height: 24.0),
                    Text(text!, textAlign: TextAlign.center),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
