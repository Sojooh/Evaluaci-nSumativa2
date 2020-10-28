import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pokemon_sept/models/pokemon_about_detail_model.dart';
import 'package:pokemon_sept/models/pokemon_about_lacation_model.dart';
import 'package:pokemon_sept/models/pokemon_about_model.dart';
import 'package:pokemon_sept/models/pokemon_about_species_model.dart';
import 'package:pokemon_sept/models/pokemon_evaluation_model.dart';
import 'package:pokemon_sept/models/pokemon_evolution.dart';
import 'package:pokemon_sept/models/pokemon_images_evolution.dart';
import 'package:pokemon_sept/models/pokemon_list_model.dart';
import 'package:pokemon_sept/models/pokemon_moves_detail_model.dart';
import 'package:pokemon_sept/models/pokemon_stats_detail_model.dart';
import 'package:pokemon_sept/models/pokemon_stats_model.dart';
import 'package:pokemon_sept/models/pokemon_stats_species_model.dart';

class ApiProvider {
  Dio dio = Dio();
  Future<List<PokemonListModel>> obtenerListaPokemon() async {
    List<PokemonListModel> lista = [];
    try {
      Response resp =
          await dio.get('https://pokedexvuejs.herokuapp.com/pokedexdb');
      final pokemones = PokemonListResponse.fromJsonList(resp.data);
      lista = pokemones.items;
    } catch (e) {}
    return lista;
  }

  Future<PokemonAboutModel> obtenerInfoAboutPokemon(String nombrePoke) async {
    var pokeAbout = PokemonAboutModel();
    try {
      Response respA =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      final pokeDetail = PokeAboutDetail.fromJson(respA.data);
      Response respB = await dio
          .get('https://pokeapi.co/api/v2/pokemon/${pokeDetail.id}/encounters');
      final pokeListLocation =
          PokemonAboutLocationListModel.fromJsonList(respB.data);

      Response respC = await dio
          .get('https://pokeapi.co/api/v2/pokemon-species/${pokeDetail.id}');
      final pokeSoecies = PokeAboutSpecies.fromJson(respC.data);
      pokeAbout = PokemonAboutModel(
          pokeDetails: pokeDetail,
          pokeLocations: pokeListLocation.items,
          pokeSpecies: pokeSoecies);
    } catch (e) {}
    return pokeAbout;
  }

  Future<PokemonStatsModel> obtenerInfoStatsPokemon(String nombrePoke) async {
    var pokeStats = PokemonStatsModel();
    try {
      Response respA =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      final pokeStatsDetail = PokeStatsDetail.fromJson(respA.data);
      Response respB = await dio.get(
          'https://pokeapi.co/api/v2/pokemon-species/${pokeStatsDetail.id}');
      final pokeStatsSpecies = PokeStatsSpecies.fromJson(respB.data);

      pokeStats = PokemonStatsModel(
          pokeStatsDetail: pokeStatsDetail, pokeStatsSpecies: pokeStatsSpecies);
    } catch (e) {}

    return pokeStats;
  }

  Future<PokemonEvaluationModel> obtenerInfoEvaluationPokemon(
      String nombrePoke) async {
    var pokeEvaluation = PokemonEvaluationModel();
    try {
      Response respA =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      final pokemonListModel = PokemonListModel.fromJson(respA.data);
      Response respB = await dio.get(
          'https://pokeapi.co/api/v2/pokemon-species/${pokemonListModel.image}/');
      final pokeImagesEvolution = PokeImagesDetails.fromJson(respB.data);
      Response respC = await dio.get(
          'https://pokeapi.co/api/v2/evolution-chain/${pokeImagesEvolution.id}/');
      final pokeEvolution = PokeEvolutionSpecies.fromJson(respC.data);

      pokeEvaluation = PokemonEvaluationModel(
        pokemonListModel: pokemonListModel,
        pokeImagesEvolution: pokeImagesEvolution,
        pokeEvolution: pokeEvolution,
      );
    } catch (e) {}
  }

  Future<PokeMovesDetail> obtenerMovimientosPokemon(String nombrePoke) async {
    var pokeMovesModel = PokeMovesDetail();

    try {
      Response respA =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      pokeMovesModel = PokeMovesDetail.fromJson(respA.data);
    } catch (e) {}
    return pokeMovesModel;
  }
}
