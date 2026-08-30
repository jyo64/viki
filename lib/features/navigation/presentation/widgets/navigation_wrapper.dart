import 'package:flutter/material.dart';
import 'package:viki/features/home/presentation/pages/home_page.dart';
import 'package:viki/features/inventory/presentation/pages/add_item_page.dart';

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _selectedIndex = 0;
  final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();

  late final List<Widget> _pages = [HomePage(key: _homePageKey)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Inventory')),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AddItemPage()));
          _homePageKey.currentState?.loadItems();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
