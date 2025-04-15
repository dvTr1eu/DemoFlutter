import 'package:demo_bottomtab_tabbar/view/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../controller/main_wrapper_controller.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Map<String, dynamic>> _listUsers = [];
  final MainWrapperController controller = Get.find();
  List<dynamic> _foundUsers = [];
  bool _isLoading = false;

  void _loadData() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _listUsers = List<Map<String, dynamic>>.from(controller.users);
        _foundUsers = _listUsers;
        _isLoading = false;
      });
    });
  }


  void _runFilter(String enteredKeyword) {
    setState(() {
      if (enteredKeyword.isEmpty) {
        _foundUsers = _listUsers;
      } else {
        _foundUsers =
            _listUsers.where((user) {
              final firstName = user['name']['first'].toLowerCase();
              final lastName = user['name']['last'].toLowerCase();
              final fullName = '$firstName $lastName';
              return fullName.contains(enteredKeyword.toLowerCase());
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Users"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _listUsers.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "No data available. Please refresh the page.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _loadData, 
                                child: const Text("Refresh"),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            _loadData();
                          },
                          child: ListView.builder(
                            itemCount: _foundUsers.length,
                            itemBuilder: (context, index) {
                              final user = _foundUsers[index];
                              final email = user['email'];
                              final firstName = user['name']['first'];
                              final lastName = user['name']['last'];
                              final age = user['registered']['age'];
                              final imageUrl = user['picture']['thumbnail'];
                              return Card(
                                key: ValueKey(index),
                                color: Colors.blue,
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  onTap: () => Get.to(() => ProfileTab(), arguments: user),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(imageUrl),
                                  ),
                                  title: Text(
                                    firstName + " " + lastName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${age} years old',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
