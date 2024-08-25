import 'package:beauty_salon/services/stripe_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appointment_screen.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   APIs.getSelfInfo();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(246, 247, 249, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(246, 247, 249, 1),
          leading: Image.asset('assets/images/logo-1.png'),
          title: Text('RinZin Divine Beauty'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              icon: Icon(Icons.person),
            ),
            SizedBox(width: 5)
          ],
        ),
        body: Center(
          child: GridView.count(
            crossAxisCount: 2,
            // 2 buttons per row
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            padding: EdgeInsets.all(20.0),
            children: [
              // First button
              GridTile(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CategoryScreen()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ads_click_rounded,
                        size: 50,
                        color: Color.fromRGBO(120, 153, 123, 1),
                      ),
                      SizedBox(height: 8),
                      // Adds some space between the icon and text
                      Text(
                        'MINTO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 191, 232, 225),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),

              // Second button
              GridTile(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppointmentScreen()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ads_click_rounded,
                        size: 50,
                        color: Color.fromRGBO(120, 153, 123, 1),
                      ),
                      SizedBox(height: 8),
                      // Adds some space between the icon and text
                      Text(
                        'CAMPBELLTOWN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 191, 232, 225),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),
              GridTile(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const AppointmentScreen()),
                    // );
                    StripeService.instance.makePayment();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ads_click_rounded,
                        size: 50,
                        color: Color.fromRGBO(120, 153, 123, 1),
                      ),
                      SizedBox(height: 8),
                      // Adds some space between the icon and text
                      Text(
                        'Payment test',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 191, 232, 225),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
