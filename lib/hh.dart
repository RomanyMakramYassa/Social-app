import 'package:flutter/material.dart';

class tet extends StatelessWidget {
  const tet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: Column(
          children: [
            Icon(Icons.add),
            Container(
              height: 100,
              width: double.infinity,
              child: CircleAvatar(
                child: Icon(Icons.abc),
              ),
            ),
            Text('jhgfdsdfghjkl'),
          ],
        ),
      ),
    );
  }
}
