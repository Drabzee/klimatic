import 'package:flutter/material.dart';

class SearchCity extends StatelessWidget {

  final controller = TextEditingController();

  void onSubmit(BuildContext context) {
    if(controller.text.length != 0)
      Navigator.pop(context, controller.text);
  }

  Widget getFormLayout(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder()
          ),
          onSubmitted: (String str) {onSubmit(context);},
        ),
        SizedBox(height: 20.0),
        RaisedButton(
          child: Text('Get Weather'),
          color: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            onSubmit(context);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Klimatic'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: getFormLayout(context),
      )
    );
  }
}