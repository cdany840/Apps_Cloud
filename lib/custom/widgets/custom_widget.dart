import 'package:flutter/material.dart';

// * ListTile
class CustomListTile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String routeAsset;
  final String title;
  final String subtitle;

  const CustomListTile({
    super.key,
    required this.routeAsset,
    required this.title,
    required this.subtitle,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(routeAsset), //asset('assets/icon_orange.png'),
      trailing: const Icon(Icons.chevron_right),
      title: Text(title), //FruitApp
      subtitle: Text(subtitle), //Carrusel,
      onTap: onTap,
    );
  }
}

// * TextField
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}

// * FloatingActionButton
class CustomFloatingActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  

  const CustomFloatingActionButton({
    super.key, 
    required this.text, 
    required this.icon, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(icon),
      label: Text(text),
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 234, 111, 166),
      onPressed: onPressed
    );
  }
}