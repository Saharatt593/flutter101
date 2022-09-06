import 'package:flutter/material.dart';
import 'package:flutter101/core/themes/light_color.dart';
import 'package:flutter101/core/widgets/extentions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomConfirmDialog extends StatelessWidget {
  const CustomConfirmDialog(
      {Key? key,
      required this.title,
      required this.description,
      required this.positiveText,
      required this.negativeText,
      required this.assetImage,
      this.positiveHandler,
      this.negativeHandler})
      : super(key: key);

  final String title;
  final String description;
  final String positiveText;
  final String negativeText;
  final String assetImage;
  final VoidCallback? positiveHandler;
  final VoidCallback? negativeHandler;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(20),
      // ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // boxShadow: const [
        //   BoxShadow(color: Colors.black,offset: Offset(0, 1),blurRadius: 5),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 27,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      assetImage,
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: GoogleFonts.mulish(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: LightColor.lightGrey,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15)),
                            ),
                            child: Text(
                              negativeText,
                              style: GoogleFonts.mulish(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ).ripple(() {
                            Navigator.pop(context);
                            if (negativeHandler != null) {
                              negativeHandler!();
                            }
                          },
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15))),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: LightColor.orange,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15)),
                            ),
                            child: Text(
                              positiveText,
                              style: GoogleFonts.mulish(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ).ripple(() {
                            Navigator.pop(context);
                            if (positiveHandler != null) {
                              positiveHandler!();
                            }
                          },
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(15))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
