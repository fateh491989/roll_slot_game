
import 'package:flutter/material.dart';

class ListViewByFateh extends StatefulWidget {
  ListViewByFateh({@required this.list,@required this.scrollController, this.height, this.width});
  final TrackingScrollController scrollController;
  final List list;
  final double height;
  final double width;
  @override
  _ListViewByFatehState createState() => _ListViewByFatehState();
}

class _ListViewByFatehState extends State<ListViewByFateh> {
  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        padding: EdgeInsets.all(0.0),
        controller: widget.scrollController,
        itemCount: widget.list.length,
        itemBuilder: (context,index){
          return Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(child: Text(widget.list[index])));
        },
      );
  }
}