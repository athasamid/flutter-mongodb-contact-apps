import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar defaultAppBar({
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      backgroundColor: Colors.green.shade500,
      title: title != null
          ? Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: Colors.white,
              ),
            )
          : null,
      actions: actions,
    );
