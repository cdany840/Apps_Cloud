import 'package:flutter/material.dart';
import 'package:pmsn20232/providers/test_provider.dart';
import 'package:provider/provider.dart';

class TestProviderScreen extends StatelessWidget {
  const TestProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider = Provider.of<TestProvider>(context);
    return Scaffold(
      body: Center(
        child: Text(UserProvider.user),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        UserProvider.user = 'hola:) xdxdxdxdxdx';
      }),
    );
  }
}