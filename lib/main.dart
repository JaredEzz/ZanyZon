import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ZanyZonApp());
}

class ZanyZonApp extends StatelessWidget {
  const ZanyZonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFCD44)),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ZanyZon'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10.0),
          child: ZanyPage(),
        ),
      ),
    );
  }
}

class ZanyPage extends StatefulWidget {
  const ZanyPage({super.key});

  @override
  State<ZanyPage> createState() => _ZanyPageState();
}

class _ZanyPageState extends State<ZanyPage> {
  final amazonLinkController = TextEditingController();
  final customZanyTextController = TextEditingController();
  String? dropdownValue;
  String generatedLink = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: amazonLinkController,
                decoration: const InputDecoration(hintText: "Amazon Link"),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.ads_click),
                tooltip: 'load from current page',
                onPressed: () {
                  amazonLinkController.text = html.window.location.href;
                } // Handle loading from current page
            ),
          ],
        ),
        TextField(
          controller: customZanyTextController,
          decoration: const InputDecoration(hintText: "Custom Zany text to add to link"),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: ElevatedButton(
        //     child: Text('Get some random zany text'),
        //     onPressed: () {}, // Handle random zany text
        //   ),
        // ),
        // DropdownButton<String>(
        //   value: dropdownValue,
        //   onChanged: (String? newValue) {
        //     if (newValue != null) {
        //       setState(() {
        //         dropdownValue = newValue;
        //       });
        //     }
        //   },
        //   items: <String>['Surprise me!', 'Random item from amazon', 'Random movie']
        //       .map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        //   hint: Text("Zany text categories"),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Generate Link', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, fontFamily: 'lato'),),
            ),
            onPressed: () => setState(() => generateLink()), // Handle generating link
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Expanded(
            child: Text(generatedLink),
          ),
          if(generatedLink.isNotEmpty) ...[
            IconButton(
              icon: const Icon(Icons.copy),
              tooltip: 'Copy to clipboard',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: generatedLink));
              },
            ),
            IconButton(
              icon: const Icon(Icons.launch),
              tooltip: 'Open in new tab',
              onPressed: () {
                html.window.open(generatedLink, '_blank'); // '_blank' opens in new tab
              },
            )
          ]
        ]),
      ],
    );
  }

  void generateLink() {
    // If any field is empty, show a SnackBar and return
    if (amazonLinkController.text.isEmpty || customZanyTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All fields must be filled out")));
      return;
    } else {
      // A. Extract the ASIN from the Amazon link
      String amazonLink = amazonLinkController.text;
      String asin = '';
      for (int i = 0; i < amazonLink.length - 9; i++) {
        if (amazonLink[i] == 'B' && isAlphaNumeric(amazonLink.substring(i, i + 10))) {
          asin = amazonLink.substring(i, i + 10);
          break;
        }
      }

      // Check if ASIN exists
      if(asin.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect Amazon Link Format')));
        return;
      }

      // B. Construct the custom Amazon link
      String zanyText = customZanyTextController.text.toUrlSafe();
      String customAmazonLink = "https://www.amazon.com/$zanyText/dp/$asin/";

      // C. Update `generatedLink` with the new custom link
      generatedLink = customAmazonLink;

      // D. Copy the generated link to clipboard and show a SnackBar
      Clipboard.setData(ClipboardData(text: generatedLink));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Link generated and copied to clipboard!"))
      );
    }
  }

  bool isAlphaNumeric(String str) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(str);
  }
}

extension on String {
  String toUrlSafe() {
    return Uri.encodeComponent(replaceAll(' ', '-'));
  }
}
