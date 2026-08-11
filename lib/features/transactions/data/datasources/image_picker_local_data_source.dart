import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

abstract class ImagePickerLocalDataSource {
  Future<String?> pickerAndCropImage();
}

class ImagePickerLocalDataSourceImpl implements ImagePickerLocalDataSource {
  @override
  Future<String?> pickerAndCropImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return null;

    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      maxWidth: 500,
      maxHeight: 500,
      uiSettings: [
        AndroidUiSettings(lockAspectRatio: true, cropStyle: CropStyle.circle),
        IOSUiSettings(
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          cropStyle: CropStyle.circle,
        ),
      ],
    );
    if (croppedFile == null) return null;
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await File(
      croppedFile.path,
    ).copy('${appDir.path}/images/$fileName');
    return savedImage.path;
  }
}
