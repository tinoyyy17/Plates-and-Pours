part of 'generated.dart';

class GetMenuItemVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetMenuItemVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetMenuItemData> dataDeserializer = (dynamic json)  => GetMenuItemData.fromJson(jsonDecode(json));
  Serializer<GetMenuItemVariables> varsSerializer = (GetMenuItemVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetMenuItemData, GetMenuItemVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetMenuItemData, GetMenuItemVariables> ref() {
    GetMenuItemVariables vars= GetMenuItemVariables(id: id,);
    return _dataConnect.query("GetMenuItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetMenuItemMenuItem {
  final String name;
  final double price;
  final GetMenuItemMenuItemCategory category;
  GetMenuItemMenuItem.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  price = nativeFromJson<double>(json['price']),
  category = GetMenuItemMenuItemCategory.fromJson(json['category']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMenuItemMenuItem otherTyped = other as GetMenuItemMenuItem;
    return name == otherTyped.name && 
    price == otherTyped.price && 
    category == otherTyped.category;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, price.hashCode, category.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['price'] = nativeToJson<double>(price);
    json['category'] = category.toJson();
    return json;
  }

  GetMenuItemMenuItem({
    required this.name,
    required this.price,
    required this.category,
  });
}

@immutable
class GetMenuItemMenuItemCategory {
  final String name;
  GetMenuItemMenuItemCategory.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMenuItemMenuItemCategory otherTyped = other as GetMenuItemMenuItemCategory;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetMenuItemMenuItemCategory({
    required this.name,
  });
}

@immutable
class GetMenuItemData {
  final GetMenuItemMenuItem? menuItem;
  GetMenuItemData.fromJson(dynamic json):
  
  menuItem = json['menuItem'] == null ? null : GetMenuItemMenuItem.fromJson(json['menuItem']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMenuItemData otherTyped = other as GetMenuItemData;
    return menuItem == otherTyped.menuItem;
    
  }
  @override
  int get hashCode => menuItem.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (menuItem != null) {
      json['menuItem'] = menuItem!.toJson();
    }
    return json;
  }

  GetMenuItemData({
    this.menuItem,
  });
}

@immutable
class GetMenuItemVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetMenuItemVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMenuItemVariables otherTyped = other as GetMenuItemVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetMenuItemVariables({
    required this.id,
  });
}

