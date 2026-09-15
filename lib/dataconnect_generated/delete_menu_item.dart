part of 'generated.dart';

class DeleteMenuItemVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteMenuItemVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMenuItemData> dataDeserializer = (dynamic json)  => DeleteMenuItemData.fromJson(jsonDecode(json));
  Serializer<DeleteMenuItemVariables> varsSerializer = (DeleteMenuItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMenuItemData, DeleteMenuItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMenuItemData, DeleteMenuItemVariables> ref() {
    DeleteMenuItemVariables vars= DeleteMenuItemVariables(id: id,);
    return _dataConnect.mutation("DeleteMenuItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMenuItemMenuItemDelete {
  final String id;
  DeleteMenuItemMenuItemDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMenuItemMenuItemDelete otherTyped = other as DeleteMenuItemMenuItemDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMenuItemMenuItemDelete({
    required this.id,
  });
}

@immutable
class DeleteMenuItemData {
  final DeleteMenuItemMenuItemDelete? menuItem_delete;
  DeleteMenuItemData.fromJson(dynamic json):
  
  menuItem_delete = json['menuItem_delete'] == null ? null : DeleteMenuItemMenuItemDelete.fromJson(json['menuItem_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMenuItemData otherTyped = other as DeleteMenuItemData;
    return menuItem_delete == otherTyped.menuItem_delete;
    
  }
  @override
  int get hashCode => menuItem_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (menuItem_delete != null) {
      json['menuItem_delete'] = menuItem_delete!.toJson();
    }
    return json;
  }

  DeleteMenuItemData({
    this.menuItem_delete,
  });
}

@immutable
class DeleteMenuItemVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMenuItemVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMenuItemVariables otherTyped = other as DeleteMenuItemVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMenuItemVariables({
    required this.id,
  });
}

