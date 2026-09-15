part of 'generated.dart';

class DeleteCategoryVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteCategoryVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteCategoryData> dataDeserializer = (dynamic json)  => DeleteCategoryData.fromJson(jsonDecode(json));
  Serializer<DeleteCategoryVariables> varsSerializer = (DeleteCategoryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteCategoryData, DeleteCategoryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteCategoryData, DeleteCategoryVariables> ref() {
    DeleteCategoryVariables vars= DeleteCategoryVariables(id: id,);
    return _dataConnect.mutation("DeleteCategory", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteCategoryCategoryDelete {
  final String id;
  DeleteCategoryCategoryDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteCategoryCategoryDelete otherTyped = other as DeleteCategoryCategoryDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteCategoryCategoryDelete({
    required this.id,
  });
}

@immutable
class DeleteCategoryData {
  final DeleteCategoryCategoryDelete? category_delete;
  DeleteCategoryData.fromJson(dynamic json):
  
  category_delete = json['category_delete'] == null ? null : DeleteCategoryCategoryDelete.fromJson(json['category_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteCategoryData otherTyped = other as DeleteCategoryData;
    return category_delete == otherTyped.category_delete;
    
  }
  @override
  int get hashCode => category_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (category_delete != null) {
      json['category_delete'] = category_delete!.toJson();
    }
    return json;
  }

  DeleteCategoryData({
    this.category_delete,
  });
}

@immutable
class DeleteCategoryVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteCategoryVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteCategoryVariables otherTyped = other as DeleteCategoryVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteCategoryVariables({
    required this.id,
  });
}

