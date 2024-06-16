import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PdfDoc extends StatefulWidget {
  final String url;

  const PdfDoc(
    this.url, {
    Key? key,
  }) : super(key: key);

  @override
  State<PdfDoc> createState() => _PdfDocState();
}

class _PdfDocState extends State<PdfDoc> {

  late PdfController _controller;  

  @override
  void initState() {
    super.initState();

    _controller = PdfController(
      document: PdfDocument.openData(InternetFile.get(widget.url))
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PdfView(
    controller: _controller,
    scrollDirection: Axis.vertical,
    // TODO: check this. Get from Maxim code
    renderer: (page) => page.render(
      width: page.width * 4, 
      height: page.height * 4,
    ),
  );
}