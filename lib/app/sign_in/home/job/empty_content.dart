import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  EmptyContent(
      {this.title = 'Nothing here',
      this.message = 'Add an item to get started'});

  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 18, color: Colors.black),
          )
        ],
      ),
    );
  }
}
