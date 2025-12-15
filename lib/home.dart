import 'package:adgenerator/screens/fetch_question.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('مولد المحتوى الإعلاني الذكي'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assests/creativ_ico.png'),
                const Text(
                  'أنشئ إعلانات احترافية في دقائق',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'استخدم الذكاء الصنعي لتوليد نصوص إعلانية جذابة وفعالة بسهولة وسرعة.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdWizardScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 21, 93, 252),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text("!ابدأ الآن",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  padding: const EdgeInsets.all(8.0),
                  height: 225,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset('assests/accurate_ico.png'),
                      const Text('استهداف دقيق',
                          style: TextStyle(
                              fontSize: 16.5, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'حدد جمهورك المستهدف ونقاط الألم لإنتاج محتوى يلامس احتياجاتهم الحقيقية.',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  padding: const EdgeInsets.all(8.0),
                  height: 225,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset('assests/variant_spoken_ico.png'),
                      const Text(' لهجات متنوعة',
                          style: TextStyle(
                              fontSize: 16.5, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'اختر من بين أكثر من 10 لهجات عربية مختلفة لتتناسب مع جمهورك المحلي',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  padding: const EdgeInsets.all(8.0),
                  height: 225,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset('assests/variant_types_ico.png'),
                      const Text('أساليب متعددة',
                          style: TextStyle(
                              fontSize: 16.5, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'من الفكاهي إلى الجدي، من التحفيزي إلى التعليمي - اختر الأسلوب المناسب لعلامتك التجارية',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  padding: const EdgeInsets.all(8.0),
                  width: screenWidth - 10.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text('كيف يعمل التطبيق؟',
                          style: TextStyle(
                              fontSize: 16.5, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 8.0),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 219, 234, 254),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 91, 93, 252)),
                                ),
                              ),
                            ),
                            const Text('أدخل معلومات المنتج',
                                style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold)),
                            const Text(
                              'اسم المنتج، الوصف، والاستخدامات',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black26,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 219, 252, 231),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 120, 174, 62)),
                                ),
                              ),
                            ),
                            const Text('حدد الأسلوب واللهجة',
                                style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold)),
                            const Text(
                              'اختر طريقة الكتابة واللهجة المناسبة',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black26,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 237, 212),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Center(
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 245, 74, 0)),
                                ),
                              ),
                            ),
                            const Text('اختر نوع الإعلان',
                                style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold)),
                            const Text(
                              'صورة، ريل، فيديو، أو كاروسيل',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black26,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 243, 232, 255),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Center(
                                child: Text(
                                  '4',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 152, 16, 250)),
                                ),
                              ),
                            ),
                            const Text('احصل على النتيجة',
                                style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold)),
                            const Text(
                              'محتوى إعلاني جاهز للاستخدام',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black26,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
