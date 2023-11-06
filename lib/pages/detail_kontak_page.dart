import 'dart:developer';

import 'package:demo_kontak_mongodb/etc/utils.dart';
import 'package:demo_kontak_mongodb/models/database.dart';
import 'package:demo_kontak_mongodb/models/kontak.dart';
import 'package:demo_kontak_mongodb/pages/form_kontak_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class DetailKontakPage extends StatefulWidget {
  const DetailKontakPage({super.key});

  static const routeName = 'detail';

  @override
  State<DetailKontakPage> createState() => _DetailKontakPageState();
}

class _DetailKontakPageState extends State<DetailKontakPage> {
  Kontak? kontak;
  bool isLoading = false;
  bool isLoaded = false;
  String? message;

  Future<void> loadKontak(String id) async {
    if (isLoaded) return;
    setState(() {
      isLoading = true;
    });

    final data = await Database()
        .kontak
        ?.findOne(mongo.where.id(mongo.ObjectId.fromHexString(id)));

    if (data != null) {
      setState(() {
        kontak = Kontak.fromMap(data, id);
      });
    }

    isLoaded = true;
  }

  Future<void> hapusData() async {
    setState(() {
      isLoading = true;
    });

    final deleted = await Database().kontak?.deleteOne(
        mongo.where.id(mongo.ObjectId.fromHexString(kontak?.id ?? "")));

    log(deleted.toString());

    if (deleted?.isSuccess == true) {
      Navigator.pop(context, {"ok": true});
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    if (args.containsKey("id")) {
      loadKontak(args["id"].toString());
    }
    return Scaffold(
      appBar: defaultAppBar(
        title: kontak?.name ?? "",
        actions: [
          IconButton(
            onPressed: () async {
              var data = await Navigator.pushNamed(
                  context, FormKontakPage.routeName,
                  arguments: {"id": kontak?.id});

              if (data is Map<String, dynamic> && data['ok']) {
                isLoaded = false;
                loadKontak(kontak?.id ?? "");
              }
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
                      onPressed: () {
                        Navigator.pop(context);
                        hapusData();
                      },
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
              kontak?.phoneNumber ?? "-",
            ),
            const SizedBox(height: 10),
            buildCardDetail(
              Icons.email,
              "Email",
              kontak?.email ?? "-",
            ),
            const SizedBox(height: 10),
            buildCardDetail(
              Icons.location_city,
              "Address",
              kontak?.address ?? "-",
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
