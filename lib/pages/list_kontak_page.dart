import 'package:demo_kontak_mongodb/etc/utils.dart';
import 'package:demo_kontak_mongodb/pages/detail_kontak_page.dart';
import 'package:demo_kontak_mongodb/pages/form_kontak_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListKontakPage extends StatefulWidget {
  const ListKontakPage({super.key});

  static const routeName = 'list';

  @override
  State<ListKontakPage> createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ListKontakPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        title: "Kontak",
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, FormKontakPage.routeName);
        },
        backgroundColor: Colors.green.shade600,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 24,
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, index) => _buildCardKontak(),
          ),
          onRefresh: () async {}),
    );
  }

  Widget _buildCardKontak() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailKontakPage.routeName);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const CircleAvatar(
                child: Text("DA"),
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dhimas Atha",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
