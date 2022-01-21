// import 'package:android_time_tracker/app/sign_in/home/job/job_list_tile.dart';
import 'package:android_time_tracker/app/sign_in/home/model/job.dart';
import 'package:android_time_tracker/common_widget/kafi_alert_dialog_box.dart';
// import 'package:android_time_tracker/common_widget/platform_alert_dialogue.dart';
import 'package:android_time_tracker/common_widget/platform_exception_alert_dialog.dart';
import 'package:android_time_tracker/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key, this.database, this.job}) : super(key: key);
  final Database database;
  final Job job;

  static Future<void> show(BuildContext context,
      {Database database, Job job}) async {
    // final database = Provider.of<Database>(context, listen: false);

    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => EditJobPage(
        database: database,
        job: job,
      ),
      fullscreenDialog: true,
    ));
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _ratePerHour;

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
      print('the name in initstate $_name');
    }
    // final JobListTile jlt = new JobListTile(job: widget.job);
    // jlt.printFunc();
  }

  bool validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (validateAndSaveForm()) {
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();

        if (widget.job != null) {
          allNames.remove(widget.job.name);
        }
        if (allNames.contains(_name)) {
          showDialog(
              context: context,
              builder: (context) {
                return KafiAlertDialog(
                  title: 'This name is existed already',
                  content: 'Please choose a different job name',
                );
              });
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(id: id, name: _name, ratePerHour: _ratePerHour);
          await widget.database.setJob(job);
          Navigator.pop(context);
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation Failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job == null ? 'New Job' : 'Edit Job'),
        actions: [
          TextButton(
              onPressed: () {
                _submit();
                print('the name in edit page save button : ');
                print(widget.job.name);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildFormChildren(),
        ));
  }

  List<Widget> _buildFormChildren() {
    final FocusNode _nameFocusNode = FocusNode();
    final FocusNode _rateFocusNode = FocusNode();

    return [
      TextFormField(
        initialValue: _name,
        focusNode: _nameFocusNode,
        decoration: InputDecoration(labelText: 'Job Offer'),
        validator: (value) =>
            value.isNotEmpty ? null : "name field can not be empty",
        onSaved: (value) {
          _name = value;
        },
      ),
      TextFormField(
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        focusNode: _rateFocusNode,
        decoration: InputDecoration(
          labelText: 'Rate per hour',
        ),
        onSaved: (value) {
          _ratePerHour = int.tryParse(value) ?? 0;
        },
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
      ),
    ];
  }
}
