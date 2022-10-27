import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:scdao_mobile/providers/user.dart';
import 'package:scdao_mobile/utils/ImageUtils.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class DisplayPhotoScreen extends StatefulWidget {
  static const routeName = "/display";
  const DisplayPhotoScreen({Key? key}) : super(key: key);

  @override
  State<DisplayPhotoScreen> createState() => _DisplayPhotoScreenState();
}

class _DisplayPhotoScreenState extends State<DisplayPhotoScreen> {
  int _currIndex = 0;
  List<String> _imagePaths = [];

  @override
  void initState() {
    ImageUtility.getImagesFromPreferences().then((values) {
      setState(() {
        this._imagePaths = values;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    UserProvider userProvider = Provider.of(context, listen: true);

    void _cropImage() async {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _imagePaths[_currIndex],
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop',
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _imagePaths[_currIndex] = croppedFile.path;
        });
        await ImageUtility.replaceImagesOnPref(_imagePaths);
        userProvider.setPreviewImgPath(croppedFile.path);
      }
    }

    Widget _appBar() {
      return SizedBox(
        height: queryData.size.height * 1 / 10,
        width: queryData.size.width,
        child: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => print("album?"),
                    icon: Icon(Icons.grid_view_outlined),
                    padding: EdgeInsets.zero,
                    splashRadius: 1.0,
                  ),
                  IconButton(
                    onPressed: _cropImage,
                    icon: Icon(Icons.edit_outlined),
                    padding: EdgeInsets.zero,
                    splashRadius: 1.0,
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    postData(filepaths, apiUrl) async {
      try {
        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

        //TODO: request fields
        request.fields['userid'] = '1';
        request.fields['cooking_date'] = '2022-10-22';

        List<http.MultipartFile> newList = <http.MultipartFile>[];

        for (int i = 0; i < filepaths.length; i++) {
          File imageFile = File(filepaths[i]);
          var stream = new http.ByteStream(imageFile.openRead());
          var length = await imageFile.length();
          var multipartFile = new http.MultipartFile("pictures", stream, length,
              filename: path.basename(imageFile.path));
          newList.add(multipartFile);
        }
        request.files.addAll(newList);

        var res = await request.send();
        print(res.toString());

        res.stream.listen((value) {
          print('value');
          print(value);
        });
        if (res.statusCode == 200) {
          print('uploaded');
        } else {
          print('failed');
        }
      } catch (e) {
        print(e);
      }
    }

    //Uploading function
    void _uploadImage() async {
      print('continue');

      final String address = "http://127.0.0.1/api";
      try {
        postData(this._imagePaths, address + '/v1/uploads/ddi');
      } on SocketException catch (_) {
        print("You are not connected to internet");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _appBar(),
            Expanded(
              flex: 5,
              child: this._imagePaths.length != 0
                  ? Image.file(File(_imagePaths[this._currIndex]))
                  : Center(child: Text("No image is taken")),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: queryData.size.width * 0.28,
              height: 40,
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Retake",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
                onPressed: () async {
                  if (userProvider.previewImgPath == _imagePaths[_currIndex]) {
                    List<String> newImgs = _imagePaths.where((e) {
                      return e != _imagePaths[_currIndex];
                    }).toList();
                    if (newImgs.length > 0) {
                      userProvider.setPreviewImgPath(newImgs.first);
                    } else {
                      userProvider.setPreviewImgPath(null);
                    }
                  }
                  await ImageUtility.removeImage(_currIndex);
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: queryData.size.width * 1 / 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          if (this._currIndex > 0) {
                            setState(() {
                              this._currIndex--;
                            });
                          }
                        },
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                        ),
                        padding: EdgeInsets.all(0),
                        color: this._currIndex > 0
                            ? Colors.black
                            : Colors.black.withOpacity(0.25),
                        textColor: this._currIndex > 0
                            ? Colors.white
                            : Colors.white.withOpacity(0.75),
                        shape: CircleBorder(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                            "${this._currIndex + 1}/${this._imagePaths.length}"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            if (this._currIndex < this._imagePaths.length - 1) {
                              this._currIndex++;
                            }
                          });
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        color: this._currIndex < this._imagePaths.length - 1
                            ? Colors.black
                            : Colors.black.withOpacity(0.25),
                        textColor: this._currIndex < this._imagePaths.length - 1
                            ? Colors.white
                            : Colors.white.withOpacity(0.75),
                        padding: EdgeInsets.all(0),
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: queryData.size.width * 0.12,
        width: queryData.size.width,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: queryData.size.width * 1 / 8,
              child: MaterialButton(
                onPressed: _uploadImage,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                color: Colors.green,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
            ),
            SizedBox(
              width: queryData.size.width * 1 / 16,
            )
          ],
        ),
      ),
    );
  }
}
