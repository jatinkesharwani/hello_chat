import 'package:flutter/material.dart';
import 'package:hello_chat/widgets/rounded_image.dart';

class Topbar extends StatelessWidget {
  String barTitle;
  Widget? primaryAction;
  Widget? secondaryAction;
  double? fontSize;
  late double lheight;
  late double lwidth;

  Topbar(this.barTitle,
      {this.primaryAction, this.secondaryAction, this.fontSize = 35});

  @override
  Widget build(BuildContext context) {
    lheight = MediaQuery.of(context).size.height;
    lwidth = MediaQuery.of(context).size.width;

    return Container(
      height: lheight * 0.10,
      width: lwidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (secondaryAction != null) secondaryAction!,
          titlebar(),
          if (primaryAction != null) primaryAction!,
        ],
      ),
    );
  }

  Widget titlebar() {
    return Text(
      barTitle,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w700),
    );
  }
}

class Topbarforachat extends StatelessWidget {
  String barTitle;
  String imgurl;
  Widget? primaryAction;
  Widget? secondaryAction;
  double? fontSize;
  late double lheight;
  late double lwidth;

  Topbarforachat(this.barTitle, this.imgurl,
      {this.primaryAction, this.secondaryAction, this.fontSize = 35});

  @override
  Widget build(BuildContext context) {
    lheight = MediaQuery.of(context).size.height;
    lwidth = MediaQuery.of(context).size.width;

    return Container(
      height: lheight * 0.10,
      width: lwidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (secondaryAction != null) secondaryAction!,
          RoundedImage(
              key: UniqueKey(), imgpath: imgurl, size: lheight * 0.1 / 2),
          titlebar(),
          if (primaryAction != null) primaryAction!,
        ],
      ),
    );
  }

  Widget titlebar() {
    return Expanded(
      child: Text(
        barTitle,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}