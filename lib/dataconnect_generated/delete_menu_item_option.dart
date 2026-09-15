part of 'generated.dart';

class DeleteMenuItemOptionVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteMenuItemOptionVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMenuItemOptionData> dataDeserializer = (dynamic json)  => DeleteMenuItemOptionData.fromJson(jsonDecode(json));
  Serializer<DeleteMenuItemOptionVariables> varsSerializer = (DeleteMenuItemOptionVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMenuItemOptionData, DeleteMenuItemOptionVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMenuItemOptionData, DeleteMenuItemOptionVariables> ref() {
    DeleteMenuItemOptionVariables vars= DeleteMenuItemOptionVariables(id: id,);
    return _dataConnect.mutation("DeleteMenuItemOption", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMenuItemOptionMenuItemOptionDelete {
  final String id;
  DeleteMenuItemOptionMenuItemOptionDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMenuItemOptionMenuItemOptionDelete otherTyped = other as DeleteMenuItemOptionMenuItemOptionDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMenuItemOptionMenuItemOptionDelete({
    required this.id,
  });
}

@immutable
class DeleteMenuItemOptionData {
  final DeleteMenuItemOptionMenuItemOptionDelete? menuItemOption_delete;
  DeleteMenuItemOptionData.fromJson(dynamic json):
  
  menuItemOption_delete = json['menuItemOption_delete'] == null ? null : DeleteMenuItemOptionMenuItemOptionDelete.fromJson(json['menuItemOption_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMenuItemOptionData otherTyped = other as DeleteMenuItemOptionData;
    return menuItemOption_delete == otherTyped.menuItemOption_delete;
    
  }
  @override
  int get hashCode => menuItemOption_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (menuItemOption_delete != null) {
      json['menuItemOption_delete'] = menuItemOption_delete!.toJson();
    }
    return json;
  }

  DeleteMenuItemOptionData({
    this.menuItemOption_delete,
  });
}

@immutable
class DeleteMenuItemOptionVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMenuItemOptionVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMenuItemOptionVariables otherTyped = other as DeleteMenuItemOptionVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMenuItemOptionVariables({
    required this.id,
  });
}

