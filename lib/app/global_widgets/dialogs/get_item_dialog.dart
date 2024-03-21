// Author: drunrapakon sangraung 630510620

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/constants/pokemon_types.dart';
import 'package:taskmaster/app/data/models/pokemon_index_model.dart';

class GetItemDialog extends StatelessWidget {
  const GetItemDialog({
    super.key,
    required this.pokemonIndex,
  });

  final PokemonIndex pokemonIndex;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Image.network(
        pokemonIndex.sprites?.frontDefault ?? '',
        height: 100,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${pokemonIndex.name?.substring(0, 1).toUpperCase()}${pokemonIndex.name?.substring(1)} #${pokemonIndex.id}',
            style: GoogleFonts.kanit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 70,
            height: 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pokemonIndex.types?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Image.asset(
                    height: 24,
                    PokemonTypes.values
                            .firstWhereOrNull(
                              (e) =>
                                  e.name ==
                                  (pokemonIndex.types?[index].type?.name ?? ''),
                            )
                            ?.pokemonTypeImage ??
                        '',
                  ),
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.taskmasterSecondaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: CupertinoDialogAction(
            child: Text(
              'Confirm',
              style: GoogleFonts.kanit(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
