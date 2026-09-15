# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetRestaurant
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getRestaurant(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetRestaurantData, GetRestaurantVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getRestaurant(
  id: id,
);
GetRestaurantData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getRestaurant(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListRestaurants
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listRestaurants().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListRestaurantsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listRestaurants();
ListRestaurantsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listRestaurants().ref();
ref.execute();

ref.subscribe(...);
```


### GetCategory
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getCategory(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetCategoryData, GetCategoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getCategory(
  id: id,
);
GetCategoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getCategory(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListCategories
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listCategories().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListCategoriesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listCategories();
ListCategoriesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listCategories().ref();
ref.execute();

ref.subscribe(...);
```


### GetMenuItem
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getMenuItem(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMenuItemData, GetMenuItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getMenuItem(
  id: id,
);
GetMenuItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getMenuItem(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListMenuItems
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listMenuItems().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMenuItemsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listMenuItems();
ListMenuItemsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listMenuItems().ref();
ref.execute();

ref.subscribe(...);
```


### GetMenuItemOption
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getMenuItemOption(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMenuItemOptionData, GetMenuItemOptionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getMenuItemOption(
  id: id,
);
GetMenuItemOptionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getMenuItemOption(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListMenuItemOptions
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listMenuItemOptions().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMenuItemOptionsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listMenuItemOptions();
ListMenuItemOptionsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listMenuItemOptions().ref();
ref.execute();

ref.subscribe(...);
```


### GetTable
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getTable(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetTableData, GetTableVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getTable(
  id: id,
);
GetTableData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getTable(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListTables
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listTables().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListTablesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listTables();
ListTablesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listTables().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateRestaurant
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.createRestaurant().execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateRestaurantData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createRestaurant();
CreateRestaurantData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.createRestaurant().ref();
ref.execute();
```


### UpdateRestaurant
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.updateRestaurant(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateRestaurant, we created `UpdateRestaurantBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateRestaurantVariablesBuilder {
  ...
   UpdateRestaurantVariablesBuilder name(String? t) {
   _name.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.updateRestaurant(
  id: id,
)
.name(name)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateRestaurantData, UpdateRestaurantVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateRestaurant(
  id: id,
);
UpdateRestaurantData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.updateRestaurant(
  id: id,
).ref();
ref.execute();
```


### DeleteRestaurant
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteRestaurant(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteRestaurantData, DeleteRestaurantVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteRestaurant(
  id: id,
);
DeleteRestaurantData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteRestaurant(
  id: id,
).ref();
ref.execute();
```


### CreateCategory
#### Required Arguments
```dart
String name = ...;
int sortOrder = ...;
String restaurantId = ...;
ExampleConnector.instance.createCategory(
  name: name,
  sortOrder: sortOrder,
  restaurantId: restaurantId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateCategoryData, CreateCategoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createCategory(
  name: name,
  sortOrder: sortOrder,
  restaurantId: restaurantId,
);
CreateCategoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
int sortOrder = ...;
String restaurantId = ...;

final ref = ExampleConnector.instance.createCategory(
  name: name,
  sortOrder: sortOrder,
  restaurantId: restaurantId,
).ref();
ref.execute();
```


### UpdateCategory
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.updateCategory(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateCategory, we created `UpdateCategoryBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateCategoryVariablesBuilder {
  ...
   UpdateCategoryVariablesBuilder sortOrder(int? t) {
   _sortOrder.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.updateCategory(
  id: id,
)
.sortOrder(sortOrder)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateCategoryData, UpdateCategoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateCategory(
  id: id,
);
UpdateCategoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.updateCategory(
  id: id,
).ref();
ref.execute();
```


### DeleteCategory
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteCategory(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteCategoryData, DeleteCategoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteCategory(
  id: id,
);
DeleteCategoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteCategory(
  id: id,
).ref();
ref.execute();
```


### CreateMenuItem
#### Required Arguments
```dart
String name = ...;
double price = ...;
bool isAvailable = ...;
String categoryId = ...;
ExampleConnector.instance.createMenuItem(
  name: name,
  price: price,
  isAvailable: isAvailable,
  categoryId: categoryId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateMenuItemData, CreateMenuItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createMenuItem(
  name: name,
  price: price,
  isAvailable: isAvailable,
  categoryId: categoryId,
);
CreateMenuItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
double price = ...;
bool isAvailable = ...;
String categoryId = ...;

final ref = ExampleConnector.instance.createMenuItem(
  name: name,
  price: price,
  isAvailable: isAvailable,
  categoryId: categoryId,
).ref();
ref.execute();
```


### UpdateMenuItem
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.updateMenuItem(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateMenuItem, we created `UpdateMenuItemBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateMenuItemVariablesBuilder {
  ...
   UpdateMenuItemVariablesBuilder isAvailable(bool? t) {
   _isAvailable.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.updateMenuItem(
  id: id,
)
.isAvailable(isAvailable)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateMenuItemData, UpdateMenuItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateMenuItem(
  id: id,
);
UpdateMenuItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.updateMenuItem(
  id: id,
).ref();
ref.execute();
```


### DeleteMenuItem
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteMenuItem(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMenuItemData, DeleteMenuItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteMenuItem(
  id: id,
);
DeleteMenuItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteMenuItem(
  id: id,
).ref();
ref.execute();
```


### CreateMenuItemOption
#### Required Arguments
```dart
String name = ...;
double priceAdjustment = ...;
String menuItemId = ...;
ExampleConnector.instance.createMenuItemOption(
  name: name,
  priceAdjustment: priceAdjustment,
  menuItemId: menuItemId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateMenuItemOptionData, CreateMenuItemOptionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createMenuItemOption(
  name: name,
  priceAdjustment: priceAdjustment,
  menuItemId: menuItemId,
);
CreateMenuItemOptionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
double priceAdjustment = ...;
String menuItemId = ...;

final ref = ExampleConnector.instance.createMenuItemOption(
  name: name,
  priceAdjustment: priceAdjustment,
  menuItemId: menuItemId,
).ref();
ref.execute();
```


### UpdateMenuItemOption
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.updateMenuItemOption(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateMenuItemOption, we created `UpdateMenuItemOptionBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateMenuItemOptionVariablesBuilder {
  ...
   UpdateMenuItemOptionVariablesBuilder priceAdjustment(double? t) {
   _priceAdjustment.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.updateMenuItemOption(
  id: id,
)
.priceAdjustment(priceAdjustment)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateMenuItemOptionData, UpdateMenuItemOptionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateMenuItemOption(
  id: id,
);
UpdateMenuItemOptionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.updateMenuItemOption(
  id: id,
).ref();
ref.execute();
```


### DeleteMenuItemOption
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteMenuItemOption(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMenuItemOptionData, DeleteMenuItemOptionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteMenuItemOption(
  id: id,
);
DeleteMenuItemOptionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteMenuItemOption(
  id: id,
).ref();
ref.execute();
```


### CreateTable
#### Required Arguments
```dart
int tableNumber = ...;
String qrCodeUrl = ...;
String restaurantId = ...;
ExampleConnector.instance.createTable(
  tableNumber: tableNumber,
  qrCodeUrl: qrCodeUrl,
  restaurantId: restaurantId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateTableData, CreateTableVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createTable(
  tableNumber: tableNumber,
  qrCodeUrl: qrCodeUrl,
  restaurantId: restaurantId,
);
CreateTableData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
int tableNumber = ...;
String qrCodeUrl = ...;
String restaurantId = ...;

final ref = ExampleConnector.instance.createTable(
  tableNumber: tableNumber,
  qrCodeUrl: qrCodeUrl,
  restaurantId: restaurantId,
).ref();
ref.execute();
```


### UpdateTable
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.updateTable(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateTable, we created `UpdateTableBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateTableVariablesBuilder {
  ...
   UpdateTableVariablesBuilder qrCodeUrl(String? t) {
   _qrCodeUrl.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.updateTable(
  id: id,
)
.qrCodeUrl(qrCodeUrl)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateTableData, UpdateTableVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateTable(
  id: id,
);
UpdateTableData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.updateTable(
  id: id,
).ref();
ref.execute();
```


### DeleteTable
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteTable(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteTableData, DeleteTableVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteTable(
  id: id,
);
DeleteTableData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteTable(
  id: id,
).ref();
ref.execute();
```

