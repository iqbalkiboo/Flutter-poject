// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:sampleproject/presentation/pages/employee.dart';
import 'package:flutter/material.dart';
// import 'package:sampleproject/presentation/pages/home.dart';
import 'package:sampleproject/presentation/pages/providers/employee_provider.dart';
// import 'package:sampleproject/presentation/pages/login_page.dart';

//flutter-project-2c97a <-- id firebase

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[ 
        ChangeNotifierProvider(
        create: (_) => EmployeeProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
          theme: ThemeData(
          primarySwatch: Colors.teal,
          ),
        home: Employee(),
      ),
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.teal,
      // ),
      
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // final Firestore firestore = Firestore.instance;
//   void _create() async {
//     try{
//       await firestore.collection("users").document("testUsers").setData({
//         'firstName' : 'user',
//         'lastName' : 'pict',
//       });
//     }catch(e){
//       print(e);
//     }
//   }

//   void _read() async{
//     DocumentSnapshot documentSnapshot;
//     try{
//       documentSnapshot = await firestore.collection('users').document('testUsers').get();
//       print(documentSnapshot.data);
//     }catch(e){
//       print(e);
//     }
//   }

//   void _update() async{
//     try{
//       firestore.collection('users').document('testUsers').updateData({
//        'firstName' : 'test',
//       });
//     }catch(e){
//       print(e);
//     }
//   }

//   void _delete() async{
//     try{
//       firestore.collection('users').document('testUsers').delete();
//     }catch(e){
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("flutter project"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment : MainAxisAlignment.center,
//           children: <Widget> [
//             RaisedButton(
//               child: Text("Create"),
//               onPressed: _create,
//             ),
//             RaisedButton(
//               child: Text("Read"),
//               onPressed: _read,
//             ),
//             RaisedButton(
//               child: Text("Update"),
//               onPressed: _update,
//             ),
//             RaisedButton(
//               child: Text("Delete"),
//               onPressed: _delete,
//             ),
//           ]
//         ),
//       ),
//     );
//   }
// }