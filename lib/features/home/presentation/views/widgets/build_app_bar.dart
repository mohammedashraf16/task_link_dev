import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSize buildAppBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: AppBar(
              actionsPadding: const EdgeInsets.only(left: 16),
              elevation: 3,
              backgroundColor: const Color(0xffeeeeef),
              title: Text(
                'الشركات والأفراد',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              actions: [Image.asset("assets/images/menuIcon.png")],
            ),
          ),
        ),
      );
  }

