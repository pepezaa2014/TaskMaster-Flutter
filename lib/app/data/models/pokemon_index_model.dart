// Author: drunrapakon sangraung 630510620

class PokemonIndex {
  String? formName;
  int? formOrder;
  int? id;
  bool? isBattleOnly;
  bool? isDefault;
  bool? isMega;
  String? name;
  int? order;
  PokemonDetail? pokemon;
  Sprites? sprites;
  List<Types>? types;
  PokemonDetail? versionGroup;

  PokemonIndex(
      {this.formName,
      this.formOrder,
      this.id,
      this.isBattleOnly,
      this.isDefault,
      this.isMega,
      this.name,
      this.order,
      this.pokemon,
      this.sprites,
      this.types,
      this.versionGroup});

  PokemonIndex.fromJson(Map<String, dynamic> json) {
    formName = json['form_name'];
    formOrder = json['form_order'];
    id = json['id'];
    isBattleOnly = json['is_battle_only'];
    isDefault = json['is_default'];
    isMega = json['is_mega'];
    name = json['name'];
    order = json['order'];
    pokemon = json['pokemon'] != null
        ? PokemonDetail?.fromJson(json['pokemon'])
        : null;
    sprites =
        json['sprites'] != null ? Sprites?.fromJson(json['sprites']) : null;
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types?.add(Types.fromJson(v));
      });
    }
    versionGroup = json['version_group'] != null
        ? PokemonDetail?.fromJson(json['version_group'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['form_name'] = formName;
    data['form_order'] = formOrder;
    data['id'] = id;
    data['is_battle_only'] = isBattleOnly;
    data['is_default'] = isDefault;
    data['is_mega'] = isMega;
    data['name'] = name;
    data['order'] = order;
    if (pokemon != null) {
      data['pokemon'] = pokemon?.toJson();
    }
    if (sprites != null) {
      data['sprites'] = sprites?.toJson();
    }
    if (types != null) {
      data['types'] = types?.map((v) => v.toJson()).toList();
    }
    if (versionGroup != null) {
      data['version_group'] = versionGroup?.toJson();
    }
    return data;
  }
}

class PokemonDetail {
  String? name;
  String? url;

  PokemonDetail({this.name, this.url});

  PokemonDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class Sprites {
  String? backDefault;
  dynamic backFemale;
  String? backShiny;
  dynamic backShinyFemale;
  String? frontDefault;
  dynamic frontFemale;
  String? frontShiny;
  dynamic frontShinyFemale;

  Sprites(
      {this.backDefault,
      this.backFemale,
      this.backShiny,
      this.backShinyFemale,
      this.frontDefault,
      this.frontFemale,
      this.frontShiny,
      this.frontShinyFemale});

  Sprites.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backFemale = json['back_female'];
    backShiny = json['back_shiny'];
    backShinyFemale = json['back_shiny_female'];
    frontDefault = json['front_default'];
    frontFemale = json['front_female'];
    frontShiny = json['front_shiny'];
    frontShinyFemale = json['front_shiny_female'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['back_default'] = backDefault;
    data['back_female'] = backFemale;
    data['back_shiny'] = backShiny;
    data['back_shiny_female'] = backShinyFemale;
    data['front_default'] = frontDefault;
    data['front_female'] = frontFemale;
    data['front_shiny'] = frontShiny;
    data['front_shiny_female'] = frontShinyFemale;
    return data;
  }
}

class Types {
  int? slot;
  PokemonDetail? type;

  Types({this.slot, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? PokemonDetail?.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['slot'] = slot;
    if (type != null) {
      data['type'] = type?.toJson();
    }
    return data;
  }
}
