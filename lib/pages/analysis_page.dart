import 'dart:io';

import 'package:flutter/material.dart';
import 'package:larva_detector_app_v3/components/my_content_box.dart';
import 'package:larva_detector_app_v3/components/my_primary_button.dart';
import 'package:larva_detector_app_v3/components/my_secound_button.dart';
import 'package:larva_detector_app_v3/models/image_model.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:larva_detector_app/components/my_content_box.dart';
// import 'package:larva_detector_app/components/my_primary_button.dart';
// import 'package:larva_detector_app/components/my_secound_button.dart';
// import 'package:larva_detector_app/models/image_model.dart';
import 'package:provider/provider.dart';
// import 'dart:convert';
import 'dart:typed_data';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  void downloadImageToPhone(imgPath) async {
    // context.loaderOverlay.show();
    // await GallerySaver.saveImage(imgPath, toDcim: true);
    // context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageModel>(
        builder: (context, value, child) => SafeArea(
                child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                title: const Text("Analysis Page"),
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: double.infinity,
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      // setAnalysedImage
                      Center(
                          child: value.analysedImage == null ||
                                  value.analysedImage.length <= 0
                              ? GestureDetector(
                                  onTap: () {
                                    print("No analysis image found.");
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(25),
                                    width: double.infinity,
                                    height: 350,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius: BorderRadius.circular(12),
                                        border:
                                            Border.all(color: Colors.white70)),
                                    child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.image, size: 80),
                                          Text("No analysis image")
                                        ]),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    // comvert to file type
                                    Uint8List imageInUnit8List =
                                        value.analysedImage;
                                    final tempDir =
                                        await getTemporaryDirectory();
                                    File file =
                                        await File('${tempDir.path}/image.png')
                                            .create();
                                    file.writeAsBytesSync(imageInUnit8List);
                                    downloadImageToPhone(file.path);
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: MyContentBox(
                                      height: 350,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(value.analysedImage
                                            // fit: BoxFit.fill,
                                            ),
                                      ),
                                    ),
                                  ),
                                )),

                      const SizedBox(
                        height: 5,
                      ),

                      // Header 1
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Result",
                            style: TextStyle(fontSize: 25),
                          )),

                      // Result
                      Expanded(
                        child: SizedBox(
                          height: 1,
                          child: GridView.count(
                            // Create a grid with 2 columns. If you change the scrollDirection to
                            // horizontal, this produces 2 rows.
                            crossAxisCount: 3,
                            // Generate 100 widgets that display their index in the List.
                            children: List.generate(7, (index) {
                              print(value.analysedDetail);
                              return Container(
                                margin: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: value.analysedDetail == null ||
                                          value.analysedDetail.length <= 0
                                      ? SizedBox(
                                          // height: 10,
                                          child: index != 6
                                              ? Text(
                                                  'Stage ${index + 1} : 0',
                                                )
                                              : const Text("Total : 0"),
                                        )
                                      : SizedBox(
                                          // height: 10,
                                          child: index != 6
                                              ? Text(
                                                  'Stage ${index + 1} : ${value.analysedDetail?['result']?['larva_stage']?['larva${index + 1}']}',
                                                )
                                              : Text(
                                                  "Total : ${value.analysedDetail?['result']?['larva_total']}"),
                                        ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // button clear
                      MySecoundButton(
                          height: 50,
                          text: "Clear",
                          onTap: () {
                            // Navigator.of(context).pop();
                            setState(()  {
                              //access class
                              final clearImgPath = context.read<ImageModel>();

                              //clear
                              clearImgPath.clearAnalysedDetail();
                              clearImgPath.clearAnalysedImage();
                            });
                          }),

                      const SizedBox(
                        height: 10,
                      ),

                      // button more detail
                      // MyPrimaryButton(
                      //   height: 50,
                      //   text: "More Detail",
                      //   onTap: () async => {},
                      // )
                    ],
                  ),
                ),
              ),
            )));
  }
}
