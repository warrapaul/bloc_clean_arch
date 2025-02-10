import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class ChatMessageInputBar extends StatefulWidget {
  const ChatMessageInputBar({super.key});

  @override
  State<ChatMessageInputBar> createState() => _ChatMessageInputBarState();
}

class _ChatMessageInputBarState extends State<ChatMessageInputBar> {
  bool _showEmojiPicker = false;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showEmojiPicker = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });

    if (_showEmojiPicker) {
      // Hide the keyboard when emoji picker is shown
      _focusNode.unfocus();
      _focusNode.canRequestFocus = false;
    } else {
      // Show the keyboard when emoji picker is hidden
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(6, 0, 2, 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _controller,
                              focusNode: _focusNode,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                  hintText: "Type something here",
                                  border: InputBorder.none,
                                  // contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                  prefixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: _toggleEmojiPicker,
                                    icon: const Icon(
                                        Icons.emoji_emotions_outlined),
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: _showAttachmentOptions,
                                        icon: const Icon(Icons.attach_file),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.camera_alt_outlined),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                Padding(
                  padding: const EdgeInsets.only(right: 6, bottom: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 28, // Reduced from 40 for better proportions
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Offstage(
              offstage: !_showEmojiPicker,
              child: EmojiPicker(
                textEditingController: _controller,
                // onEmojiSelected: (category, emoji) => {
                //   _controller.text += emoji.emoji
                // },
                config: Config(),
              ),
            )
          ],
        ),
      ),
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (_showEmojiPicker) {
          // Hide the emoji picker if it's visible
          setState(() {
            _showEmojiPicker = false;
          });
        } else if (_focusNode.hasFocus) {
          // Hide the keyboard if it's visible
          _focusNode.unfocus();
        } else {
          // Allow the back button to close the app or navigate back
          return;
        }
      },
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
                      height:
                MediaQuery.of(context).size.height * 0.35, 
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: [
                _buildAttachmentOption(
                  'Document',
                  Icons.document_scanner,
                  Colors.purple,
                  () {
                    // Handle document selection
                    Navigator.pop(context);
                  },
                ),
                _buildAttachmentOption(
                  'Audio',
                  Icons.audio_file,
                  Colors.orange,
                  () {
                    // Handle audio selection
                    Navigator.pop(context);
                  },
                ),
                _buildAttachmentOption(
                  'Gallery',
                  Icons.photo_library,
                  Colors.pink,
                  () {
                    // Handle gallery selection
                    Navigator.pop(context);
                  },
                ),
                _buildAttachmentOption(
                  'Camera',
                  Icons.camera_alt,
                  Colors.green,
                  () {
                    // Handle camera selection
                    Navigator.pop(context);
                  },
                ),
                _buildAttachmentOption(
                  'Location',
                  Icons.location_on,
                  Colors.blue,
                  () {
                    // Handle location selection
                    Navigator.pop(context);
                  },
                ),
                _buildAttachmentOption(
                  'Contact',
                  Icons.contact_page,
                  Colors.red,
                  () {
                    // Handle contact selection
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _buildAttachmentOption(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
