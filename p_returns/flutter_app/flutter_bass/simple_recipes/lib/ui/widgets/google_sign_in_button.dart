import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  GoogleSignInButton({this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    Image _buildLogo() {
      return Image.asset(
        "assets/g-logo.png",
        height: 25,
        width: 25,
      );
    }

    Opacity _buildText() {
      return Opacity(
        opacity: 0.54,
        child: Text(
          "Sign in with Google",
          style: TextStyle(
            fontFamily: 'Roboto-Medium',
            color: Colors.black,
          ),
        ),
      );
    }

    return MaterialButton(
      height: 40,
      onPressed: this.onPressed,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildLogo(),
          SizedBox(
            width: 24,
          ),
          _buildText(),
        ],
      ),
    );
  }
}
