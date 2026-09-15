part of 'generated.dart';

class ListRestaurantsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListRestaurantsVariablesBuilder(this._dataConnect, );
  Deserializer<ListRestaurantsData> dataDeserializer = (dynamic json)  => ListRestaurantsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListRestaurantsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListRestaurantsData, void> ref() {
    
    return _dataConnect.query("ListRestaurants", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListRestaurantsRestaurants {
  final String id;
  final String name;
  ListRestaurantsRestaurants.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRestaurantsRestaurants otherTyped = other as ListRestaurantsRestaurants;
    return id == otherTyped.id && 
    name == otherTyped.name;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  ListRestaurantsRestaurants({
    required this.id,
    required this.name,
  });
}

@immutable
class ListRestaurantsData {
  final List<ListRestaurantsRestaurants> restaurants;
  ListRestaurantsData.fromJson(dynamic json):
  
  restaurants = (json['restaurants'] as List<dynamic>)
        .map((e) => ListRestaurantsRestaurants.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListRestaurantsData otherTyped = other as ListRestaurantsData;
    return restaurants == otherTyped.restaurants;
    
  }
  @override
  int get hashCode => restaurants.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['restaurants'] = restaurants.map((e) => e.toJson()).toList();
    return json;
  }

  ListRestaurantsData({
    required this.restaurants,
  });
}

