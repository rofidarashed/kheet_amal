import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  static const String routeName = "filter";

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final RangeValues _currentRangeValues = const RangeValues(0, 18);

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontWeight: FontWeight.w400);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF4F5F6),
        appBar: AppBar(
          backgroundColor: Color(0xFFF4F5F6),
          title: Text("فلتر"),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: buildBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "الحالة",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 26),
                        ),
                        RadioListTile(
                          title: const Text("طفل مفقود", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),),
                          value: "",
                          shape: StadiumBorder(
                            side: BorderSide(color: Color(0xff92C1EB)),
                          ),
                          fillColor:  MaterialStateProperty.all(Color(0xff92C1EB)),
                          activeColor: Color(0xff92C1EB),
                          tileColor: Color(0xff92C1EB),
                          selectedTileColor: Color(0xff92C1EB),
                          groupValue: null,
                          onChanged: (_) {},
                        ),
                        RadioListTile(
                          title: const Text("طفل بحاجة للتحقق", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                          value: "",
                          shape: StadiumBorder(
                            side: BorderSide(color: Color(0xff92C1EB)),
                          ),
                          fillColor:  MaterialStateProperty.all(Color(0xff92C1EB)),
                          activeColor: Color(0xff92C1EB),
                          tileColor: Color(0xff92C1EB),
                          selectedTileColor: Color(0xff92C1EB),
                          groupValue: null,
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                child: Container(
                  decoration: buildBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("العمر", style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 26)),
                        RangeSlider(
                          values: const RangeValues(0, 18),
                          min: 0,
                          max: 18,
                          divisions: 18,
                          activeColor: Color(0xFF92C1EB),
                          inactiveColor: Color(0xFFB8B8B8),
                          labels: RangeLabels("${_currentRangeValues.start
                              .round()
                              .toString()} سنوات", "${_currentRangeValues.end
                              .round().toString()} سنوات"),
                          onChanged: (_) {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: const Text("النوع", style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _GenderButton(color: Colors.pink,
                              imagePath: "assets/images/Rectangle 4565.png",),
                            SizedBox(width: 20),
                            _GenderButton(color: Colors.blue,
                              imagePath: "assets/images/Rectangle 4566 (1).png",),
                          ],
                        ),
                        SizedBox(height: 5,),
                        buildTextField("لون البشرة", "حدد لون البشرة"),
                        SizedBox(height: 5,),
                        buildDropdown("لون العيون", "اختر لون العيون"),
                        SizedBox(height: 5,),
                        buildDropdown("لون الشعر", "اختر لون الشعر"),
                        SizedBox(height: 5,),
                        buildDropdown("علامات مميزة (اختياري)", "مثال: ندبة صغيرة فوق الحاجب"),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Container(
                  decoration: buildBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField("المحافظة", "مثال: القاهرة، الجيزة، الإسكندرية"),
                        SizedBox(height:5 ,),
                        buildDropdown("المنطقة", "مثال: مدينة نصر، المعادي، شبرا"),
                      ],
                ),
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Container(
                  decoration: buildBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField("التاريخ (حدد تاريخ آخر مشاهدة)","يوم/شهر/سنة")
             ],
          ),
        ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 50,left: 50,bottom: 35),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Text(
                      "إضافة",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              )

            ]
      ),
      ),
      ),
    );
  }

  Column buildTextField(String text, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xff92C1EB))
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xff92C1EB))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xff92C1EB))
            ),
          ),
        ),
      ],
    );
  }

  Column buildDropdown(String text , String hint){
    return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(text, style: TextStyle(
  fontSize: 24, fontWeight: FontWeight.w400),),
  DropdownButtonFormField<String>(
  decoration: InputDecoration(
  hintText: hint,
  hintStyle: TextStyle(
  color: Color(0xff92989B), fontSize: 16),
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: BorderSide(
  color: Color(0xff92C1EB))),
  focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: BorderSide(
  color: Color(0xff92C1EB))),
  enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: BorderSide(
  color: Color(0xff92C1EB))),
  ),
  items: [], onChanged: (_) {}),
  ],
  );
}

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              );
  }
}

class _GenderButton extends StatefulWidget {
  final Color color;
  final String imagePath;

  const _GenderButton({
    required this.color,
    required this.imagePath,
  });

  @override
  State<_GenderButton> createState() => _GenderButtonState();
}

class _GenderButtonState extends State<_GenderButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: widget.color),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(
              widget.imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}



