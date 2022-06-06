import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;

  InputFormField(
      {required this.onSaved,
        required this.regEx,
        required this.hintText,
        required this.obscureText});
  @override
  Widget build(BuildContext context) {
    return hintText != "Type a message"
        ? TextFormField(
      onSaved: (value) => onSaved(value!),
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: hintText,
          labelStyle: const TextStyle(color: Colors.white54),
          prefixIcon: hintText == 'Email'
              ? const Icon(Icons.email, color: Colors.blue)
              : (hintText == "Password")
              ? const Icon(
            Icons.lock,
            color: Colors.blue,
          )
              : const Icon(Icons.person, color: Colors.blue),
          fillColor: const Color.fromRGBO(30, 29, 37, 1.0),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60.0),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60.0),
              borderSide: BorderSide.none),
          hintText: "Enter your " + hintText,
          hintStyle: const TextStyle(color: Colors.white54)),
      validator: (value) {
        return RegExp(regEx).hasMatch(value!)
            ? null
            : "Enter a valid $hintText";
      },
    )
        : TextFormField(
      onSaved: (value) => onSaved(value!),
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
          fillColor: const Color.fromRGBO(30, 29, 37, 1.0),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white54)),
      validator: (value) {
        return RegExp(regEx).hasMatch(value!)
            ? null
            : "Enter a valid message";
      },
    );
  }
}

class InputsearchField extends StatelessWidget {
  final Function(String) onEditingComplete;
  final String hintText;
  final bool obscurteText;
  final TextEditingController controller;
  IconData? icon;
  InputsearchField(
      {required this.onEditingComplete,
        required this.hintText,
        required this.obscurteText,
        required this.controller,
        this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: () => onEditingComplete(controller.value.text),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obscurteText,
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(20, 29, 37, 1.0),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(
          icon,
          color: Colors.white54,
        ),
      ),
    );
  }
}