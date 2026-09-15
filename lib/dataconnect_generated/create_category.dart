part of 'generated.dart';

class CreateCategoryVariablesBuilder {
  String name;
  int sortOrder;
  String restaurantId;

  final FirebaseDataConnect _dataConnect;
  CreateCategoryVariablesBuilder(this._dataConnect, {required  this.name,required  this.sortOrder,required  this.restaurantId,});
  Deserializer<CreateCategoryData> dataDeserializer = (dynamic json)  => CreateCategoryData.fromJson(jsonDecode(json));
  Serializer<CreateCategoryVariables> varsSerializer = (CreateCategoryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateCategoryData, CreateCategoryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateCategoryData, CreateCategoryVariables> ref() {
    CreateCategoryVariables vars= CreateCategoryVariables(name: name,sortOrder: sortOrder,restaurantId: restaurantId,);
    return _dataConnect.mutation("CreateCategory", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateCategoryCategoryInsert {
  final String id;
  CreateCategoryCategoryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCategoryCategoryInsert otherTyped = other as CreateCategoryCategoryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateCategoryCategoryInsert({
    required this.id,
  });
}

@immutable
class CreateCategoryData {
  final CreateCategoryCategoryInsert category_insert;
  CreateCategoryData.fromJson(dynamic json):
  
  category_insert = CreateCategoryCategoryInsert.fromJson(json['category_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCategoryData otherTyped = other as CreateCategoryData;
    return category_insert == otherTyped.category_insert;
    
  }
  @override
  int get hashCode => category_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insert'] = category_insert.toJson();
    return json;
  }

  CreateCategoryData({
    required this.category_insert,
  });
}

@immutable
class CreateCategoryVariables {
  final String name;
  final int sortOrder;
  final String restaurantId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateCategoryVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  sortOrder = nativeFromJson<int>(json['sortOrder']),
  restaurantId = nativeFromJson<String>(json['restaurantId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCategoryVariables otherTyped = other as CreateCategoryVariables;
    return name == otherTyped.name && 
    sortOrder == otherTyped.sortOrder && 
    restaurantId == otherTyped.restaurantId;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, sortOrder.hashCode, restaurantId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['restaurantId'] = nativeToJson<String>(restaurantId);
    return json;
  }

  CreateCategoryVariables({
    required this.name,
    required this.sortOrder,
    required this.restaurantId,
  });
}

