import 'package:demo_kontak_mongodb/etc/utils.dart';
import 'package:demo_kontak_mongodb/pages/form_kontak_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailKontakPage extends StatefulWidget {
  const DetailKontakPage({super.key});

  static const routeName = 'detail';

  @override
  State<DetailKontakPage> createState() => _DetailKontakPageState();
}

class _DetailKontakPageState extends State<DetailKontakPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        title: "Detail Kontak",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, FormKontakPage.routeName);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Perhatian!!",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Anda yakin akan menghapus kontak?\nKontak yang telah di hapus tidak dapat di pulihkan!",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Batal",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        "Hapus",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Colors.green.shade700,
              radius: 30,
              child: Text(
                "D",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            buildCardDetail(
              Icons.phone_android,
              "Phone Number",
              "6281234567890",
            ),
            const SizedBox(height: 10),
            buildCardDetail(
              Icons.email,
              "Email",
              "admin@google.com",
            ),
            const SizedBox(height: 10),
            buildCardDetail(
              Icons.location_city,
              "Address",
              "Jalan Mana Saja",
            ),
          ],
        ),
      ),
    );
  }

  Card buildCardDetail(IconData icon, String label, String? value) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                value ?? "-",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
