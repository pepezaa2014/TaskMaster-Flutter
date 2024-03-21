// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/data/models/pokemon_index_model.dart';

class Inventory extends StatelessWidget {
  const Inventory({
    super.key,
    required this.pokemon,
    required this.isContain,
    required this.function,
  });

  final PokemonIndex pokemon;
  final bool isContain;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isContain ? 1 : 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: AppColors.taskmasterSecondaryGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => function(),
        child: Image.network(
          pokemon.sprites?.frontDefault ?? '',
        ),
      ),
    );
  }
}
