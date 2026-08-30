import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:viki/features/inventory/domain/models/item.dart';

class LocalInventoryService {
  static const String _fileName = 'inventory.json';

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<void> saveItem(Item item) async {
    try {
      final file = await _getLocalFile();
      List<Item> items = await loadItems();
      items.add(item);

      final String jsonString = jsonEncode(
        items.map((i) => i.toJson()).toList(),
      );
      await file.writeAsString(jsonString);
    } catch (e) {
      throw Exception('Failed to save item: $e');
    }
  }

  Future<List<Item>> loadItems() async {
    try {
      final file = await _getLocalFile();
      if (!await file.exists()) {
        return [];
      }

      final String contents = await file.readAsString();
      if (contents.isEmpty) {
        return [];
      }

      final List<dynamic> jsonData = jsonDecode(contents);
      return jsonData
          .map((json) => Item.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load items: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      final file = await _getLocalFile();
      List<Item> items = await loadItems();

      final updatedItems = items.where((item) => item.id != id).toList();

      final String jsonString = jsonEncode(
        updatedItems.map((i) => i.toJson()).toList(),
      );
      await file.writeAsString(jsonString);
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }
}
