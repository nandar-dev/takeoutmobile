import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/snackbar.dart';
import 'package:takeout/widgets/typography_widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class ImageUpload extends StatefulWidget {
  final String label;
  final String description;
  final Function(PlatformFile?) onFileChanged;

  const ImageUpload({
    super.key,
    required this.label,
    required this.description,
    required this.onFileChanged,
  });

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  PlatformFile? _pickedFile;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _pickedFile = result.files.first;
        });
        widget.onFileChanged(_pickedFile);
      } else {
        Snackbar.showError(context, 'No file selected.');
      }
    } catch (e) {
      Snackbar.showError(context, "Error picking file: $e");
    }
  }

  void _clearFile() {
    setState(() {
      _pickedFile = null;
      widget.onFileChanged(null);
    });
  }

  bool _isImageFile(String? filePath) {
    if (filePath == null) return false;
    final String ext = filePath.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext);
  }

  @override
  Widget build(BuildContext context) {
    final ssPlaceholder = "refill.ss_placeholder".tr();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubText(
          text: widget.label,
          fontSize: FontSizes.md,
          color: AppColors.textPrimary,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textfieldborder),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildPreview(ssPlaceholder),
                if (_pickedFile != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                        color: AppColors.neutral10,
                        icon: const Icon(Icons.close),
                        tooltip: 'Clear selection',
                        onPressed: _clearFile,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        SubText(text: widget.description, fontSize: FontSizes.sm),
      ],
    );
  }

  Widget _buildPreview(String placeholder) {
    if (_pickedFile == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add_photo_alternate_outlined,
            size: 60,
            color: Colors.grey,
          ),
          const SizedBox(height: 8),
          SubText(
            text: placeholder,
            fontSize: FontSizes.sm,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    final filePath = _pickedFile!.path;
    if (filePath != null && _isImageFile(filePath)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6.5),
        child: Image.file(
          File(filePath),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Text('Error loading preview'));
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.insert_drive_file, size: 50, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              'File: ${_pickedFile!.name}\n(Cannot preview this file type)',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
  }
}
