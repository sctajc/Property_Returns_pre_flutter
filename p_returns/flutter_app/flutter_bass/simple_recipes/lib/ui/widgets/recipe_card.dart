import 'package:flutter/material.dart';

import 'package:simple_recipes/model/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool inFavourites;
  final Function onFavouriteButtonPressed;

  RecipeCard(
      {@required this.recipe,
      @required this.inFavourites,
      @required this.onFavouriteButtonPressed});

  @override
  Widget build(BuildContext context) {
    RawMaterialButton _buildFavouriteButton() {
      return RawMaterialButton(
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        onPressed: () => onFavouriteButtonPressed,
        child: Icon(
          inFavourites == true ? Icons.favorite : Icons.favorite_border,
          color: Theme.of(context).iconTheme.color,
        ),
        elevation: 2,
        fillColor: Theme.of(context).buttonColor,
        shape: CircleBorder(),
      );
    }

    Padding _buildTitleSection() {
      return Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              recipe.name,
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  recipe.getDurationString,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            )
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => print("Tapped"),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      recipe.imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: _buildFavouriteButton(),
                    top: 2,
                    right: 2,
                  )
                ],
              ),
              _buildTitleSection(),
            ],
          ),
        ),
      ),
    );
  }
}
