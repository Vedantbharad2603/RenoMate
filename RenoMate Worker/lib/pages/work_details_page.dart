import 'package:flutter/material.dart';
import 'package:renomateworker/models/wall_painting_model.dart';
import 'package:renomateworker/theme.dart';

class WorkDetailsPage extends StatelessWidget {
  final WallPaintingModel work;

  const WorkDetailsPage({Key? key, required this.work}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyTheme.background,
      appBar: AppBar(
        title: const Text(
          // "RenoMate",
          "R E N O M A T E (Worker)",
          style: TextStyle(
            // fontSize: 30,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: MyTheme.accent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(_width * 0.05),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyTheme.accent,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(_width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Type: ${work.selectedType}',
                    style: TextStyle(
                      color: MyTheme.text,
                      fontSize: _width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Date: ${work.tillDate.toString()}',
                  style: TextStyle(
                    color: MyTheme.text,
                    fontSize: _width * 0.038,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'More Info: ${work.information}',
                  style: TextStyle(
                    color: MyTheme.text,
                    fontSize: _width * 0.038,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (work.referenceImagePath != null)
                  Image.network(
                    work.referenceImagePath!,
                    height: 200, // Adjust the height as needed
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                else
                  Text(
                    'No image found',
                    style: TextStyle(
                      color: MyTheme.text,
                      fontSize: _width * 0.045,
                    ),
                  ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: _width * 0.1,
                    width: _width * 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyTheme.button1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Take This Work',
                      style: TextStyle(
                          color: MyTheme.background,
                          fontSize: _width * 0.048,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
