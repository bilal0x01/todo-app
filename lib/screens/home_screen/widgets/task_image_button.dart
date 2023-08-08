import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:todo_app/theme/app_colors.dart';
import 'package:todo_app/theme/spaces.dart';

import '../../../services/database/tasks_provider.dart';
import '../../../services/media/storage_provider.dart';

class TaskImageButton extends StatefulWidget {
  const TaskImageButton(
      {super.key,
      required this.imageCurrentUrl,
      required this.taskData,
      required this.listRef,
      required this.ctx});

  final String imageCurrentUrl;
  final Map<String, dynamic> taskData;
  final DocumentReference listRef;
  final BuildContext ctx;

  @override
  State<TaskImageButton> createState() => _TaskImageButtonState();
}

class _TaskImageButtonState extends State<TaskImageButton> {
  bool imageLoading = false;

  void removeImgUrl() {
    TasksProvider.updateTask(widget.taskData['docReference'], widget.listRef,
        imageUrl: '');
  }

  void showOverlay() {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
        builder: (context) => GestureDetector(
              onTap: () {
                overlayEntry?.remove();
              },
              child: Stack(children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width / 1.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.secondaryColor,
                                width: 3,
                              ),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.imageCurrentUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          smallVertSpace,
                          IconButton(
                            color: Theme.of(context).colorScheme.error,
                            onPressed: () {
                              overlayEntry!.remove();

                              StorageProvider.deleteImage(
                                  widget.imageCurrentUrl);
                              removeImgUrl();
                            },
                            icon: const Icon(Icons.delete_outline_rounded),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ));
    Overlay.of(widget.ctx).insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    if (imageLoading) {
      return const Padding(
        padding: EdgeInsets.only(right: 20),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return widget.imageCurrentUrl.isEmpty
          ? TextButton(
              child: const Icon(Icons.add_photo_alternate_rounded),
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  final file = File(result.files.single.path!);
                  setState(() {
                    imageLoading = true;
                  });
                  await StorageProvider.uploadImage(
                    file,
                    DateTime.now().microsecondsSinceEpoch.toString(),
                  ).then((imageUrl) {
                    TasksProvider.updateTask(
                      widget.taskData['docReference'],
                      widget.listRef,
                      taskName: null,
                      taskDetails: null,
                      imageUrl: imageUrl,
                      taskDone: null,
                    );
                  });

                  setState(() {
                    imageLoading = false;
                  });

                } else {
                  debugPrint('file picker closed');
                }
              },
            )
          : TextButton(
              onPressed: showOverlay,
              child: const Icon(Icons.image_rounded),
            );
    }
  }
}
