library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_restaurant.dart';

part 'update_restaurant.dart';

part 'delete_restaurant.dart';

part 'get_restaurant.dart';

part 'list_restaurants.dart';

part 'create_category.dart';

part 'update_category.dart';

part 'delete_category.dart';

part 'get_category.dart';

part 'list_categories.dart';

part 'create_menu_item.dart';

part 'update_menu_item.dart';

part 'delete_menu_item.dart';

part 'get_menu_item.dart';

part 'list_menu_items.dart';

part 'create_menu_item_option.dart';

part 'update_menu_item_option.dart';

part 'delete_menu_item_option.dart';

part 'get_menu_item_option.dart';

part 'list_menu_item_options.dart';

part 'create_table.dart';

part 'update_table.dart';

part 'delete_table.dart';

part 'get_table.dart';

part 'list_tables.dart';







class ExampleConnector {
  
  
  CreateRestaurantVariablesBuilder createRestaurant () {
    return CreateRestaurantVariablesBuilder(dataConnect, );
  }
  
  
  UpdateRestaurantVariablesBuilder updateRestaurant ({required String id, }) {
    return UpdateRestaurantVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteRestaurantVariablesBuilder deleteRestaurant ({required String id, }) {
    return DeleteRestaurantVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetRestaurantVariablesBuilder getRestaurant ({required String id, }) {
    return GetRestaurantVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListRestaurantsVariablesBuilder listRestaurants () {
    return ListRestaurantsVariablesBuilder(dataConnect, );
  }
  
  
  CreateCategoryVariablesBuilder createCategory ({required String name, required int sortOrder, required String restaurantId, }) {
    return CreateCategoryVariablesBuilder(dataConnect, name: name,sortOrder: sortOrder,restaurantId: restaurantId,);
  }
  
  
  UpdateCategoryVariablesBuilder updateCategory ({required String id, }) {
    return UpdateCategoryVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteCategoryVariablesBuilder deleteCategory ({required String id, }) {
    return DeleteCategoryVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetCategoryVariablesBuilder getCategory ({required String id, }) {
    return GetCategoryVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListCategoriesVariablesBuilder listCategories () {
    return ListCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  CreateMenuItemVariablesBuilder createMenuItem ({required String name, required double price, required bool isAvailable, required String categoryId, }) {
    return CreateMenuItemVariablesBuilder(dataConnect, name: name,price: price,isAvailable: isAvailable,categoryId: categoryId,);
  }
  
  
  UpdateMenuItemVariablesBuilder updateMenuItem ({required String id, }) {
    return UpdateMenuItemVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteMenuItemVariablesBuilder deleteMenuItem ({required String id, }) {
    return DeleteMenuItemVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetMenuItemVariablesBuilder getMenuItem ({required String id, }) {
    return GetMenuItemVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMenuItemsVariablesBuilder listMenuItems () {
    return ListMenuItemsVariablesBuilder(dataConnect, );
  }
  
  
  CreateMenuItemOptionVariablesBuilder createMenuItemOption ({required String name, required double priceAdjustment, required String menuItemId, }) {
    return CreateMenuItemOptionVariablesBuilder(dataConnect, name: name,priceAdjustment: priceAdjustment,menuItemId: menuItemId,);
  }
  
  
  UpdateMenuItemOptionVariablesBuilder updateMenuItemOption ({required String id, }) {
    return UpdateMenuItemOptionVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteMenuItemOptionVariablesBuilder deleteMenuItemOption ({required String id, }) {
    return DeleteMenuItemOptionVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetMenuItemOptionVariablesBuilder getMenuItemOption ({required String id, }) {
    return GetMenuItemOptionVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMenuItemOptionsVariablesBuilder listMenuItemOptions () {
    return ListMenuItemOptionsVariablesBuilder(dataConnect, );
  }
  
  
  CreateTableVariablesBuilder createTable ({required int tableNumber, required String qrCodeUrl, required String restaurantId, }) {
    return CreateTableVariablesBuilder(dataConnect, tableNumber: tableNumber,qrCodeUrl: qrCodeUrl,restaurantId: restaurantId,);
  }
  
  
  UpdateTableVariablesBuilder updateTable ({required String id, }) {
    return UpdateTableVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteTableVariablesBuilder deleteTable ({required String id, }) {
    return DeleteTableVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetTableVariablesBuilder getTable ({required String id, }) {
    return GetTableVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListTablesVariablesBuilder listTables () {
    return ListTablesVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-east4',
    'example',
    'finalprojectplatesandpourscafe',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    
    CacheSettings cacheSettings = CacheSettings(
      maxAge: Duration(milliseconds:0),
      storage: CacheStorage.persistent,
    );
    
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            cacheSettings: cacheSettings,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
