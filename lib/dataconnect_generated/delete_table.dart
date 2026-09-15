part of 'generated.dart';

class DeleteTableVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteTableVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteTableData> dataDeserializer = (dynamic json)  => DeleteTableData.fromJson(jsonDecode(json));
  Serializer<DeleteTableVariables> varsSerializer = (DeleteTableVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteTableData, DeleteTableVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteTableData, DeleteTableVariables> ref() {
    DeleteTableVariables vars= DeleteTableVariables(id: id,);
    return _dataConnect.mutation("DeleteTable", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteTableTableDelete {
  final String id;
  DeleteTableTableDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteTableTableDelete otherTyped = other as DeleteTableTableDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteTableTableDelete({
    required this.id,
  });
}

@immutable
class DeleteTableData {
  final DeleteTableTableDelete? table_delete;
  DeleteTableData.fromJson(dynamic json):
  
  table_delete = json['table_delete'] == null ? null : DeleteTableTableDelete.fromJson(json['table_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteTableData otherTyped = other as DeleteTableData;
    return table_delete == otherTyped.table_delete;
    
  }
  @override
  int get hashCode => table_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (table_delete != null) {
      json['table_delete'] = table_delete!.toJson();
    }
    return json;
  }

  DeleteTableData({
    this.table_delete,
  });
}

@immutable
class DeleteTableVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteTableVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteTableVariables otherTyped = other as DeleteTableVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteTableVariables({
    required this.id,
  });
}

