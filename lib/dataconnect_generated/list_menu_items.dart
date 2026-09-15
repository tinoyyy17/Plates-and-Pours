part of 'generated.dart';

class ListMenuItemsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMenuItemsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMenuItemsData> dataDeserializer = (dynamic json)  => ListMenuItemsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMenuItemsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListMenuItemsData, void> ref() {
    
    return _dataConnect.query("ListMenuItems", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMenuItemsMenuItems {
  final String id;
  final String name;
  ListMenuItemsMenuItems.fromJson(dynamic json):
  
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

    final ListMenuItemsMenuItems otherTyped = other as ListMenuItemsMenuItems;
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

  ListMenuItemsMenuItems({
    required this.id,
    required this.name,
  });
}

@immutable
class ListMenuItemsData {
  final List<ListMenuItemsMenuItems> menuItems;
  ListMenuItemsData.fromJson(dynamic json):
  
  menuItems = (json['menuItems'] as List<dynamic>)
        .map((e) => ListMenuItemsMenuItems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMenuItemsData otherTyped = other as ListMenuItemsData;
    return menuItems == otherTyped.menuItems;
    
  }
  @override
  int get hashCode => menuItems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['menuItems'] = menuItems.map((e) => e.toJson()).toList();
    return json;
  }

  ListMenuItemsData({
    required this.menuItems,
  });
}

