part of 'generated.dart';

class UpdateTableVariablesBuilder {
  String id;
  Optional<String> _qrCodeUrl = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateTableVariablesBuilder qrCodeUrl(String? t) {
   _qrCodeUrl.value = t;
   return this;
  }

  UpdateTableVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateTableData> dataDeserializer = (dynamic json)  => UpdateTableData.fromJson(jsonDecode(json));
  Serializer<UpdateTableVariables> varsSerializer = (UpdateTableVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateTableData, UpdateTableVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateTableData, UpdateTableVariables> ref() {
    UpdateTableVariables vars= UpdateTableVariables(id: id,qrCodeUrl: _qrCodeUrl,);
    return _dataConnect.mutation("UpdateTable", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateTableTableUpdate {
  final String id;
  UpdateTableTableUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateTableTableUpdate otherTyped = other as UpdateTableTableUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateTableTableUpdate({
    required this.id,
  });
}

@immutable
class UpdateTableData {
  final UpdateTableTableUpdate? table_update;
  UpdateTableData.fromJson(dynamic json):
  
  table_update = json['table_update'] == null ? null : UpdateTableTableUpdate.fromJson(json['table_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateTableData otherTyped = other as UpdateTableData;
    return table_update == otherTyped.table_update;
    
  }
  @override
  int get hashCode => table_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (table_update != null) {
      json['table_update'] = table_update!.toJson();
    }
    return json;
  }

  UpdateTableData({
    this.table_update,
  });
}

@immutable
class UpdateTableVariables {
  final String id;
  late final Optional<String>qrCodeUrl;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateTableVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    qrCodeUrl = Optional.optional(nativeFromJson, nativeToJson);
    qrCodeUrl.value = json['qrCodeUrl'] == null ? null : nativeFromJson<String>(json['qrCodeUrl']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateTableVariables otherTyped = other as UpdateTableVariables;
    return id == otherTyped.id && 
    qrCodeUrl == otherTyped.qrCodeUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, qrCodeUrl.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(qrCodeUrl.state == OptionalState.set) {
      json['qrCodeUrl'] = qrCodeUrl.toJson();
    }
    return json;
  }

  UpdateTableVariables({
    required this.id,
    required this.qrCodeUrl,
  });
}

