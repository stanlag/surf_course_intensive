import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_10_business_card/ui/my_widgets/svgicon_widget/svgicon_widget.dart';
import 'package:task_10_business_card/ui/my_widgets/text_widget/text_widget.dart';
import 'package:task_10_business_card/ui/resources/text.dart';

class MyBusinessCard extends StatelessWidget {
  const MyBusinessCard({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(TextApp.myBusinessCard),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 61,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/ava.jpeg'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(TextApp.myName,
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextWidget(
                  titleText: TextApp.aboutMe,
                  paragraphText: TextApp.aboutMeText,
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextWidget(
                  titleText: TextApp.hobbies,
                  paragraphText: TextApp.hobbiesText,
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextWidget(
                  titleText: TextApp.experience,
                  paragraphText: TextApp.experienceText,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SvgIcon(),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(TextApp.slogan,
                        style: GoogleFonts.glory(fontSize: 15)),
                    const SizedBox(
                      width: 5,
                    ),
                    const SvgIcon(),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
