import 'package:pokemon_sept/models/pokemon_evolution.dart';
import 'package:pokemon_sept/models/pokemon_images_evolution.dart';
import 'package:pokemon_sept/models/pokemon_list_model.dart';

class PokemonEvaluationModel {
  PokeEvolutionSpecies pokeEvolution;
  PokeImagesDetails pokeImagesEvolution;
  PokemonListModel pokemonListModel;

  PokemonEvaluationModel(
      {this.pokeEvolution, this.pokeImagesEvolution, this.pokemonListModel});
}
