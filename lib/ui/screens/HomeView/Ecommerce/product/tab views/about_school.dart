import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/providers/school_repository.dart';
import '../../../../../../data/repository/product_view_repository.dart';


class AboutSchool extends StatefulWidget {
  static const String route = '/aboutschool';
  const AboutSchool({super.key});

  @override
  State<AboutSchool> createState() => _AboutSchoolState();
}

class _AboutSchoolState extends State<AboutSchool> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: dimensions.height8*1.5,),
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height24*9.4,
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(schoolData.selectedSchool.banner),
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: dimensions.height8*3,),
            //about us
            Container(
              width: dimensions.width342,
              // height: dimensions.height8*20.2,
              margin: EdgeInsets.only(left: dimensions.width24),
              child:  Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ReusableText(
                      text: 'About Us',
                      color: Color(0xFF444444),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
        
                    ),
                  ),
                  SizedBox(height: dimensions.height8*1.5,),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      schoolData.selectedSchool.aboutUs == '' ?'Managing Committee of Sir Chhotu Ram Educational and Cultural Society, Jharsa, Gurugram held a meeting and considered that to provide education to the young with a professional option to the poor and deserving children, so decided to start a school and in 2005, the society established C.R.Model Public . School., Jharsa, (Sector-32) Gurugram': schoolData.selectedSchool.aboutUs,
                      style: const TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: dimensions.height8*3,),


            //our inspiration
            Container(
              width: dimensions.width342,
              // height: dimensions.height8*43.25,
              margin: EdgeInsets.only(left: dimensions.width24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Our Inspiration',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      schoolData.selectedSchool.ourInspiration== '' ?'Deenbandhu Sir Chhotu Ram was born on 24th Nov. 1881 in Garhi Sampla (a village in old Rohtak Distt.) in the family of Ch. Sukh Ram & Mrs. Sirya Devi. He was a renowned educationist & named as father of reform for farmers. He has established Jat Anglo Sansthan on 26th March, 1913 after completion of his Graduation in Law. In 1916, he became president of Congress Party & continued till 1919. He formed Unionist Party in 1923. He became Agriculture Minister in 1924 & continued till 1926.': schoolData.selectedSchool.ourInspiration,
                      style: const TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(height: dimensions.height8*1.5,),
                  Container(
                    width: dimensions.width342,
                    height: dimensions.height32*4,
                    child: schoolData.selectedSchool.image== '' ? Image.asset('assets/chotu.png' , fit: BoxFit.contain,) : Image.network(schoolData.selectedSchool.image , fit: BoxFit.contain,),
                  ),
                ],
              ),
            ),

            SizedBox(height: dimensions.height8*3,),



            //mission
            Container(
              width: dimensions.width342,
              // height: dimensions.height8*25,
              margin: EdgeInsets.only(left: dimensions.width24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Mission',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      schoolData.selectedSchool.mission == '' ? 'It was the mission of the management committee that the Education of the young’s with a preferential option for the poor, the marginalized or the underprivileged in the surrounding rural and slum areas.The society considered school as an effective agent in promoting the integral formation of the child in the gospel spirit of love and freedom a love that excludes no one because of religion, caste and region in order to shape a better human society.': schoolData.selectedSchool.mission,
                      style: const TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}
