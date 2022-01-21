import 'package:android_time_tracker/app/sign_in/home/job/edit_job_page.dart';
// import 'package:android_time_tracker/app/sign_in/home/job/empty_content.dart';
import 'package:android_time_tracker/app/sign_in/home/job/job_list_tile.dart';
import 'package:android_time_tracker/app/sign_in/home/job/list_item_builder.dart';
import 'package:android_time_tracker/app/sign_in/home/job_entries/job_entries_page.dart';
import 'package:android_time_tracker/app/sign_in/home/model/job.dart';
import 'package:android_time_tracker/common_widget/dialog_box.dart';
import 'package:android_time_tracker/common_widget/kafi_alert_dialog_box.dart';
// import 'package:android_time_tracker/common_widget/platform_alert_dialogue.dart';
// import 'package:android_time_tracker/services/auth.dart';
import 'package:android_time_tracker/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
  // Future<void> _createJob(BuildContext context) async {
  //   try {
  //     final database = Provider.of<Database>(context, listen: false);
  //     await database.setJob(Job(name: 'Blogging', ratePerHour: 10));
  //   } on PlatformException catch (e) {
  //     PlatformExceptionAlertDialog(
  //       title: 'Operation Failed',
  //       exception: e,
  //     ).show(context);
  //   }
  // }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context);
      print('delete function is working in provider');
      await database.deleteJob(job);
    } catch (e) {
      KafiAlertDialog(
        title: 'Sorry !',
        content: 'Something went Wrong.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            'Jobs',
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                EditJobPage.show(
                  context,
                  database: Provider.of<Database>(context, listen: false),
                );
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    //    final String documentId;
    //    final String name;
    //    final String ratePerHour;
    //
    // final job = new Job(id: , name: name, ratePerHour: ratePerHour)
    //    print("jobname in joblist tile :");
    //    print(job.name);

    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          return ListItemBuilder(
            snapshot: snapshot,
            itemBuilder: (context, job) => Dismissible(
              key: Key('jobs-${job.id}'),
              background: Container(
                color: Colors.red,
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _delete(context, job),
              child: JobListTile(
                job: job,
                onTap: () => JobEntriesPage.show(context, job),
              ),
            ),
          );
        });
  }
}
