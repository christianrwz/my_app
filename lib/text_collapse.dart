import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextCollapse extends StatefulWidget {
  const TextCollapse({super.key});

  @override
  State<TextCollapse> createState() => _TextCollapseState();
}

class _TextCollapseState extends State<TextCollapse> {
  bool showingMore = false;
  late TapGestureRecognizer readMoreGestureRecognizer;
  final String _text =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut laborer. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut laborer. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut laborer. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut laborer.";

  @override
  void initState() {
    super.initState();
    readMoreGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showingMore = !showingMore;
        });
      };
  }

  @override
  void dispose() {
    readMoreGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int maxLength = 250; // max length for truncated text

    // Don't show "Read more" if the text is exactly 100 characters
    if (_text.length == maxLength) {
      return SafeArea(
        child: Text(
          _text,
          style: TextStyle(color: Colors.black), // Style as you want
        ),
      );
    }

    String displayedText = _text;
    String readMoreText = " Read more";

    // If the text is longer than maxLength, truncate it and show "Read more"
    if (!showingMore && _text.length > maxLength) {
      displayedText = "${_text.substring(0, maxLength)}...";
      readMoreText = " Read more";
    } else if (showingMore) {
      // If showing more, display the full text
      readMoreText = " Read less";
    }

    return SafeArea(
      child: RichText(
        strutStyle: StrutStyle(fontSize: 18.0),
        text: TextSpan(
          children: [
            TextSpan(
              text: displayedText,
              style: TextStyle(color: Colors.black), // Add text style if needed
            ),
            if (_text.length >
                maxLength) // Only show if text is longer than maxLength
              TextSpan(
                recognizer: readMoreGestureRecognizer,
                text: readMoreText,
                style: TextStyle(color: Colors.blue), // Style for the link
              ),
          ],
        ),
      ),
    );
  }
}
