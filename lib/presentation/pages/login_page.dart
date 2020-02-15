import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  @override 
  State<StatefulWidget> createState()=> new _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;  
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
      // print('Form is Valid. Email: $_email, Password: $_password');
    }
    return false;
    // else {
    //   print('Form is inValid. Email: $_email, Password: $_password');
    // }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
       try {
         if (_formType == FormType.login){
          // final FirebaseUser users = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password));
          // print('Signed in: ${users.uid}');
         } else {
          //  FirebaseUser users = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
          //  print('Registered user: ${users.uid}');
         }
       }
       catch(e) {
        print('Error: $e');
       }
   }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState((){
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });    
  }

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState(){
    super.initState();
    _iconAnimationController = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 500)
    );
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOut
    );
    _iconAnimation.addListener(()=> this.setState((){}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.blueGrey,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget> [
          new Image(
            image: new AssetImage("assets/doctor.jpg"),
            fit: BoxFit.cover,
            color: Colors.black45,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              new FlutterLogo(
                size: 100,
                // size: _iconAnimation.value * 500,
              ),
              new Form(
                key: formKey,
                child: new Theme(
                  data: new ThemeData(
                    brightness: Brightness.dark, 
                    primarySwatch: Colors.teal,
                    inputDecorationTheme: new InputDecorationTheme(
                      labelStyle: new TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0
                      )
                    ) 
                  ),
                  child: new Container(
                    padding: const EdgeInsets.all(40.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildInput() + buildSubmitButtons(),
                    //   <Widget>[
                    // // new Padding(
                    // //   padding: const EdgeInsets.only(top: 20.0),
                    // //   ),
                    //   ], 
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
  List<Widget> buildInput(){
    return[
      new TextFormField(
        decoration: new InputDecoration(labelText: "Enter Email"),
        validator: (value) => value.isEmpty ? "Email can\'t be empty": null,
        onSaved: (value) => _email = value,
        keyboardType: TextInputType.emailAddress,
      ),
    
      new TextFormField(
        decoration: new InputDecoration(labelText: "Enter Password "),
        validator: (value) => value.isEmpty ? "Password can\'t be empty": null,
        onSaved: (value) => _password = value,
        keyboardType: TextInputType.text,
        obscureText: true,
      ),
    ];
  }

  List<Widget> buildSubmitButtons(){
    if (_formType == FormType.login){
    return[
      new RaisedButton(
        color: Colors.teal,
        textColor: Colors.white,
        child: new Text("Login"),
        onPressed: validateAndSubmit,
        splashColor: Colors.redAccent,
       // height: 40.0,
      // minWidth: 100.0,
      ),
      new FlatButton(
        color: Colors.teal,
        textColor: Colors.white,
        child: new Text("Register"),
        onPressed: moveToRegister,
        splashColor: Colors.redAccent,
        // height: 40.0,
        // minWidth: 100.0,
        ),
    ];
    } else {
      return[
      new RaisedButton(
        color: Colors.teal,
        textColor: Colors.white,
        child: new Text('Create an Account'),
        onPressed: validateAndSubmit,
        splashColor: Colors.redAccent,
       // height: 40.0,
      // minWidth: 100.0,
      ),
      new FlatButton(
        color: Colors.teal,
        textColor: Colors.white,
        child: new Text('Have an Account ? Login'),
        onPressed: moveToLogin,
        splashColor: Colors.redAccent,
        // height: 40.0,
        // minWidth: 100.0,
        ),
    ];
    }
  }
}