import 'package:event_qr_check/models/event.dart';
import 'package:event_qr_check/utils.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';

class EventButton extends StatelessWidget {

  final Event event;
  final Color color;

  EventButton(this.event, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: this.color,
        child: InkWell(
          onTap: () {
            Router.params['event'] = this.event;
            Navigator.of(context).pushNamed('/event_checker');
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant, color: Colors.white, size: 60.0),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    this.event.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                    )
                  )
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
