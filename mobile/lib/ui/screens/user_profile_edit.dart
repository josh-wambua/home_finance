import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homefinance/models/user.dart';
import 'package:homefinance/services/database_service.dart';
import 'package:homefinance/services/theme_service.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _profileImageUrl = '';


  @override
  void initState() {
    super.initState();
    _firstName = widget.user.firstName;
    _lastName = widget.user.lastName;
    _profileImageUrl = widget.user.imageURL;
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //Update db user
      User user = User(userId: widget.user.userId, firstName: _firstName, lastName: _lastName, imageURL: _profileImageUrl);
      DatabaseService.updateUser(user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Edit Profile',),
        actions: <Widget>[
          FlatButton(
            onPressed: () { _submit(); },
            child: Icon(Icons.save, color: Colors.blue,),
          )
        ],
      ),
      body: makeBody(context),
    );
  }

  Widget makeBody(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Form(key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                       backgroundColor: Colors.grey,
                        backgroundImage:
                            _profileImageUrl.isEmpty 
                            ? AssetImage('assets/images/user-placeholder.jpg')
                            : CachedNetworkImageProvider(_profileImageUrl)
                            , 
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text('Change Profile Picture', style: TextStyle(fontSize: 16, color: Theme.of(context).accentColor),),
                    ),
                    TextFormField(
                      autocorrect: false,
                      initialValue: _firstName,
                      style: TextStyle(fontSize: 18),
                      decoration:InputDecoration(
                        icon: Icon(Icons.person, size: 30),
                        labelText: 'First Name'
                      ) ,
                      onSaved: (input) => _firstName = input,
                      validator: (input) => input.trim().length < 1 ? 'Please enter a valid first name' : null,
                    ),
                    TextFormField(
                      autocorrect: false,
                      initialValue: _lastName,
                      style: TextStyle(fontSize: 18),
                      decoration:InputDecoration(
                        icon: Icon(Icons.person, size: 30),
                        labelText: 'Last Name'
                      ) ,
                      onSaved: (input) => _lastName = input,
                      validator: (input) => input.trim().length < 1 ? 'Please enter a valid last name' : null,
                    ),
                    Container(
                      margin: EdgeInsets.all(40),
                      child: FlatButton(
                        onPressed: _submit ,
                        textColor: Colors.white,
                        color: primaryColor,
                        child: Text('Save Profile', style: TextStyle(fontSize: 18),),
                      ),
                    ) 
                  ],
                ),
            ),
          ),
        ),
    );
  }
}