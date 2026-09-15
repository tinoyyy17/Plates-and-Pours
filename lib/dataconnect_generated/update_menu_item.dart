part of 'generated.dart';

class UpdateMenuItemVariablesBuilder {
  String id;
  Optional<bool> _isAvailable = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateMenuItemVariablesBuilder isAvailable(bool? t) {
   _isAvailable.value = t;
   return this;
  }

  UpdateMenuItemVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateMenuItemData> dataDeserializer = (dynamic json)  => UpdateMenuItemData.fromJson(jsonDecode(json));
  Serializer<UpdateMenuItemVariables> varsSerializer = (UpdateMenuItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMenuItemData, UpdateMenuItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMenuItemData, UpdateMenuItemVariables> ref() {
    UpdateMenuItemVariables vars= UpdateMenuItemVariables(id: id,isAvailable: _isAvailable,);
    return _dataConnect.mutation("UpdateMenuItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMenuItemMenuItemUpdate {
  final String id;
  UpdateMenuItemMenuItemUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMenuItemMenuItemUpdate otherTyped = other as UpdateMenuItemMenuItemUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMenuItemMenuItemUpdate({
    required this.id,
  });
}

@immutable
class UpdateMenuItemData {
  final UpdateMenuItemMenuItemUpdate? menuItem_update;
  UpdateMenuItemData.fromJson(dynamic json):
  
  menuItem_update = json['menuItem_update'] == null ? null : UpdateMenuItemMenuItemUpdate.fromJson(json['menuItem_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMenuItemData otherTyped = other as UpdateMenuItemData;
    return menuItem_update == otherTyped.menuItem_update;
    
  }
  @override
  int get hashCode => menuItem_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (menuItem_update != null) {
      json['menuItem_update'] = menuItem_update!.toJson();
    }
    return json;
  }

  UpdateMenuItemData({
    this.menuItem_update,
  });
}

@immutable
class UpdateMenuItemVariables {
  final String id;
  late final Optional<bool>isAvailable;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMenuItemVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    isAvailable = Optional.optional(nativeFromJson, nativeToJson);
    isAvailable.value = json['isAvailable'] == null ? null : nativeFromJson<bool>(json['isAvailable']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMenuItemVariables otherTyped = other as UpdateMenuItemVariables;
    return id == otherTyped.id && 
    isAvailable == otherTyped.isAvailable;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, isAvailable.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(isAvailable.state == OptionalState.set) {
      json['isAvailable'] = isAvailable.toJson();
    }
    return json;
  }

  UpdateMenuItemVariables({
    required this.id,
    required this.isAvailable,
  });
}

