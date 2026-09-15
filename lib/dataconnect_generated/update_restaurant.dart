part of 'generated.dart';

class UpdateRestaurantVariablesBuilder {
  String id;
  Optional<String> _name = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateRestaurantVariablesBuilder name(String? t) {
   _name.value = t;
   return this;
  }

  UpdateRestaurantVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateRestaurantData> dataDeserializer = (dynamic json)  => UpdateRestaurantData.fromJson(jsonDecode(json));
  Serializer<UpdateRestaurantVariables> varsSerializer = (UpdateRestaurantVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateRestaurantData, UpdateRestaurantVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateRestaurantData, UpdateRestaurantVariables> ref() {
    UpdateRestaurantVariables vars= UpdateRestaurantVariables(id: id,name: _name,);
    return _dataConnect.mutation("UpdateRestaurant", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateRestaurantRestaurantUpdate {
  final String id;
  UpdateRestaurantRestaurantUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateRestaurantRestaurantUpdate otherTyped = other as UpdateRestaurantRestaurantUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateRestaurantRestaurantUpdate({
    required this.id,
  });
}

@immutable
class UpdateRestaurantData {
  final UpdateRestaurantRestaurantUpdate? restaurant_update;
  UpdateRestaurantData.fromJson(dynamic json):
  
  restaurant_update = json['restaurant_update'] == null ? null : UpdateRestaurantRestaurantUpdate.fromJson(json['restaurant_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateRestaurantData otherTyped = other as UpdateRestaurantData;
    return restaurant_update == otherTyped.restaurant_update;
    
  }
  @override
  int get hashCode => restaurant_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (restaurant_update != null) {
      json['restaurant_update'] = restaurant_update!.toJson();
    }
    return json;
  }

  UpdateRestaurantData({
    this.restaurant_update,
  });
}

@immutable
class UpdateRestaurantVariables {
  final String id;
  late final Optional<String>name;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateRestaurantVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    name = Optional.optional(nativeFromJson, nativeToJson);
    name.value = json['name'] == null ? null : nativeFromJson<String>(json['name']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateRestaurantVariables otherTyped = other as UpdateRestaurantVariables;
    return id == otherTyped.id && 
    name == otherTyped.name;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(name.state == OptionalState.set) {
      json['name'] = name.toJson();
    }
    return json;
  }

  UpdateRestaurantVariables({
    required this.id,
    required this.name,
  });
}

