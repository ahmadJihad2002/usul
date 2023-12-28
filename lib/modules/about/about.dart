import 'package:flutter/material.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:




      AppBar(
        backgroundColor: const Color(0xffffffff),

        title: const Text(
            'من نحن ', style: TextStyle(fontSize: 16, color: Color(0xff000000))
            ,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'معلومات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'تم تطوير هذا التطبيق  لتسهيل وتسريع عملية تصفح واختيار الأراضي والعقارات المناسبة'
                  ' للإهتمام،  سواء لأغراض استثمارية أو سكنية.  للمساهمة في تسهيل تجربة البحث عن العقارات وتوفير وقت وجهد للمشترين'
                  ' والمستثمرين،  ولتقديم وسيلة فعّالة لعرض وترويج الأراضي للبيع للوكلاء وأصحاب الممتلكات. ',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'مبرمج التطبيق:  م.أحمد جهاد درابيع',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  SocialMediaLink(
                    icon: Icons.phone,
                    label: '+970569751749',
                    link: 'tel:+972569751749',

                  ),
                  SocialMediaLink(
                    icon: Brandico.instagram_filled,
                    label: 'Instagram',
                    link: 'https://www.instagram.com/ahmad.jihad.10004/',
                  ),
                  SocialMediaLink(
                    icon: Brandico.linkedin_1,
                    label: 'LinkedIn',
                    link: 'https://www.linkedin.com/in/ahmad-darabee-81539319a/',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? link;


  const SocialMediaLink({
    required this.icon,
    required this.label,
    this.link,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () {
          if (link != null) {
            launchUrlString(link!);
          }
        },
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(label),

          ],
        ),
      ),
    );
  }
}
