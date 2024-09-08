import 'package:flutter/material.dart';
import 'package:beauty_salon/global.dart' as globals;
import 'package:beauty_salon/screens/category_screen.dart';
import 'package:beauty_salon/widgets/grid_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(246, 247, 249, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(246, 247, 249, 1),
          leading: Image.asset('assets/images/logo-1.png'),
          title: const Text('RinZin Divine Beauty'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                // Additional actions can be added here
              },
              icon: const Icon(Icons.person),
            ),
            const SizedBox(width: 5),
          ],
        ),
        body: Center(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            padding: const EdgeInsets.all(20.0),
            children: [
              GridButton(
                icon: Icons.ads_click_rounded,
                label: 'MINTO',
                onTap: () {
                  globals.globalTownId = 1;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(townId: globals.globalTownId),
                    ),
                  );
                },
              ),
              GridButton(
                icon: Icons.ads_click_rounded,
                label: 'CAMPBELLTOWN',
                onTap: () {
                  globals.globalTownId = 2;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(townId: globals.globalTownId),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
