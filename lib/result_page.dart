import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String text;

  const ResultPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8CAC7E),
      appBar: AppBar(
        backgroundColor: Color(0xfffA1E783),
        leading: BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Resultado",
          style: TextStyle(color: Colors.black),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xfff8CAC7E),
        child: ListView(
          children: [
            ListTile(
              title: Text("Historial"),
              onTap: () {
                Navigator.pushNamed(context, "/history");
              },
            ),
            ListTile(
              title: Text("Scanner"),
              onTap: () {
                Navigator.pushNamed(context, "/scan");
              },
            ),
            ListTile(
              title: Text("Cerrar sesión"),
              onTap: () {
                Navigator.pushNamed(context, "/");
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xfffC5D8BD),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(20.0),
              child: Text(text),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Inglés",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfffA1E783),
                  ),
                ),
                Icon(
                  Icons.arrow_right_alt,
                  color: Colors.black,
                  size: 30.0,
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Español",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfffA1E783),
                  ),
                ),
              ],
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xfffC5D8BD),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(20.0),
              child: Text("Traduciendo texto..."),
            ),
          ],
        ),
      ),
    );
  }
}
