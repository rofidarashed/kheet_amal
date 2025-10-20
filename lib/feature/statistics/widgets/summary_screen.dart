
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';



class SummaryScreen1 extends StatefulWidget {
  const SummaryScreen1({super.key});

  @override
  State<SummaryScreen1> createState() => _SummaryScreen1State();
}

class _SummaryScreen1State extends State<SummaryScreen1> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF4F5F6),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 16,left: 16,top: 10),
            child: Column(
              children: [
                Container(
                  decoration: buildBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("عدد الحالات المبلغ عنها والمستردة شهرياً",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                        SizedBox(height: 14,),
                        Padding(
                          padding: const EdgeInsets.only(right: 8,left: 8,bottom: 10),
                          child: Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: Color(0xff1976D2),
                                        ),
                                        Text(" 80 ",style: TextStyle(fontSize: 16),),
                                        Text(" مفقودين",style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: Color(0xffFB8C00),
                                        ),
                                        Text(" 70 ",style: TextStyle(fontSize: 16),),
                                        Text(" مشكوك بهم",style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: Color(0xff4CAF50),
                                        ),
                                        Text(" 50 ",style: TextStyle(fontSize: 16),),
                                        Text(" تم العثور عليهم",style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                  ]
                              ),
                              Spacer(),
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 190,
                                    width: 190,
                                    child: PieChart(
                                      PieChartData(
                                          sections:[
                                            PieChartSectionData(value: 70, color: Color(0xffFB8C00),showTitle: false),
                                            PieChartSectionData(value: 80, color: Color(0xff1976D2),showTitle: false),
                                            PieChartSectionData(value: 50, color: Color(0xff4CAF50),showTitle: false),
                                          ]
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 60,right: 60,left: 54,bottom: 50),
                                    child: Text("200+ ",style: TextStyle(fontSize: 30),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 79,top: 95,bottom: 50,right: 75),
                                    child: Text("حالة",style: TextStyle(fontSize: 20,color: Color(0xff92989B)),),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
              Container(
                decoration: buildBoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("التوزيع حسب العمر",style: TextStyle(fontSize: 20),),
                      SizedBox(height: 15,),
                      SizedBox(
                        height: 270,
                        width: 375,
                        child:AspectRatio(
                          aspectRatio: 1.7,
                          child: BarChart(
                            BarChartData(
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: true,
                                border: const Border(
                                  left: BorderSide(color: Colors.black54, width: 2),
                                  bottom: BorderSide(color: Colors.black54, width: 2),
                                ),
                              ),
                              titlesData: FlTitlesData(
                                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 28,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: const TextStyle(fontSize: 10),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return const Text("0-3");
                                        case 1:
                                          return const Text("4-7");
                                        case 2:
                                          return const Text("8-12");
                                        case 3:
                                          return const Text("13-17");
                                      }
                                      return const Text("");
                                    },
                                  ),
                                ),
                              ),
                              barGroups: [
                                makeGroupData(0, 15, 8, 5),
                                makeGroupData(1, 55, 15, 20),
                                makeGroupData(2, 45, 20, 25),
                                makeGroupData(3, 35, 12, 18),
                              ],
                              groupsSpace: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          LegendItem(color: Color(0xffFB8C00), text: 'مشكوك به'),
                          SizedBox(width: 12),
                          LegendItem(color: Color(0xff4CAF50), text: 'تم العثور عليه'),
                          SizedBox(width: 12),
                          LegendItem(color: Color(0xff2196F3), text: 'مفقود'),
                        ],
                      ),
                      SizedBox(height: 10,),
                  const Text(
                    "إستنتاج",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 13, color: Colors.black),
                        children: [
                          TextSpan(text: "- أكثر الفئات عرضة: ",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                          TextSpan(
                            text: "8-12 سنة",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: "\n- انخفاض في الحالات من 0-3 سنوات"),
                        ],
                      ),
                  ),
                    ]
                  ),
                ),
              ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: Colors.white,
  );
}

BarChartGroupData makeGroupData(int x, double found, double missing, double suspected) {
  return BarChartGroupData(
    x: x,
    barsSpace: 4,
    barRods: [
      BarChartRodData(toY: found, color: const Color(0xff2196F3), width: 16, borderRadius: BorderRadius.circular(0)),
      BarChartRodData(toY: suspected, color: const Color(0xffFB8C00), width: 16, borderRadius: BorderRadius.circular(0)),
      BarChartRodData(toY: missing, color: const Color(0xff4CAF50), width: 16, borderRadius: BorderRadius.circular(0)),
    ],
  );
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 14, color: color),
        ),
        const SizedBox(width: 4),
        Container(
          width: 20,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
      ],
    );
  }
}