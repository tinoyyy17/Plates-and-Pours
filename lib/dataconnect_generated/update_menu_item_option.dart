part of 'generated.dart';

class UpdateMenuItemOptionVariablesBuilder {
  String id;
  Optional<double> _priceAdjustment = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateMenuItemOptionVariablesBuilder priceAdjustment(double? t) {
   _priceAdjustment.value = t;
   return this;
  }

  UpdateMenuItemOptionVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateMenuItemOptionData> dataDeserializer = (dynamic json)  => UpdateMenuItemOptionData.fromJson(jsonDecode(json));
  Serializer<UpdateMenuItemOptionVariables> varsSerializer = (UpdateMenuItemOptionVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMenuItemOptionData, UpdateMenuItemOptionVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMenuItemOptionData, UpdateMenuItemOptionVariables> ref() {
    UpdateMenuItemOptionVariables vars= UpdateMenuItemOptionVariables(id: id,priceAdjustment: _priceAdjustment,);
    return _dataConnect.mutation("UpdateMenuItemOption", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMenuItemOptionMenuItemOptionUpdate {
  final String id;
  UpdateMenuItemOptionMenuItemOptionUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMenuItemOptionMenuItemOptionUpdate otherTyped = other as UpdateMenuItemOptionMenuItemOptionUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMenuItemOptionMenuItemOptionUpdate({
    required this.id,
  });
}

@immutable
class UpdateMenuItemOptionData {
  final UpdateMenuItemOptionMenuItemOptionUpdate? menuItemOption_update;
  UpdateMenuItemOptionData.fromJson(dynamic json):
  
  menuItemOption_update = json['menuItemOption_update'] == null ? null : UpdateMenuItemOptionMenuItemOptionUpdate.fromJson(json['menuItemOption_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMenuItemOptionData otherTyped = other as UpdateMenuItemOptionData;
    return menuItemOption_update == otherTyped.menuItemOption_update;
    
  }
  @override
  int get hashCode => menuItemOption_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (menuItemOption_update != null) {
      json['menuItemOption_update'] = menuItemOption_update!.toJson();
    }
    return json;
  }

  UpdateMenuItemOptionData({
    this.menuItemOption_update,
  });
}

@immutable
class UpdateMenuItemOptionVariables {
  final String id;
  late final Optional<double>priceAdjustment;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMenuItemOptionVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    priceAdjustment = Optional.optional(nativeFromJson, nativeToJson);
    priceAdjustment.value = json['priceAdjustment'] == null ? null : nativeFromJson<double>(json['priceAdjustment']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMenuItemOptionVariables otherTyped = other as UpdateMenuItemOptionVariables;
    return id == otherTyped.id && 
    priceAdjustment == otherTyped.priceAdjustment;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, priceAdjustment.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(priceAdjustment.state == OptionalState.set) {
      json['priceAdjustment'] = priceAdjustment.toJson();
    }
    return json;
  }

  UpdateMenuItemOptionVariables({
    required this.id,
    required this.priceAdjustment,
  });
}

