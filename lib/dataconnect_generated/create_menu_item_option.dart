part of 'generated.dart';

class CreateMenuItemOptionVariablesBuilder {
  String name;
  double priceAdjustment;
  String menuItemId;

  final FirebaseDataConnect _dataConnect;
  CreateMenuItemOptionVariablesBuilder(this._dataConnect, {required  this.name,required  this.priceAdjustment,required  this.menuItemId,});
  Deserializer<CreateMenuItemOptionData> dataDeserializer = (dynamic json)  => CreateMenuItemOptionData.fromJson(jsonDecode(json));
  Serializer<CreateMenuItemOptionVariables> varsSerializer = (CreateMenuItemOptionVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateMenuItemOptionData, CreateMenuItemOptionVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateMenuItemOptionData, CreateMenuItemOptionVariables> ref() {
    CreateMenuItemOptionVariables vars= CreateMenuItemOptionVariables(name: name,priceAdjustment: priceAdjustment,menuItemId: menuItemId,);
    return _dataConnect.mutation("CreateMenuItemOption", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateMenuItemOptionMenuItemOptionInsert {
  final String id;
  CreateMenuItemOptionMenuItemOptionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMenuItemOptionMenuItemOptionInsert otherTyped = other as CreateMenuItemOptionMenuItemOptionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateMenuItemOptionMenuItemOptionInsert({
    required this.id,
  });
}

@immutable
class CreateMenuItemOptionData {
  final CreateMenuItemOptionMenuItemOptionInsert menuItemOption_insert;
  CreateMenuItemOptionData.fromJson(dynamic json):
  
  menuItemOption_insert = CreateMenuItemOptionMenuItemOptionInsert.fromJson(json['menuItemOption_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMenuItemOptionData otherTyped = other as CreateMenuItemOptionData;
    return menuItemOption_insert == otherTyped.menuItemOption_insert;
    
  }
  @override
  int get hashCode => menuItemOption_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['menuItemOption_insert'] = menuItemOption_insert.toJson();
    return json;
  }

  CreateMenuItemOptionData({
    required this.menuItemOption_insert,
  });
}

@immutable
class CreateMenuItemOptionVariables {
  final String name;
  final double priceAdjustment;
  final String menuItemId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateMenuItemOptionVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  priceAdjustment = nativeFromJson<double>(json['priceAdjustment']),
  menuItemId = nativeFromJson<String>(json['menuItemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMenuItemOptionVariables otherTyped = other as CreateMenuItemOptionVariables;
    return name == otherTyped.name && 
    priceAdjustment == otherTyped.priceAdjustment && 
    menuItemId == otherTyped.menuItemId;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, priceAdjustment.hashCode, menuItemId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['priceAdjustment'] = nativeToJson<double>(priceAdjustment);
    json['menuItemId'] = nativeToJson<String>(menuItemId);
    return json;
  }

  CreateMenuItemOptionVariables({
    required this.name,
    required this.priceAdjustment,
    required this.menuItemId,
  });
}

