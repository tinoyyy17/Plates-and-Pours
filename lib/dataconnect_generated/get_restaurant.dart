part of 'generated.dart';

class GetRestaurantVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetRestaurantVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetRestaurantData> dataDeserializer = (dynamic json)  => GetRestaurantData.fromJson(jsonDecode(json));
  Serializer<GetRestaurantVariables> varsSerializer = (GetRestaurantVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetRestaurantData, GetRestaurantVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetRestaurantData, GetRestaurantVariables> ref() {
    GetRestaurantVariables vars= GetRestaurantVariables(id: id,);
    return _dataConnect.query("GetRestaurant", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetRestaurantRestaurant {
  final String name;
  final String address;
  GetRestaurantRestaurant.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  address = nativeFromJson<String>(json['address']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRestaurantRestaurant otherTyped = other as GetRestaurantRestaurant;
    return name == otherTyped.name && 
    address == otherTyped.address;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, address.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['address'] = nativeToJson<String>(address);
    return json;
  }

  GetRestaurantRestaurant({
    required this.name,
    required this.address,
  });
}

@immutable
class GetRestaurantData {
  final GetRestaurantRestaurant? restaurant;
  GetRestaurantData.fromJson(dynamic json):
  
  restaurant = json['restaurant'] == null ? null : GetRestaurantRestaurant.fromJson(json['restaurant']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRestaurantData otherTyped = other as GetRestaurantData;
    return restaurant == otherTyped.restaurant;
    
  }
  @override
  int get hashCode => restaurant.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (restaurant != null) {
      json['restaurant'] = restaurant!.toJson();
    }
    return json;
  }

  GetRestaurantData({
    this.restaurant,
  });
}

@immutable
class GetRestaurantVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetRestaurantVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetRestaurantVariables otherTyped = other as GetRestaurantVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetRestaurantVariables({
    required this.id,
  });
}

