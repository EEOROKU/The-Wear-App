import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:closet_app/utils/constants.dart';

class PasswordTextField extends StatefulWidget {
  final String hintTxt;
  final TextEditingController controller;

  const PasswordTextField({
    Key? key,
    required this.hintTxt,
    required this.controller,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 270.0,
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              obscureText: _obscureText,
              keyboardType: TextInputType.visiblePassword,
              controller: widget.controller,
              onChanged: (value) {
                widget.controller.text = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintTxt,
                hintStyle: hintStyle,
              ),
              style: headline2,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: SvgPicture.asset(
              _obscureText ? 'assets/icon/hide.svg' : 'assets/icon/visibility.svg',
              height: 20.0,
              color: grayText,
            ),
          )
        ],
      ),
    );
  }
}
