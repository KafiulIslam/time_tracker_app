import 'package:android_time_tracker/app/sign_in/home/account/account_page.dart';
import 'package:android_time_tracker/app/sign_in/home/cupertino_home_scaffold.dart';
import 'package:android_time_tracker/app/sign_in/home/entries_page.dart';
import 'package:android_time_tracker/app/sign_in/home/job/JobsPage.dart';
import 'package:android_time_tracker/app/sign_in/home/tab_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.job;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.job: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilder {
    return {
      TabItem.job: (_) => JobsPage(),
      TabItem.entries: (context) => EntriesPage.create(context),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[_currentTab]
          .currentState
          .popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilder: widgetBuilder,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
