import 'package:flutter/material.dart';

class CustomDropdownMenuItem<T> extends PopupMenuItem<T> {
  final String text;
  final VoidCallback callback;

  CustomDropdownMenuItem({
    super.key,
    required this.text,
    required T value,
    required this.callback,
  }) : super(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: callback,
              ),
            ],
          ),
        );
}
