part of 'generated.dart';

class DeleteRestaurantVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteRestaurantVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteRestaurantData> dataDeserializer = (dynamic json)  => DeleteRestaurantData.fromJson(jsonDecode(json));
  Serializer<DeleteRestaurantVariables> varsSerializer = (DeleteRestaurantVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteRestaurantData, DeleteRestaurantVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteRestaurantData, DeleteRestaurantVariables> ref() {
    DeleteRestaurantVariables vars= DeleteRestaurantVariables(id: id,);
    return _dataConnect.mutation("DeleteRestaurant", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteRestaurantRestaurantDelete {
  final String id;
  DeleteRestaurantRestaurantDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteRestaurantRestaurantDelete otherTyped = other as DeleteRestaurantRestaurantDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteRestaurantRestaurantDelete({
    required this.id,
  });
}

@immutable
class DeleteRestaurantData {
  final DeleteRestaurantRestaurantDelete? restaurant_delete;
  DeleteRestaurantData.fromJson(dynamic json):
  
  restaurant_delete = json['restaurant_delete'] == null ? null : DeleteRestaurantRestaurantDelete.fromJson(json['restaurant_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteRestaurantData otherTyped = other as DeleteRestaurantData;
    return restaurant_delete == otherTyped.restaurant_delete;
    
  }
  @override
  int get hashCode => restaurant_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (restaurant_delete != null) {
      json['restaurant_delete'] = restaurant_delete!.toJson();
    }
    return json;
  }

  DeleteRestaurantData({
    this.restaurant_delete,
  });
}

@immutable
class DeleteRestaurantVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteRestaurantVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteRestaurantVariables otherTyped = other as DeleteRestaurantVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteRestaurantVariables({
    required this.id,
  });
}

