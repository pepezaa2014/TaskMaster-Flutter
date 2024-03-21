// Author: drunrapakon sangraung 630510620

import 'package:dio/dio.dart';

import 'package:taskmaster/app/core/dio_client.dart';
import 'package:taskmaster/app/core/handle_exceptions.dart';
import 'package:taskmaster/app/core/router/pokemon_index_router.dart';
import 'package:taskmaster/app/data/models/pokemon_index_model.dart';
import 'package:taskmaster/app/data/models/pokemon_model.dart';

class PokemonAPI {
  final DioClient _dioClient;
  PokemonAPI(this._dioClient);

  Future<Pokemon> getPokemon() async {
    try {
      final Response response = await _dioClient.get(
        PokemonIndexRouter.getPokemonIndex,
      );

      return Pokemon.fromJson(response.data);
    } catch (e) {
      throw HandleExceptions.handleError(e);
    }
  }

  Future<PokemonIndex> getPokemonIndex({
    required int pokemonIndex,
  }) async {
    try {
      final Response response = await _dioClient.get(
        '${PokemonIndexRouter.getPokemonIndex}$pokemonIndex',
      );

      return PokemonIndex.fromJson(response.data);
    } catch (e) {
      throw HandleExceptions.handleError(e);
    }
  }
}
