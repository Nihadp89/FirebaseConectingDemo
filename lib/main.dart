import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey:
              'BFdP6-tsOUdQjAVlKHVXhHAdYAtrv1BIwXlM_fI_0Z9g99n-vQ2O88M3Wm7NIfKAFp-w4P7jP9aSC99-VSzVb94',
          appId: '1:810112704542:android:7ed7b04a91f5ceb4948e0f',
          messagingSenderId: '810112704542',
          projectId: 'flutterfirebasedemo-ecb1f',
          authDomain: 'flutterfirebasedemo-ecb1f.firebaseapp.com',
          databaseURL:
              'https://flutterfirebasedemo-ecb1f-default-rtdb.firebaseio.com/',
          storageBucket: 'flutterfirebasedemo-ecb1f.appspot.com'));

  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
home:MyAppfront(),
    );
  }
  
}
class MyAppfront extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppBack();
  }
}



class MyAppBack extends State<MyAppfront> {
  var i = 0;
  var message = List<String>.filled(50, '');
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Display'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your message:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              onSubmitted: (value) {
                setState(() {
                  message[i] = value;
                  i++;
                  _controller.clear();
                  sendMessage(value);
                  f(value);
                });
              },
              decoration: InputDecoration(
                hintText: 'Type your message here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            /*
            Expanded(
                child: ListView.builder(
                    itemCount: message.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(message[index]),
                        onTap: () {
                          print('Tapped on ${message[index]}');
                        },
                      );
                    }))*/
          ],
        ),
      ),
    );
  }

  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child('just');
  void sendMessage(String message) {
    _database.push().set({
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  f(postId) {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('just');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });
  }
}
