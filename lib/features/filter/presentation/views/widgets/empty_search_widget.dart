import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptySearchWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const EmptySearchWidget({required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/notfound.png'),
          SizedBox(height: 12),
          Text("عذرًا، لم نعثر على نتائج!", style: GoogleFonts.cairo(),),
          Text("من فضلك حاول مجددًا باستخدام جمل بحث أخري", style: GoogleFonts.cairo(),),
          SizedBox(height: 12),
          ElevatedButton(onPressed: onRetry, child: Text('البحث مجدداً',style: GoogleFonts.cairo(),)),
        ],
      ),
    );
  }
}
