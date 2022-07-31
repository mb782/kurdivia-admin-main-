
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ApiService.dart';


class LinkType extends StatefulWidget {
  LinkType({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'Video',
    'Image',
  ];
  String currentSelectedValue = 'Image';

  @override
  _LinkTypeState createState() => _LinkTypeState();
}

class _LinkTypeState extends State<LinkType> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                )
              ],
            borderRadius: BorderRadius.circular(15)
          ),

          width: 315,
          height: 48,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
            bottom: 10,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.black),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.black,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    // widget.onChanged!.call(widget.currentSelectedValue);
                    Provider.of<ApiService>(context, listen: false).mediaval = newValue;
                    print(Provider.of<ApiService>(context, listen: false).mediaval);
                  });
                },
                items: LinkType.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}


