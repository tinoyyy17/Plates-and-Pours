part of 'generated.dart';

class GetMenuItemOptionVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetMenuItemOptionVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetMenuItemOptionData> dataDeserializer = (dynamic json)  => GetMenuItemOptionData.fromJson(jsonDecode(json));
  Serializer<GetMenuItemOptionVariables> varsSerializer = (GetMenuItemOptionVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetMenuItemOptionData, GetMenuItemOptionVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetMenuItemOptionData, GetMenuItemOptionVariables> ref() {
    GetMenuItemOptionVariables vars= GetMenuItemOptionVariables(id: id,);
    return _dataConnect.query("GetMenuItemOption", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetMenuItemOptionMenuItemOption {
  final String name;
  final double priceAdjustment;
  GetMenuItemOptionMenuItemOption.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  priceAdjustment = nativeFromJson<double>(json['priceAdjustment']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMenuItemOptionMenuItemOption otherTyped = other as GetMenuItemOptionMenuItemOption;
    return name == otherTyped.name && 
    priceAdjustment == otherTyped.priceAdjustment;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, priceAdjustment.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['priceAdjustment'] = nativeToJson<double>(priceAdjustment);
    return json;
  }

  GetMenuItemOptionMenuItemOption({
    required this.name,
    required this.priceAdjustment,
  });
}

@immutable
class GetMenuItemOptionData {
  final GetMenuItemOptionMenuItemOption? menuItemOption;
  GetMenuItemOptionData.fromJson(dynamic json):
  
  menuItemOption = json['menuItemOption'] == null ? null : GetMenuItemOptionMenuItemOption.fromJson(json['menuItemOption']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMenuItemOptionData otherTyped = other as GetMenuItemOptionData;
    return menuItemOption == otherTyped.menuItemOption;
    
  }
  @override
  int get hashCode => menuItemOption.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (menuItemOption != null) {
      json['menuItemOption'] = menuItemOption!.toJson();
    }
    return json;
  }

  GetMenuItemOptionData({
    this.menuItemOption,
  });
}

@immutable
class GetMenuItemOptionVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetMenuItemOptionVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMenuItemOptionVariables otherTyped = other as GetMenuItemOptionVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetMenuItemOptionVariables({
    required this.id,
  });
}

