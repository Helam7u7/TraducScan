import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8CAC7E),
      appBar: AppBar(
        title: Text(
          "Historial",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xfffA1E783),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xfff8CAC7E),
        child: ListView(
          children: [
            ListTile(
              title: Text("Scanner"),
              onTap: () {
                Navigator.pushNamed(context, "/scan");
              },
            ),
            ListTile(
              title: Text("Traductor"),
              onTap: () {
                // Navegar a la página de traductor
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Rectángulo 1
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xfffC5D8BD),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  "Sin información",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            // Raya
            Divider(
              color: Colors.black,
            ),
            // Rectángulo 2
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xfffC5D8BD),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  "Sin información",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            // Rectángulo 2
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xfffC5D8BD),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  "Sin información",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            // Rectángulo 2
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xfffC5D8BD),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  "Sin información",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            // Rectángulo 2
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xfffC5D8BD),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  "Sin información",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
