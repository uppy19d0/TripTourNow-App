import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../models/Option.dart';

class RenderFields extends StatelessWidget {
  RenderFields({
    required this.fields,
  });

  RenderFields.withValues({
    required this.fields,
    required this.values
  });

  final List fields;
  Map<String, dynamic> values = {};

  @override
  Widget build(BuildContext context) {
    List<Widget> list = fields.map((e) {

      if (e['items'] != null) {
        final List<Option> items = e['items'];
        var value = items.isNotEmpty ? items.first.value : null;

        if(
          values.isNotEmpty &&
          values.containsKey(e['name']) &&
          values[e['name']] != null &&
          values[e['name']].toString() != ''
        ){
          value = values[e['name']];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilderDropdown(
              name: e['name'],
              initialValue: value,
              decoration: InputDecoration(
                labelText: e['label'],
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12)
              ),
              validator: e['validator'],
              onChanged: e['onChange'],
              items: items.map((Option o) {
                return DropdownMenuItem(child: Text(o.label), value: o.value);
              }).toList()
            ),

            SizedBox(height: 15)
        ]);
      } else {
        var value = values[e['name']];

        return Column(
          children: [
            FormBuilderTextField(
              name: e['name'],
              obscureText: e['obscureText'] ?? false,
              decoration: InputDecoration(
                labelText: e['label'],
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12)
              ),
              initialValue: value,
              keyboardType: e['type'] != null ? e['type'] : TextInputType.text,
              validator: e['validator'],
              onChanged: e['onChange']
            ),

            SizedBox(height: 15),
          ],
        );
      }
    }).toList();

    return  Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: list,
        ),
      ),
    );
  }
}
