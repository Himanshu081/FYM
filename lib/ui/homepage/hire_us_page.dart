import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fym_test_1/widgets/styles.dart';

class HireUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset('assets/hireus.png'),

                Image.asset(
                  'assets/hireuspng.png',
                  filterQuality: FilterQuality.high,
                  width: 270,
                ),
                Transform.translate(
                  offset: Offset(85, 8),
                  child: ListTile(
                    leading: SizedBox(
                        height: 30,
                        width: 20, // fixed width and height
                        child: Image.asset(
                          'assets/check-mark.png',
                          color: Colors.green,
                        )),
                    title: new Text('24/7 Support'),
                  ),
                ),
                Transform.translate(
                  offset: Offset(85, 8),
                  child: ListTile(
                    leading: SizedBox(
                        height: 30,
                        width: 20, // fixed width and height
                        child: Image.asset(
                          'assets/check-mark.png',
                          color: Colors.green,
                        )),
                    title: new Text('Affordable Pricing'),
                  ),
                ),
                Transform.translate(
                  offset: Offset(85, 8),
                  child: ListTile(
                    leading: SizedBox(
                        height: 30,
                        width: 20, // fixed width and height
                        child: Image.asset(
                          'assets/check-mark.png',
                          color: Colors.green,
                        )),
                    title: new Text('Regular updates \nand meetings'),
                  ),
                ),
                Transform.translate(
                  offset: Offset(85, 8),
                  child: ListTile(
                    leading: SizedBox(
                        height: 30,
                        width: 20, // fixed width and height
                        child: Image.asset(
                          'assets/check-mark.png',
                          color: Colors.green,
                        )),
                    title: new Text('Instant and real-time \nemail reply'),
                  ),
                ),
                verticalSpaceRegular,
                verticalSpaceSmall,
                Text("Email us at:",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w300,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("findyourteammates2020@gmail.com",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
