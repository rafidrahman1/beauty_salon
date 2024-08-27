import 'package:beauty_salon/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'category_screen.dart';

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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen())
                );
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
              _buildGridButton(
                icon: Icons.ads_click_rounded,
                label: 'MINTO',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CategoryScreen(townId: 1))
                  );
                },
              ),
              _buildGridButton(
                icon: Icons.ads_click_rounded,
                label: 'CAMPBELLTOWN',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CategoryScreen(townId: 2))
                  );
                },
              ),
              _buildGridButton(
                icon: Icons.ads_click_rounded,
                label: 'Payment Test',
                onTap: () {
                  StripeService.instance.makePayment();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GridTile(
      child: ElevatedButton(
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: const Color.fromRGBO(120, 153, 123, 1)),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 191, 232, 225),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
