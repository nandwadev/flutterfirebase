import 'package:flutter/material.dart';

class TextEditingWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  const TextEditingWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.obscureText,
    required this.hintText,
  }) : super(key: key);

  @override
  State<TextEditingWidget> createState() => _TextEditingWidgetState();
}

class _TextEditingWidgetState extends State<TextEditingWidget> {
  late FocusNode focusNode;

  bool isInFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {

      if(focusNode.hasFocus){
        setState(() {
          isInFocus = true;
        });
      }else{
        setState(() {
          isInFocus = false;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
             boxShadow: [
               isInFocus ?
               BoxShadow(
                color: Colors.orange.withOpacity(0.5),
                blurRadius: 8,
                spreadRadius: 2,
              ) : BoxShadow(
                 color: Colors.black.withOpacity(0.2,),
                 blurRadius: 8,
                 spreadRadius: 2,
               )
            ]
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            focusNode: focusNode,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  4,
                ),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                  width: 1,
                )
              )
            ),
          ),
        ),
      ],
    );
  }
}
