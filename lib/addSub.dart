import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssjapp1/models/subject_model.dart';

import 'database/subject_db.dart';


class InsertSubjectPage extends StatefulWidget {
  const InsertSubjectPage({super.key});

  @override
  State<InsertSubjectPage> createState() => _InsertSubjectPageState();
}

class _InsertSubjectPageState extends State<InsertSubjectPage> {
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context,true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context,true);
          },
        )),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: textController1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Subject Name',
                ),
              ),
              TextField(
                controller: textController2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Subject Code',
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    Subject subject = new Subject(
                        subname: textController1.text,
                        subcode: textController2.text);
                    await DatabaseHelper.instance.add(subject);
                    setState(() {
                      textController1.clear();
                      textController2.clear();
                      // selectedId = null;
                    });
                  },
                  child: Text('Enter'))
            ]),
      ),
    );
  }
}
