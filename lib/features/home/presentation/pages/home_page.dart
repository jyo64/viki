import 'package:flutter/material.dart';
import 'package:viki/features/inventory/data/services/inventory_service.dart';
import 'package:viki/features/inventory/domain/models/item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Item> _items = [];
  bool _isLoading = true;
  final LocalInventoryService _inventoryService = LocalInventoryService();

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    setState(() => _isLoading = true);
    try {
      final items = await _inventoryService.loadItems();
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // Handle error (e.g., show snackbar)
    }
  }

  String _calculateDaysToExpiry(String expiryDate) {
    try {
      final DateTime expiry = DateTime.parse(expiryDate);
      final DateTime now = DateTime.now();
      final int difference = expiry.difference(now).inDays;
      return '$difference days left';
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_items.isEmpty) {
      return const Center(child: Text('No items in inventory'));
    }

    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(_calculateDaysToExpiry(item.expiryDate)),
          leading: const Icon(Icons.inventory_2),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await _inventoryService.deleteItem(item.id);
              await loadItems();
            },
          ),
        );
      },
    );
  }
}
