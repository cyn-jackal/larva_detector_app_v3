import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:larva_detector_app/components/my_content_box.dart';
import 'package:flutter/services.dart';
import 'package:larva_detector_app_v3/components/my_content_box.dart';
import 'package:larva_detector_app_v3/components/my_primary_button.dart';
import 'package:larva_detector_app_v3/components/my_secound_button.dart';
import 'package:larva_detector_app_v3/models/api_connection.dart';
import 'package:larva_detector_app_v3/models/image_model.dart';
import 'package:larva_detector_app_v3/pages/analysis_page.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:larva_detector_app/components/my_primary_button.dart';
// import 'package:larva_detector_app/components/my_secound_button.dart';
// import 'package:larva_detector_app/models/api_connection.dart';
// import 'package:larva_detector_app/models/image_model.dart';
// import 'package:larva_detector_app/pages/analysis_page.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:typed_data';

class ImportPicturePage extends StatefulWidget {
  const ImportPicturePage({super.key});

  @override
  State<ImportPicturePage> createState() => _ImportPicturePageState();
}

class _ImportPicturePageState extends State<ImportPicturePage> {
  // late File _image;
  // final picker = ImagePicker();
  // File? imageFile;
  final dio = Dio();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      if (pickedImage != null) {
        setState(() async {
          //get access to image class
          final addImg = context.read<ImageModel>();

          //set rawImg
          addImg.setRawImageObj(File(pickedImage.path));
          addImg.setRawImageString(pickedImage.path);
        });
      } else {
        // print('User didnt pick any image.');
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 25,
      );
      // final pickedFile = await picker.getImage(source: ImageSource.camera);

      if (pickedImage != null) {
        setState(() {
          //get access to image class
          final addImg = context.read<ImageModel>();

          //set rawImg
          addImg.setRawImageObj(File(pickedImage.path));
          addImg.setRawImageString(pickedImage.path);

          // if (pickedFile != null) {
          // _image = File(pickedFile.path);
          // }
        });
      }
    } catch (e) {}
  }

  //Show options to get image from camera or gallery
  Future showOptions(isImportImage) async {
    if (isImportImage == 1) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Photo Gallery'),
              onPressed: () {
                // close the options modal
                Navigator.of(context).pop();
                // get image from gallery
                getImageFromGallery();
              },
            ),
            // CupertinoActionSheetAction(
            //   child: Text('Camera'),
            //   onPressed: () {
            //     // close the options modal
            //     Navigator.of(context).pop();
            //     // get image from camera
            //     getImageFromCamera();
            //   },
            // ),
          ],
        ),
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () {
                // close the options modal
                Navigator.of(context).pop();
                // get image from camera
                getImageFromCamera();
              },
            ),
          ],
        ),
      );
    }
  }

  void navigateToAnalysis() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AnalysisPage()));
  }

  void clearImage() async {
    // context.loaderOverlay.show();
    //access class
    final clearImgPath = context.read<ImageModel>();

    //clearRawImageObj
    clearImgPath.clearRawImageObj();
    clearImgPath.clearRawImageString();
  }

  void downloadImageToPhone(imgPath) async {
    // await GallerySaver.saveImage(imgPath, toDcim: true);
  }

  fetchAPI(rawImageObj, rawImageString) async {
    if (rawImageString != null) {
      final addAnalysis = context.read<ImageModel>();

      var formDataDatail = FormData.fromMap({
        'image':
            await MultipartFile.fromFile(rawImageString, filename: 'upload')
      });
      var formDataImage = FormData.fromMap({
        'image':
            await MultipartFile.fromFile(rawImageString, filename: 'upload')
      });

      try {
        print("Starting analysis request...");
        print("Analysis URL: ${ApiConnection().getAnalysisDetail()}");
        print("FormDataDetail: $formDataDatail");
        final responseDetail = await dio
            .post(ApiConnection().getAnalysisDetail(), data: formDataDatail);
        final responseImage = await dio.post(
            ApiConnection().getAnalysisPictureBase64(),
            data: formDataImage);
        addAnalysis.setAnalysedDetail(responseDetail.data);
        // convert to Uint8List for show image
        var convertB64 = responseImage.data;
        Uint8List bytesImage = const Base64Decoder().convert(convertB64);
        addAnalysis.setAnalysedImage(bytesImage);
        print(responseDetail.data);
      } catch (e) {
        print(e);
      }
    }
  }

  fetchData() async {
    Dio dio = Dio();
    print('test call12');
    try {
      // final response = await dio.get('http://10.0.2.2:80/hello');
      // final response = await dio.get('http://10.0.2.2:5000/hello');
      // print(response); // Prints the response data
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageModel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Image Picker'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Center(
                child: value.rawImageObj == null
                    ? GestureDetector(
                        onTap: () {
                          showOptions(value.isImportImage);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          width: double.infinity,
                          height: 380,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white70)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: value.isImportImage == 1
                                  ? [
                                      const Icon(Icons.image, size: 80),
                                      const Text("Click to add images")
                                    ]
                                  : [
                                      const Icon(Icons.camera, size: 80),
                                      const Text("Click to take picture")
                                    ]),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          downloadImageToPhone(value.rawImageObj?.path);
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: MyContentBox(
                            height: 380,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                // imageFile!,
                                value.rawImageObj!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              MySecoundButton(onTap: () => clearImage()),
              const SizedBox(
                height: 10,
              ),
              MyPrimaryButton(
                onTap: () async => {
                  // send API to analysis
                  context.loaderOverlay.show(),
                  if (value.analysedImage == null ||
                      value.analysedImage.length == 0)
                    {
                      await fetchData(),
                      await fetchAPI(value.rawImageObj, value.rawImageString),
                    },
                  context.loaderOverlay.hide(),
                  // Navigate to analysispage
                  navigateToAnalysis()
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
