import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simpleappbar/src/connectivity_status.dart';

const double _CONNECTIVITY_LISTENER_WIDGET_SIZE = 16.0;

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final Widget leading;
  final Widget title;
  final List<Widget> actions;
  final Brightness brightness;
  final bool hide;
  final double leadingSpace;
  final double trailingSpace;
  final Function onRefresh;

  const SimpleAppBar({
    Key key,
    @required this.context,
    this.leading,
    this.title,
    this.actions = const <Widget>[],
    this.brightness,
    this.hide = false,
    this.trailingSpace,
    this.leadingSpace,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: this.brightness,
        statusBarIconBrightness: this.brightness,
        statusBarColor: Colors.transparent,
      ),
      child: this.hide
          ? SizedBox()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Appbar
                Container(
                  height: MediaQuery.of(context).padding.top + kToolbarHeight,
                  padding: EdgeInsets.only(top: statusBarHeight),
                  color: Colors.blue,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      //

                      // Title
                      this.title ?? SizedBox(),

                      // Icons
                      Row(
                        children: <Widget>[
                          //
                          // Margin
                          SizedBox(width: this.leadingSpace ?? 5.0),

                          // Leading icon
                          leading ?? Icon(Icons.menu),

                          // Center area
                          this.title == null ? SizedBox() : Expanded(child: Container()),

                          // Action
                          ...this.actions.map(
                                (Widget widget) => Container(
                                  margin: EdgeInsets.only(left: 2.0),
                                  child: widget,
                                  // height: kApp,
                                ),
                              ),

                          // Margin
                          SizedBox(width: this.trailingSpace ?? 5.0),

                          //
                          //
                        ],
                      ),

                      //
                    ],
                  ),
                ),

                // Status listener
                ConnectivityStatus(
                  onRefresh: onRefresh,
                  height: _CONNECTIVITY_LISTENER_WIDGET_SIZE,
                ),

                //
              ],
            ),
    );
  }

  // AppBar().preferredSize.height is 56.0.
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight +
      _CONNECTIVITY_LISTENER_WIDGET_SIZE +
      MediaQuery.of(this.context).padding.top);

  //
}
