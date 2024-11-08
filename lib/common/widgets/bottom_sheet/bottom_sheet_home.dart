import 'package:flutter/material.dart';

class BottomSheetHome extends StatefulWidget {
  const BottomSheetHome({super.key});

  @override
  State<BottomSheetHome> createState() => _BottomSheetHomeState();
}

/**
 * Modal bottom sheet - disable interaction with main content behind it
 * requring user interaction e.g btn to exit
 *
 * Persistent Bottom Sheet - allows user to interact with content behind it
 * and can be dragged up or down to dismiss or reveal more content
*/
class _BottomSheetHomeState extends State<BottomSheetHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: simpleBottomSheet,
            child: const Text('simple'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _fullScreenBottomSheet,
            child: const Text('full screen'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void simpleBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Modal Bottom Sheet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Tap outside or drag down to dismiss'),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _fullScreenBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return aboutTheApp();
        });
  }

  Widget aboutTheApp() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About Info'),
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('exit'))
            ],
        ),
      ),
    );
  }
}
