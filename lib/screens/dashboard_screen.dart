import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/custom/widgets/custom_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!!!'),
      ),
      drawer: createDrawer(),
    );
  }

  Widget createDrawer(){
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/333'),
            ),
            accountName: Text('Cdany'), 
            accountEmail: Text('cdanymira@gmail.com')
          ),
          CustomListTile(
            routeAsset: 'assets/icons/icon_orange.png',
            title: 'FruitApp',
            subtitle: 'Carrusel',
            onTap: () {
              Navigator.pushNamed(context, '/fruitApp');
            },
          ),
          CustomListTile(
            routeAsset: 'assets/icons/icon_task.png',
            title: 'TaskApp', 
            subtitle: 'List',
            onTap: () {
              Navigator.pushNamed(context, '/task');
            },
          ),
          CustomListTile(
            routeAsset: 'assets/icons/icon_transition_right.png',
            title: 'Onboarding', 
            subtitle: 'Animation',
            onTap: () {
              Navigator.pushNamed(context, '/onboarding');
            },
          ),
          CustomListTile(
            routeAsset: 'assets/icons/icon_movie.png',
            title: 'Movies', 
            subtitle: 'Thes best movies',
            onTap: () {
              Navigator.pushNamed(context, '/popular');
            },
          ),
          CustomListTile(
            routeAsset: 'assets/icons/icon_teacher_task.png',
            title: 'Teacher Task',
            subtitle: 'See Pending Tasks',
            onTap: () {
              Navigator.pushNamed(context, '/teacherTask');
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: DayNightSwitcher(
              isDarkModeEnabled: GlobalValues.flagTheme.value,
              onStateChanged: (isDarkModeEnabled) async {              
                setState(() {
                  GlobalValues.prefsTheme.setBool('themeValue', isDarkModeEnabled);
                  GlobalValues.flagTheme.value = isDarkModeEnabled; // ? Preguntar sobre esto.
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: CustomFloatingActionButton(
              icon: Icons.login_outlined,
              text: 'Sing Off',
              onPressed: () {
                GlobalValues.prefsCheck.setBool("checkValue", false);
                Navigator.pushNamed(context, '/login');
              } 
            ),
          )
        ],
      ),
    );
  }
}