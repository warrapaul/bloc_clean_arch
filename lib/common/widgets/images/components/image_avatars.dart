import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 -- sample user profile
 Column(
    children: <Widget>[
      CircleAvatar(
        radius: 50, 
        backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
        backgroundColor: Colors.grey.shade200, 
        child: imageUrl.isEmpty ? Text(userInitials) : null,
      ),
      SizedBox(height: 8), 
      Text(
        userName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
     
    ],
  );
 */
class ImageAvatars extends StatelessWidget {
  const ImageAvatars({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1577975819014-2d6f1e721e77?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
        ),
        const SizedBox(
          width: 10
        ),
        const CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 30,
          child: Text(
            'PW',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        const CircleAvatar(
          backgroundImage: NetworkImage("https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
          radius: 40,
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 40,
          child: ClipOval(
            child: Image.network(
              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              width: 240,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          
        ),
      ],
    );
  }
}
