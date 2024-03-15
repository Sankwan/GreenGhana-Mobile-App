import 'dart:async';
import 'package:flutter/material.dart';

class TimeoutWidget extends StatefulWidget {
  final String? message;
  final Function()? callBack;

  const TimeoutWidget({super.key, this.message, this.callBack});

  @override
  _TimeoutWidgetState createState() => _TimeoutWidgetState();
}

class _TimeoutWidgetState extends State<TimeoutWidget> {
  late Timer _timer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer(Duration(seconds: 30), () {
      // Show dialog after one minute
      _isLoading = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(widget.message ?? ''),
            // content: Text("Try Again."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if(widget.callBack != null) widget.callBack!();
                  Navigator.pop(context);
                },
                child: Text("Try Again"),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
      // widget.message?.isEmpty ?? true
           CircularProgressIndicator() // Loader
          // : Center(
          //   child: Padding(
          //     padding: const EdgeInsets.all(12),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Text(widget.message ?? "Loading"),
          //         SizedBox(height: 20,),
          //         ElevatedButton(onPressed: widget.callBack, child: Text("Try Again"))
          //       ],
          //     ),
          //   ),
          // ), // Empty container
    );
  }
}
