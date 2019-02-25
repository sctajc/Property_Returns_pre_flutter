import 'package:flutter/material.dart';

import 'package:simple_recipes/ui/widgets/google_sign_in_button.dart';
import 'package:simple_recipes/state_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Private methods within build method help us to
    // organize our code and recognize structure of widget
    // that we're building:
    BoxDecoration _buildBackground() {
      return BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/recipe.jpg"),
        fit: BoxFit.cover,
      ));
    }

    Text _buildText() {
      return Text(
        'Recipes',
        style: Theme.of(context).textTheme.headline,
        textAlign: TextAlign.center,
      );
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        decoration: _buildBackground(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildText(),
              // space between "Recipes" and the button
              SizedBox(
                height: 50,
              ),
              GoogleSignInButton(
                  onPressed: () => StateWidget.of(context).signInWithGoogle())
            ],
          ),
        ),
      ),
    );
  }
}
