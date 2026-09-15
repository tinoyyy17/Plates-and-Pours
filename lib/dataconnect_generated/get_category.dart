part of 'generated.dart';

class GetCategoryVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetCategoryVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetCategoryData> dataDeserializer = (dynamic json)  => GetCategoryData.fromJson(jsonDecode(json));
  Serializer<GetCategoryVariables> varsSerializer = (GetCategoryVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetCategoryData, GetCategoryVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetCategoryData, GetCategoryVariables> ref() {
    GetCategoryVariables vars= GetCategoryVariables(id: id,);
    return _dataConnect.query("GetCategory", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetCategoryCategory {
  final String name;
  final GetCategoryCategoryRestaurant restaurant;
  GetCategoryCategory.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  restaurant = GetCategoryCategoryRestaurant.fromJson(json['restaurant']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCategoryCategory otherTyped = other as GetCategoryCategory;
    return name == otherTyped.name && 
    restaurant == otherTyped.restaurant;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, restaurant.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['restaurant'] = restaurant.toJson();
    return json;
  }

  GetCategoryCategory({
    required this.name,
    required this.restaurant,
  });
}

@immutable
class GetCategoryCategoryRestaurant {
  final String name;
  GetCategoryCategoryRestaurant.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCategoryCategoryRestaurant otherTyped = other as GetCategoryCategoryRestaurant;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetCategoryCategoryRestaurant({
    required this.name,
  });
}

@immutable
class GetCategoryData {
  final GetCategoryCategory? category;
  GetCategoryData.fromJson(dynamic json):
  
  category = json['category'] == null ? null : GetCategoryCategory.fromJson(json['category']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCategoryData otherTyped = other as GetCategoryData;
    return category == otherTyped.category;
    
  }
  @override
  int get hashCode => category.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (category != null) {
      json['category'] = category!.toJson();
    }
    return json;
  }

  GetCategoryData({
    this.category,
  });
}

@immutable
class GetCategoryVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetCategoryVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCategoryVariables otherTyped = other as GetCategoryVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetCategoryVariables({
    required this.id,
  });
}

