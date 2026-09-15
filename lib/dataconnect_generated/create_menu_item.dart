part of 'generated.dart';

class CreateMenuItemVariablesBuilder {
  String name;
  double price;
  bool isAvailable;
  String categoryId;

  final FirebaseDataConnect _dataConnect;
  CreateMenuItemVariablesBuilder(this._dataConnect, {required  this.name,required  this.price,required  this.isAvailable,required  this.categoryId,});
  Deserializer<CreateMenuItemData> dataDeserializer = (dynamic json)  => CreateMenuItemData.fromJson(jsonDecode(json));
  Serializer<CreateMenuItemVariables> varsSerializer = (CreateMenuItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateMenuItemData, CreateMenuItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateMenuItemData, CreateMenuItemVariables> ref() {
    CreateMenuItemVariables vars= CreateMenuItemVariables(name: name,price: price,isAvailable: isAvailable,categoryId: categoryId,);
    return _dataConnect.mutation("CreateMenuItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateMenuItemMenuItemInsert {
  final String id;
  CreateMenuItemMenuItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMenuItemMenuItemInsert otherTyped = other as CreateMenuItemMenuItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateMenuItemMenuItemInsert({
    required this.id,
  });
}

@immutable
class CreateMenuItemData {
  final CreateMenuItemMenuItemInsert menuItem_insert;
  CreateMenuItemData.fromJson(dynamic json):
  
  menuItem_insert = CreateMenuItemMenuItemInsert.fromJson(json['menuItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMenuItemData otherTyped = other as CreateMenuItemData;
    return menuItem_insert == otherTyped.menuItem_insert;
    
  }
  @override
  int get hashCode => menuItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['menuItem_insert'] = menuItem_insert.toJson();
    return json;
  }

  CreateMenuItemData({
    required this.menuItem_insert,
  });
}

@immutable
class CreateMenuItemVariables {
  final String name;
  final double price;
  final bool isAvailable;
  final String categoryId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateMenuItemVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  price = nativeFromJson<double>(json['price']),
  isAvailable = nativeFromJson<bool>(json['isAvailable']),
  categoryId = nativeFromJson<String>(json['categoryId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMenuItemVariables otherTyped = other as CreateMenuItemVariables;
    return name == otherTyped.name && 
    price == otherTyped.price && 
    isAvailable == otherTyped.isAvailable && 
    categoryId == otherTyped.categoryId;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, price.hashCode, isAvailable.hashCode, categoryId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['price'] = nativeToJson<double>(price);
    json['isAvailable'] = nativeToJson<bool>(isAvailable);
    json['categoryId'] = nativeToJson<String>(categoryId);
    return json;
  }

  CreateMenuItemVariables({
    required this.name,
    required this.price,
    required this.isAvailable,
    required this.categoryId,
  });
}

