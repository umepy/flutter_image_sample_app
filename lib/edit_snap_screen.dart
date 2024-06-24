import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as image_lib;
import 'package:flutter_image_sample_app/gen/assets.gen.dart';

class ImageEditScreen extends StatefulWidget {
  const ImageEditScreen({super.key, required this.imageBitmap});
  final Uint8List imageBitmap;

  @override
  State<ImageEditScreen> createState() => _ImageEditScreenState();
}

//test
class _ImageEditScreenState extends State<ImageEditScreen> {
  late Uint8List _imageBitmap;
  @override
  void initState() {
    super.initState();
    _imageBitmap = widget.imageBitmap;
  }

  void _rotateImage(int angle) {
    final image = image_lib.decodeImage(_imageBitmap);
    if (image != null) {
      final rotatedImage = image_lib.copyRotate(image, angle: angle);
      final rotatedImageBytes = image_lib.encodeBmp(rotatedImage);
      setState(() {
        _imageBitmap = rotatedImageBytes;
      });
    }
  }

  void _flipImage() {
    final image = image_lib.decodeImage(_imageBitmap);
    if (image != null) {
      final flippedImage = image_lib.flipHorizontal(image);
      final flippedImageBytes = image_lib.encodeBmp(flippedImage);
      setState(() {
        _imageBitmap = flippedImageBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(l10n.imageEdit),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(_imageBitmap),
              IconButton(
                  onPressed: () {
                    _rotateImage(90);
                  },
                  icon: Assets.rotateIcon.svg(width: 24, height: 24)),
              IconButton(
                  onPressed: () {
                    _flipImage();
                  },
                  icon: Assets.flipIcon.svg(width: 24, height: 24)),
            ],
          ),
        ));
  }
}
