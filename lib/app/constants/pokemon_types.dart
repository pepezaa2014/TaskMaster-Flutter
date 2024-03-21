// Author: drunrapakon sangraung 630510620

import 'package:taskmaster/resources/resources.dart';

enum PokemonTypes {
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
  unknown,
  shadow,
}

extension PokemonTypesExtension on PokemonTypes {
  String get pokemonTypeImage {
    switch (this) {
      case PokemonTypes.normal:
        return ImageName.pokemonNormalType;
      case PokemonTypes.fighting:
        return ImageName.pokemonFightingType;
      case PokemonTypes.flying:
        return ImageName.pokemonFlyingType;
      case PokemonTypes.poison:
        return ImageName.pokemonPoisonType;
      case PokemonTypes.ground:
        return ImageName.pokemonGroundType;
      case PokemonTypes.rock:
        return ImageName.pokemonRockType;
      case PokemonTypes.bug:
        return ImageName.pokemonBugType;
      case PokemonTypes.ghost:
        return ImageName.pokemonGhostType;
      case PokemonTypes.steel:
        return ImageName.pokemonSteelType;
      case PokemonTypes.fire:
        return ImageName.pokemonFireType;
      case PokemonTypes.water:
        return ImageName.pokemonWaterType;
      case PokemonTypes.grass:
        return ImageName.pokemonGrassType;
      case PokemonTypes.electric:
        return ImageName.pokemonElectricType;
      case PokemonTypes.psychic:
        return ImageName.pokemonPsychicType;
      case PokemonTypes.ice:
        return ImageName.pokemonIceType;
      case PokemonTypes.dragon:
        return ImageName.pokemonDragonType;
      case PokemonTypes.dark:
        return ImageName.pokemonDarkType;
      case PokemonTypes.fairy:
        return ImageName.pokemonFairyType;
      case PokemonTypes.unknown:
        return ImageName.pokemonUnknownType;
      case PokemonTypes.shadow:
        return ImageName.pokemonShadowType;
    }
  }
}
