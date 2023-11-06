import 'package:demo_kontak_mongodb/etc/utils.dart';
import 'package:demo_kontak_mongodb/models/database.dart';
import 'package:demo_kontak_mongodb/models/kontak.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class FormKontakPage extends StatefulWidget {
  const FormKontakPage({super.key});

  static const routeName = 'form';

  @override
  State<FormKontakPage> createState() => _FormKontakPageState();
}

class _FormKontakPageState extends State<FormKontakPage> {
  final _controllerName = TextEditingController();
  final _controllerPhoneNumber = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerAddress = TextEditingController();

  var isLoading = false;
  var isLoaded = false;

  String? id;

  Future simpanKontak() async {
    isLoading = true;
    setState(() {});
    final kontak = Kontak(
      name: _controllerName.text.toString(),
      phoneNumber: _controllerPhoneNumber.text.toString(),
      email: _controllerEmail.text.toString(),
      address: _controllerAddress.text.toString(),
    );

    var query = Database().kontak;

    var data;
    if (id != null) {
      data = query?.update(
          mongo.where.id(mongo.ObjectId.fromHexString(id ?? "")),
          kontak.toUpdateData(),
          writeConcern:
              const mongo.WriteConcern(w: 'majority', wtimeout: 5000));
    } else {
      data = query?.insert(kontak.toMap());
    }

    isLoading = false;
    setState(() {});

    if (data != null) {
      Navigator.pop(context, {'ok': true});
    }
  }

  Future<void> loadKontak(String id) async {
    if (isLoaded) return;
    this.id = id;
    setState(() {
      isLoading = true;
    });

    final data = await Database()
        .kontak
        ?.findOne(mongo.where.id(mongo.ObjectId.fromHexString(id)));

    if (data != null) {
      setState(() {
        _controllerName.text = data['name'] ?? "";
        _controllerAddress.text = data['address'] ?? "";
        _controllerEmail.text = data['email'] ?? "";
        _controllerPhoneNumber.text = data['phoneNumber'] ?? "";
      });
    }

    isLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    try {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      if (args.containsKey("id")) {
        loadKontak(args['id']);
      }
    } catch (e) {}

    return Scaffold(
      appBar: defaultAppBar(title: "Form Kontak"),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextField(
                controller: _controllerName,
                hint: "Name",
              ),
              const SizedBox(height: 5),
              buildTextField(
                controller: _controllerPhoneNumber,
                hint: "Phone Number",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 5),
              buildTextField(
                controller: _controllerEmail,
                hint: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 5),
              buildTextField(
                controller: _controllerAddress,
                hint: "Address",
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  simpanKontak();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  "Simpan",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTextField({
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    String? hint,
    int? maxLines,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 10),
      keyboardType: keyboardType,
      maxLines: maxLines,
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
        hintText: hint,
      ),
    );
  }
}
