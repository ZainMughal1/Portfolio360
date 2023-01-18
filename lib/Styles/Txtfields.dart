import 'package:flutter/material.dart';

import 'Colors.dart';


InputDecoration txtfield1(String hint,String label,BuildContext context){
  return InputDecoration(

    alignLabelWithHint: true,
      hintText: hint,
      label: Text(label),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              width: 2
          )
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          )
      ),
      isDense: true
  );
}

InputDecoration txtfield2(String hint,String lable,BuildContext context){
  return InputDecoration(
    border: InputBorder.none,
    hintText: hint,
    filled: true,
    fillColor: Theme.of(context).colorScheme.primaryContainer,
    hintStyle: Theme.of(context).primaryTextTheme.bodyText1,
    prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryTextTheme.bodyText1!.color,),

  );
}
TextFormField txtfield3(String hint,String label){
  return TextFormField(
    minLines: 4,
    maxLines: 6,
    decoration: InputDecoration(
      alignLabelWithHint: true,
        hintText: hint,
        label: Text(label),
        labelStyle: TextStyle(
            color: c1
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: c1,
                width: 2
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: c1,

            )
        ),
      isDense: true,
    ),
  );
}

InputDecoration txtfield4(String hint,String label,onAdd,BuildContext context){
  return InputDecoration(
    suffixIcon: TextButton(
      onPressed: onAdd,
      child: Text("Add",style: TextStyle(
          color: Theme.of(context).colorScheme.secondary
      ),),
    ),
    alignLabelWithHint: true,
    hintText: hint,
    label: Text(label),
    labelStyle: TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: 17,
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            width: 2
        )
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onPrimaryContainer,

        )
    ),
    isDense: true,
  );
}