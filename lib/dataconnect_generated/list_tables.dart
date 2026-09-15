part of 'generated.dart';

class ListTablesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListTablesVariablesBuilder(this._dataConnect, );
  Deserializer<ListTablesData> dataDeserializer = (dynamic json)  => ListTablesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListTablesData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListTablesData, void> ref() {
    
    return _dataConnect.query("ListTables", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListTablesTables {
  final String id;
  final int tableNumber;
  ListTablesTables.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  tableNumber = nativeFromJson<int>(json['tableNumber']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListTablesTables otherTyped = other as ListTablesTables;
    return id == otherTyped.id && 
    tableNumber == otherTyped.tableNumber;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, tableNumber.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['tableNumber'] = nativeToJson<int>(tableNumber);
    return json;
  }

  ListTablesTables({
    required this.id,
    required this.tableNumber,
  });
}

@immutable
class ListTablesData {
  final List<ListTablesTables> tables;
  ListTablesData.fromJson(dynamic json):
  
  tables = (json['tables'] as List<dynamic>)
        .map((e) => ListTablesTables.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListTablesData otherTyped = other as ListTablesData;
    return tables == otherTyped.tables;
    
  }
  @override
  int get hashCode => tables.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tables'] = tables.map((e) => e.toJson()).toList();
    return json;
  }

  ListTablesData({
    required this.tables,
  });
}

