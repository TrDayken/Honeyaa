import 'package:flutter/material.dart';
import 'package:honeyaa_clientside/component/ImagePortrait.dart';
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

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.onPhotoChanged(pickedFile.path);

      setState(() {
        _imagePath = pickedFile.path;
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
            style: TextStyle(color: Colors.white, fontSize: 50),
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
                              ? MaterialButton(
                                  onPressed: pickImageFromGallery,
                                  color: Colors.lightGreen,
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
