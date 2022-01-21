import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar({this.photoUrl, @required this.radius});
  final String photoUrl;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.black87,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
      child: photoUrl == null
          ? Icon(
              Icons.camera_alt,
              size: radius,
            )
          : null,
    );
  }
}
