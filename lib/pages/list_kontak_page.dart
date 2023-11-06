import 'package:demo_kontak_mongodb/etc/utils.dart';
import 'package:demo_kontak_mongodb/models/database.dart';
import 'package:demo_kontak_mongodb/models/kontak.dart';
import 'package:demo_kontak_mongodb/pages/detail_kontak_page.dart';
import 'package:demo_kontak_mongodb/pages/form_kontak_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ListKontakPage extends StatefulWidget {
  const ListKontakPage({super.key});

  static const routeName = 'list';

  @override
  State<ListKontakPage> createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> kontak = [];

  Future<void> _getKontak() async {
    final data = await Database().kontak?.find().toList() ?? [];
    kontak = data
        .map((e) => Kontak.fromMap(e, (e['_id'] as mongo.ObjectId).$oid))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getKontak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        title: "Kontak",
        actions: [
          IconButton(
            onPressed: () {
              _showSearchDialog(context);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result =
              await Navigator.pushNamed(context, FormKontakPage.routeName);
          if (result is Map && result['ok']) {
            _getKontak();
          }
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
          itemCount: kontak.length,
          itemBuilder: (_, index) => _buildCardKontak(kontak[index]),
        ),
        onRefresh: () async {
          _getKontak();
        },
      ),
    );
  }

  _showSearchDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Filter",
          style: GoogleFonts.poppins(
            fontSize: 24,
            color: Colors.blueGrey.shade700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: null,
              style: GoogleFonts.poppins(fontSize: 10),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green.shade600,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                hintText: "Search",
              ),
            ),
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
              "Terapkan",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardKontak(Kontak kontak) {
    return GestureDetector(
      onTap: () async {
        var result = await Navigator.pushNamed(
            context, DetailKontakPage.routeName,
            arguments: {"id": kontak.id});
        if (result is Map<String, dynamic> && result['ok']) {
          _getKontak();
        }
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
                    kontak.name ?? "",
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
