import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// import 'package:path_provider/path_provider.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.onPickImage,
    required this.userName,
  });

  final void Function(File pickedImage) onPickImage;
  final String userName;
  @override
  State<StatefulWidget> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }
    // String fileName = '${widget.userName}.jpg';
    // Directory directory = await getApplicationDocumentsDirectory();
    // File file = File('${directory.path}/$fileName');
    // await file.writeAsBytes(await pickedImage.readAsBytes());
    // bool exists = await file.exists();
    // if (exists && context.mounted) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Saved onto ur SD card'),
    //     ),
    //   );
    // }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });


    widget.onPickImage(_pickedImageFile!);
  }

  void _pickFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: Text(
                    'Add Image',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  )),
            ),
            Expanded(
              child: TextButton.icon(
                  onPressed: _pickFromGallery,
                  icon: const Icon(Icons.image),
                  label: Text(
                    'Choose from galery',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  )),
            ),
          ],
        )
      ],
    );
  }
}
