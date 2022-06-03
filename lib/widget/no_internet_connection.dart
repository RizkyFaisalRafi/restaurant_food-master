import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Text(
                '404',
                style: GoogleFonts.aclonica(
                    fontSize: 48,
                    color: Colors.black,
                    fontWeight: FontWeight.w800)
            ),
            Text(
                'Tidak ada Koneksi Internet',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400)
            )
          ],
        )
    );
  }
}
