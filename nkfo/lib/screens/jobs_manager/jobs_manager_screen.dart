
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_cabinet_nkfo/screens/jobs_manager/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class JobsManagerScreen extends StatefulWidget {
  static const pageName = 'Менеджер заданий';

  @override
  _JobsManagerScreenState createState() => _JobsManagerScreenState();
}

class _JobsManagerScreenState extends State<JobsManagerScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;


  final List<Tab> tabs = const <Tab> [
    Tab(text: 'Назначенные задания'), 
    Tab(text: 'Части задания'), 
    Tab(text: 'Параметры запроса'), 
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    //_tabController?.addListener(onTap);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CabinetMenu(
            selectedIndex: 4,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: TabBar(
              controller: _tabController,
              onTap: (index) {},
              isScrollable: true,
              tabs: tabs,
              indicatorColor: AppStyles.mainColor,
              indicatorWeight: 4,
              labelStyle: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppStyles.mainColor
              ),
              labelColor: AppStyles.mainColor,
              overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF)),
              unselectedLabelColor: AppStyles.mainTextColor
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children:  [
                AssignedJobsTab(
                  tabController: _tabController!,
                ),
                JobsPart(),
                JobsPartParam()
              ],
            ),
          )
        ],
      ),
    ),
  );

  // void onTap () {
  //  final dataManager = InjectionComponent.getDependency<DataManager>();
  //  final _getIsAvaliableJobPart = AccessRightsHandler.getIsAvaliable(dataManager, EntityName.jobPart);

  //  if (!_getIsAvaliableJobPart) {

  //     _tabController?.index = 0;
   
  //     RequestUtil.catchNetworkError(
  //       context: context, 
  //       obj: AppConfig.getIsNotAvaliableJobPart
  //     );      
  //   }
  // }
}