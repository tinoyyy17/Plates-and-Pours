part of 'generated.dart';

class CreateRestaurantVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  CreateRestaurantVariablesBuilder(this._dataConnect, );
  Deserializer<CreateRestaurantData> dataDeserializer = (dynamic json)  => CreateRestaurantData.fromJson(jsonDecode(json));
  
  Future<OperationResult<CreateRestaurantData, void>> execute() {
    return ref().execute();
  }

  MutationRef<CreateRestaurantData, void> ref() {
    
    return _dataConnect.mutation("CreateRestaurant", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class CreateRestaurantRestaurantInsert {
  final String id;
  CreateRestaurantRestaurantInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateRestaurantRestaurantInsert otherTyped = other as CreateRestaurantRestaurantInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateRestaurantRestaurantInsert({
    required this.id,
  });
}

@immutable
class CreateRestaurantData {
  final CreateRestaurantRestaurantInsert restaurant_insert;
  CreateRestaurantData.fromJson(dynamic json):
  
  restaurant_insert = CreateRestaurantRestaurantInsert.fromJson(json['restaurant_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateRestaurantData otherTyped = other as CreateRestaurantData;
    return restaurant_insert == otherTyped.restaurant_insert;
    
  }
  @override
  int get hashCode => restaurant_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['restaurant_insert'] = restaurant_insert.toJson();
    return json;
  }

  CreateRestaurantData({
    required this.restaurant_insert,
  });
}

