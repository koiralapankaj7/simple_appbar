import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityStatus extends StatefulWidget {
  const ConnectivityStatus({
    Key key,
    this.onRefresh,
    @required this.height,
  })  : assert(height != null),
        super(key: key);
  final Function onRefresh;
  final double height;

  @override
  _ConnectivityStatusState createState() => _ConnectivityStatusState();
}

class _ConnectivityStatusState extends State<ConnectivityStatus> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        animationController.forward();
      } else {
        animationController.reverse();
        if (widget.onRefresh != null) {
          widget.onRefresh();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Container(
          height:
              lerpDouble(0.0, widget.height + MediaQuery.of(context).padding.top, animation.value),
          width: MediaQuery.of(context).size.width,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.red,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "No internet connection! Retry?",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
