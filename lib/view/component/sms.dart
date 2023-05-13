import 'package:flutter/material.dart';

class CardExample extends StatelessWidget {
  final int index;
  const CardExample(this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        leading: ExcludeSemantics(
          child: CircleAvatar(child: Icon(Icons.favorite)),
        ),
        title: Text("Người gửi N"),
        subtitle: Text("Nội dung"),
        onTap: handleTapping,
      ),
    );
  }

  void handleTapping() => print(index);
}
