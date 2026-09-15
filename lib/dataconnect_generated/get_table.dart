part of 'generated.dart';

class GetTableVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetTableVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetTableData> dataDeserializer = (dynamic json)  => GetTableData.fromJson(jsonDecode(json));
  Serializer<GetTableVariables> varsSerializer = (GetTableVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetTableData, GetTableVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetTableData, GetTableVariables> ref() {
    GetTableVariables vars= GetTableVariables(id: id,);
    return _dataConnect.query("GetTable", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetTableTable {
  final int tableNumber;
  final String qrCodeUrl;
  GetTableTable.fromJson(dynamic json):
  
  tableNumber = nativeFromJson<int>(json['tableNumber']),
  qrCodeUrl = nativeFromJson<String>(json['qrCodeUrl']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetTableTable otherTyped = other as GetTableTable;
    return tableNumber == otherTyped.tableNumber && 
    qrCodeUrl == otherTyped.qrCodeUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([tableNumber.hashCode, qrCodeUrl.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tableNumber'] = nativeToJson<int>(tableNumber);
    json['qrCodeUrl'] = nativeToJson<String>(qrCodeUrl);
    return json;
  }

  GetTableTable({
    required this.tableNumber,
    required this.qrCodeUrl,
  });
}

@immutable
class GetTableData {
  final GetTableTable? table;
  GetTableData.fromJson(dynamic json):
  
  table = json['table'] == null ? null : GetTableTable.fromJson(json['table']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetTableData otherTyped = other as GetTableData;
    return table == otherTyped.table;
    
  }
  @override
  int get hashCode => table.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (table != null) {
      json['table'] = table!.toJson();
    }
    return json;
  }

  GetTableData({
    this.table,
  });
}

@immutable
class GetTableVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetTableVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetTableVariables otherTyped = other as GetTableVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetTableVariables({
    required this.id,
  });
}

