import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/main.dart';
import 'package:schedule/pages/all/afternoon/afternoon_view.dart';
import 'package:schedule/pages/all/morning/morning_view.dart';
import 'package:styled_widget/styled_widget.dart';

import 'all_logic.dart';

class AllPage extends StatefulWidget {
  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> with SingleTickerProviderStateMixin {
  final logic = Get.put(AllLogic());

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All construction'),
        backgroundColor: Colors.white,
      ),
      body: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    indicator: UnderlineTabIndicator(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                        borderSide:
                            BorderSide(width: 2.0, color: primaryColor)),
                    tabs: const [
                      SizedBox(
                          width: double.infinity,
                          child: Tab(
                            text: "Morning",
                            height: 40,
                          )),
                      SizedBox(
                          width: double.infinity,
                          child: Tab(
                            text: "Afternoon",
                            height: 40,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ).decorated(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        const SizedBox(height: 10,),
        Expanded(
            child: Container(
          width: double.infinity,
          child: TabBarView(
            controller: _tabController,
            children: [MorningPage(), AfternoonPage()],
          ),
        ))
      ].toColumn().marginAll(12),
    );
  }

  @override
  void dispose() {
    Get.delete<AllLogic>();
    super.dispose();
  }
}
