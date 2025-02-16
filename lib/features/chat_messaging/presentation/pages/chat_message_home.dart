// import 'package:bloc_clean_arch/features/chat_messaging/domain/entity/chat_message.dart';
// import 'package:bloc_clean_arch/features/chat_messaging/presentation/widgets/chat_message_bubble.dart';
// import 'package:bloc_clean_arch/features/chat_messaging/presentation/widgets/chat_message_input_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class ChatMessageHomePage extends StatefulWidget {
//   const ChatMessageHomePage({super.key});

//   @override
//   State<ChatMessageHomePage> createState() => _ChatMessagePageState();
// }

// class _ChatMessagePageState extends State<ChatMessageHomePage> {
//   final List<ChatMessage> messages = [
//     ChatMessage(
//       message:
//           "Some othr message this one is quite a long message for test purposes and information management chekcs",
//       isUser: false,
//       timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//       status: MessageStatus.delivered,
//     ),
//     ChatMessage(
//       message: "Hey! How are you?",
//       isUser: false,
//       timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//       status: MessageStatus.read,
//     ),
//     ChatMessage(
//       message: "This is a reply",
//       isUser: true,
//       timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//       status: MessageStatus.read,
//     ),
//      ChatMessage(
//       message: "This is a reply2",
//       isUser: true,
//       timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//       status: MessageStatus.read,
//     ),
//     ChatMessage(
//       message: "Some othr message this one is quite a long message for test purposes and information management chekcs",
//       isUser: false,
//       timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//       status: MessageStatus.delivered,
//     ),
//     ChatMessage(
//       message: "I'm good, thanks! Check out this photo.",
//       isUser: true,
//       timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
//       type: MessageType.image,
//       mediaUrl: "https://images.unsplash.com/photo-1738332465678-597284760298?q=80&w=1036&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//       status: MessageStatus.delivered,
//     ),
//     ChatMessage(
//       message: "Voice message",
//       isUser: false,
//       timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
//       type: MessageType.audio,
//     ),
//     ChatMessage(
//       message: "I'm good, thanks! Check out this photo.",
//       isUser: false,
//       timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
//       type: MessageType.image,
//       mediaUrl:
//           "https://plus.unsplash.com/premium_photo-1734549547929-9219737132db?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//       status: MessageStatus.delivered,
//     ),
//     ChatMessage(
//       message: "I'm good, thanks! Check out this photo.",
//       isUser: false,
//       timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
//       type: MessageType.image,
//       mediaUrl:
//           "https://images.unsplash.com/photo-1738898178964-88696087d43b?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//       status: MessageStatus.delivered,
//     ),
//   ];


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           leadingWidth: 70,
//           leading: InkWell(
//             onTap: () => Navigator.pop(context),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.arrow_back, size: 24),
//                 // CircleAvatar(
//                 //   radius: 20,
//                 //   backgroundColor: Colors.blueGrey,
//                 //   child: const Icon(Icons.person_2_outlined, size: 24, color: Colors.white,),
//                 // ),
//                 CircleAvatar(
//                   backgroundColor: Colors.blueGrey,
//                   radius: 20,
//                   child: SvgPicture.asset(
//                     'icons/person_w.svg',
//                     height: 36,
//                     width: 36,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           title: const InkWell(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Paul Wara',
//                     style:
//                         TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold)),
//                 Text('online', style: TextStyle(fontSize: 13)),
//               ],
//             ),
//           ),
//           actions: [
//             IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
//             IconButton(onPressed: () {}, icon: Icon(Icons.call)),
//             MenuAnchor(
//               style: const MenuStyle(
//                 padding:
//                     WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(16.0)),
//                 backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
//                 shadowColor: WidgetStatePropertyAll<Color>(Colors.black),
//                 elevation: WidgetStatePropertyAll<double>(8.0),
//               ),
//               alignmentOffset: const Offset(50,
//                   8), // Moves menu 50 pixels right, // Moves menu 8 pixels down
//               builder: (context, controller, child) {
//                 return IconButton(
//                   onPressed: () => controller.isOpen
//                       ? controller.close()
//                       : controller.open(),
//                   icon: const Icon(Icons.more_vert),
//                 );
//               },
//               menuChildren: [
//                 MenuItemButton(
//                   onPressed: () {
//                     debugPrint('Settings pressed');
//                   },
//                   child: const Text('Settings'),
//                 ),
//                 MenuItemButton(
//                   onPressed: () {
//                     debugPrint('Profile pressed');
//                   },
//                   child: const Text('Profile'),
//                 ),
//                 MenuItemButton(
//                   onPressed: () {
//                     debugPrint('Logout pressed');
//                   },
//                   child: const Text('Logout'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 return ChatMessageBubble(
//                   message: messages[index],
//                   // Show avatar only if the previous message was from a different sender
//                   showAvatar: index == 0 ||
//                       messages[index].isUser != messages[index - 1].isUser,
//                 );
//               },
//             ),
//             ),
//             ChatMessageInputBar(),
//           ],
//         ),
//       ),
//         );
//   }
// }
