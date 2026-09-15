part of 'generated.dart';

class CreateTableVariablesBuilder {
  int tableNumber;
  String qrCodeUrl;
  String restaurantId;

  final FirebaseDataConnect _dataConnect;
  CreateTableVariablesBuilder(this._dataConnect, {required  this.tableNumber,required  this.qrCodeUrl,required  this.restaurantId,});
  Deserializer<CreateTableData> dataDeserializer = (dynamic json)  => CreateTableData.fromJson(jsonDecode(json));
  Serializer<CreateTableVariables> varsSerializer = (CreateTableVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateTableData, CreateTableVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateTableData, CreateTableVariables> ref() {
    CreateTableVariables vars= CreateTableVariables(tableNumber: tableNumber,qrCodeUrl: qrCodeUrl,restaurantId: restaurantId,);
    return _dataConnect.mutation("CreateTable", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateTableTableInsert {
  final String id;
  CreateTableTableInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTableTableInsert otherTyped = other as CreateTableTableInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateTableTableInsert({
    required this.id,
  });
}

@immutable
class CreateTableData {
  final CreateTableTableInsert table_insert;
  CreateTableData.fromJson(dynamic json):
  
  table_insert = CreateTableTableInsert.fromJson(json['table_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTableData otherTyped = other as CreateTableData;
    return table_insert == otherTyped.table_insert;
    
  }
  @override
  int get hashCode => table_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['table_insert'] = table_insert.toJson();
    return json;
  }

  CreateTableData({
    required this.table_insert,
  });
}

@immutable
class CreateTableVariables {
  final int tableNumber;
  final String qrCodeUrl;
  final String restaurantId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateTableVariables.fromJson(Map<String, dynamic> json):
  
  tableNumber = nativeFromJson<int>(json['tableNumber']),
  qrCodeUrl = nativeFromJson<String>(json['qrCodeUrl']),
  restaurantId = nativeFromJson<String>(json['restaurantId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTableVariables otherTyped = other as CreateTableVariables;
    return tableNumber == otherTyped.tableNumber && 
    qrCodeUrl == otherTyped.qrCodeUrl && 
    restaurantId == otherTyped.restaurantId;
    
  }
  @override
  int get hashCode => Object.hashAll([tableNumber.hashCode, qrCodeUrl.hashCode, restaurantId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tableNumber'] = nativeToJson<int>(tableNumber);
    json['qrCodeUrl'] = nativeToJson<String>(qrCodeUrl);
    json['restaurantId'] = nativeToJson<String>(restaurantId);
    return json;
  }

  CreateTableVariables({
    required this.tableNumber,
    required this.qrCodeUrl,
    required this.restaurantId,
  });
}

