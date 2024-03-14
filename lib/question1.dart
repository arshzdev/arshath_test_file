import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Querstion1 extends StatefulWidget {
  const Querstion1({Key? key}) : super(key: key);

  @override
  State<Querstion1> createState() => _Querstion1State();
}

class _Querstion1State extends State<Querstion1> {
  @override

  var pickedFile = null;
  Widget build(BuildContext context) {

    Future<void> _pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, // Allow multiple file selection
      );

      if (result != null && result.files.isNotEmpty) {
        for (final file in result.files) {
          final fileSize = file.size;
          if (fileSize <= 10 * 1024 * 1024) {
            // File is within size limit, handle it 
            setState(() {
            pickedFile = File(file.path!);
            });
            final storageRef = FirebaseStorage.instance.ref().child('uploded_file/${file.name}');
            UploadTask uploadTask =
                storageRef.putFile(pickedFile); // Corrected line

            // Handle the picked file as needed, e.g., upload to server
            print('Picked file: ${pickedFile.path}');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("Sucessfully uploaded"),
            ));
          } else {
            // File exceeds size limit, show error message
            // You may want to show a SnackBar or AlertDialog to inform the user
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("File size exceeds the limit of 10 MB"),
            ));
          }
        }
      } else {
        // User canceled the file picker or didn't select any files
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              if(pickedFile != null)
Expanded(
child:Container(
color:Colors.blue[100],
child:Center(
child:Image.file(File(pickedFile!.path!),
width: double.infinity,
fit: BoxFit.cover,
),
 ),
)
),
const SizedBox(height:32),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _pickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F1F1F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    side: const BorderSide(color: Color(0xFF8464B7)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Upload File",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
