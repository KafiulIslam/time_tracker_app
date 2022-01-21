import 'package:android_time_tracker/app/sign_in/home/model/job.dart';
import 'package:flutter/material.dart';

class JobListTile extends StatelessWidget {
  const JobListTile({@required this.job, this.onTap});

  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // void printFunc() {
    //   print('name in joblisttile class in text ');
    //   print(job.name);
    // }

    return ListTile(
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
