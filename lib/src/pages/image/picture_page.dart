import 'package:flutter/material.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/src/pages/image/picture_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PicturePage extends StatelessWidget {
  PicturePage({Key? key}) : super(key: key);

  final _pictureController = Get.put(PictureController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<PictureController>(builder: (controller) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ElevatedButton(
                                child: const Text('จากกล้อง'),
                                onPressed: () => {
                                  _pictureController.getImageFromCamera(),
                                  // Get.toNamed(Routes.signPage)
                                  Navigator.pop(context)
                                },
                              ),
                              ElevatedButton(
                                child: const Text('จากอัลบั้ม'),
                                onPressed: () => {
                                  _pictureController.getImageFromGallery(),
                                  Navigator.pop(context)
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey),
                  margin: const EdgeInsets.all(13),
                  width: AppTheme.fullWidth(context),
                  height: 600,
                  child: _pictureController.image != null
                      ? ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13)),
                          child: Image.file(
                            _pictureController.image!,
                            fit: BoxFit.fill,
                          ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                "คลิกเพื่อเลือกรูป",
                                style: GoogleFonts.mulish(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                              Lottie.asset("assets/loiite.json", repeat: true),
                            ]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
