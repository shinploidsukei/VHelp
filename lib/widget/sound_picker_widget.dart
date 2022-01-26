import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


class SoundPickerWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return DropdownButton(
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      //style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? newValue) {

      },
      items: ['🔊', '🔇']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          onTap: (){
          
          },
        );
      }).toList(),
    );
  }
}