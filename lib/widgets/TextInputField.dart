import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    this.controller,
    this.labelText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
    this.isObscure = false,
    this.readOnly = false,
    this.onChanged,
    this.width,
    this.height,
    this.hintText,
    this.onPressed,
    this.suffixIcon,
    this.ontap,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final IconData? icon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(dynamic value)? validator;
  final bool isObscure;
  final bool readOnly;
  final Icon? suffixIcon;
  final ValueChanged<String>? onChanged;
  final Function? onPressed;
  final void  Function()? ontap;
  final double? width;
  final double? height;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center, // Center align the container
      padding: EdgeInsets.only(top: 10,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: TextFormField(
              textAlign: TextAlign.justify,
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              validator: validator,
              onChanged: onChanged,
              onTap: ontap,
              obscureText: isObscure,
              readOnly: readOnly,
              style: GoogleFonts.exo2(
                fontSize: 15,
                color: Colors.black,),
              decoration: InputDecoration(
                errorStyle:  GoogleFonts.exo2(height: 1, color: Colors.black),
                labelText: labelText,
                hintText: hintText,
                suffixIcon: Icon(icon, color: Colors.black),
                labelStyle:  GoogleFonts.exo2(
                  fontSize: 15,
                  color: Colors.black87,
                ),
                hintStyle: GoogleFonts.exo2(
                  fontSize: 15,
                  color: Colors.black87,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Colors.red.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide:  BorderSide(
                    width: 1.5,
                    color: Colors.brown.shade800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
