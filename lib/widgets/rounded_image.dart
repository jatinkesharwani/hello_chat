import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String imgpath;
  final double size;
  const RoundedImage(
      {required Key key, required this.imgpath, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imgpath),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(size),
          ),
          color: Colors.black),
    );
  }
}

class RoundedImageFile extends StatelessWidget {
  final PlatformFile imageu;
  final double size;

  RoundedImageFile({
    required Key key,
    required this.imageu,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File mg = File(imageu.path!);
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(mg),
        ),
        borderRadius: BorderRadius.all(Radius.circular(size)),
        color: Colors.black,
      ),
    );
  }
}

class RoundedImagestatus extends RoundedImage {
  final bool isActive;
  const RoundedImagestatus(
      {required Key key,
        required String imgpath,
        required double size,
        required this.isActive})
      : super(key: key, imgpath: imgpath, size: size);
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        super.build(context),
        Container(
          height: size * 0.2,
          width: size * 0.2,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
      ],
    );
  }
}