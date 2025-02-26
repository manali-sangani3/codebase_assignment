import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'app_colors.dart';

class ImageHandler {
  final ImagePicker _picker = ImagePicker();
  final List<File> filePaths = [];
  final int maxImages = 5; // You can change this as per your requirements

  Future<File?> pickAndProcessImage(final BuildContext context) async {
    // Pick image from camera
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 60);

    if (image == null) {
      return null;
    }

    // Compress the image
    final File? compressedImage = await _compressImage(image);

    // Crop the image
    if (!context.mounted) return null;
    final File? croppedImage = await _cropImage(compressedImage!, context);

    return croppedImage;
  }

  // Compress the selected image
  Future<File?> _compressImage(final XFile image) async {
    final File file = File(image.path);
    final Directory tempDir = await getTemporaryDirectory();
    final String compressedImagePath =
        '${tempDir.path}/${file.uri.pathSegments.last}_wld.jpg';

    final XFile? compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.path, // Source image path
      compressedImagePath, // Target path for the compressed image
      quality: 70, // Compress quality (0-100)
      minWidth: 800, // Optional: specify width to resize
      minHeight: 800, // Optional: specify height to resize
    );

    if (compressedFile != null) {
      final int compressedSize = await compressedFile.length();
      debugPrint("Compressed image size: $compressedSize bytes");
      return File(compressedFile.path);
    } else {
      return null;
    }
  }

  // Crop the image
  Future<File?> _cropImage(final File file, final BuildContext context) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      uiSettings: <PlatformUiSettings>[
        AndroidUiSettings(
            toolbarTitle: "Crop",
            toolbarColor: AppColors.colorPrimary,
            toolbarWidgetColor: AppColors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            activeControlsWidgetColor: AppColors.colorPrimary),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: "Crop",
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return null;
    }
  }
}
