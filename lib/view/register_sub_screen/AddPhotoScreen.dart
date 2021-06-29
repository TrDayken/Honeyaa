import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/component/ImagePortrait.dart';
import 'package:honeyaa_clientside/component/RoundIconButton.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoScreen extends StatefulWidget {
  final Function(String) onPhotoChanged;

  AddPhotoScreen({@required this.onPhotoChanged});

  @override
  _AddPhotoScreenState createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final picker = ImagePicker();
  String _imagePath;
  final Color primaryColor = Colors.white;
  final Color secondaryColor = Color(0xffEB9605);

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
     var file = File(pickedFile.path);
    final _storage = FirebaseStorage.instance;
    
    if (pickedFile != null) {
      widget.onPhotoChanged(pickedFile.path);
      var snapshot = await _storage.ref()
        .child('folderName/imageName')
        .putFile(file)
        .whenComplete(() => {print('Upload Success')});
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
      setState(() {
        _imagePath = downloadUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Add photo',
            style: TextStyle(
                color: Colors.black, fontSize: 50, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        child: _imagePath == null
                            ? ImagePortrait(imageType: ImageType.NONE)
                            : ImagePortrait(
                                imagePath: _imagePath,
                                imageType: ImageType.FILE_IMAGE,
                              ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: _imagePath == null
                              ? RoundIconButton(
                                  onPressed: pickImageFromGallery,
                                  icon: Icons.add,
                                  size: 50,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
