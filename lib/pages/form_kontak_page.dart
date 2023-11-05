import 'package:demo_kontak_mongodb/etc/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormKontakPage extends StatefulWidget {
  const FormKontakPage({super.key});

  static const routeName = 'form';

  @override
  State<FormKontakPage> createState() => _FormKontakPageState();
}

class _FormKontakPageState extends State<FormKontakPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(title: "Form Kontak"),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextField(
                hint: "Name",
              ),
              const SizedBox(height: 5),
              buildTextField(
                hint: "Phone Number",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 5),
              buildTextField(
                hint: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 5),
              buildTextField(
                hint: "Address",
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
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
