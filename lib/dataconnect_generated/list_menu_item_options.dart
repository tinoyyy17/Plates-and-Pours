part of 'generated.dart';

class ListMenuItemOptionsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMenuItemOptionsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMenuItemOptionsData> dataDeserializer = (dynamic json)  => ListMenuItemOptionsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMenuItemOptionsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListMenuItemOptionsData, void> ref() {
    
    return _dataConnect.query("ListMenuItemOptions", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMenuItemOptionsMenuItemOptions {
  final String id;
  final String name;
  ListMenuItemOptionsMenuItemOptions.fromJson(dynamic json):
  
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

    final ListMenuItemOptionsMenuItemOptions otherTyped = other as ListMenuItemOptionsMenuItemOptions;
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

  ListMenuItemOptionsMenuItemOptions({
    required this.id,
    required this.name,
  });
}

@immutable
class ListMenuItemOptionsData {
  final List<ListMenuItemOptionsMenuItemOptions> menuItemOptions;
  ListMenuItemOptionsData.fromJson(dynamic json):
  
  menuItemOptions = (json['menuItemOptions'] as List<dynamic>)
        .map((e) => ListMenuItemOptionsMenuItemOptions.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMenuItemOptionsData otherTyped = other as ListMenuItemOptionsData;
    return menuItemOptions == otherTyped.menuItemOptions;
    
  }
  @override
  int get hashCode => menuItemOptions.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['menuItemOptions'] = menuItemOptions.map((e) => e.toJson()).toList();
    return json;
  }

  ListMenuItemOptionsData({
    required this.menuItemOptions,
  });
}

