import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssjapp1/models/subject_model.dart';

import 'database/subject_db.dart';

class ShowSub extends StatefulWidget {
  const ShowSub({super.key});

  @override
  State<ShowSub> createState() => _ShowSubState();
}

class _ShowSubState extends State<ShowSub> {
  // late List<Subject> Subjects;
  // bool isLoading = false;
  // DatabaseHelper dbhelp= DatabaseHelper();
  @override


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
        FutureBuilder<List<Subject>>(
          future: DatabaseHelper.instance.getSubjects(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Loading....'),
              );
            }
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text('No Subjects Entered'),
                  )
                : ListView(
                    children: snapshot.data!.map((subject) {
                    return Center(
                      child: Card(
                        // color: selectedId == grocery.id
                        //     ? Colors.white70
                        //     : Colors.white,
                        child: ListTile(
                          title: Text(subject.subname),
                          subtitle: Text(subject.subcode.toString()),
                          // onTap: () {
                          //   setState(() {
                          //     if(selectedId==null){
                          //     textController.text= grocery.name;
                          //     selectedId= grocery.id;
                          //     } else{
                          //       textController.text='';
                          //       selectedId=null;
                          //     }
                          //   });
                          // },
                          onLongPress: () {
                            setState(() {
                            DatabaseHelper.instance.remove(subject.id!);

                            });
                          },
                        ),
                      ),
                    );
                  }).toList());
          },
        ),
        //  isLoading
        //     ? CircularProgressIndicator()
        //     : subjects.isEmpty
        //         ? Text(
        //             'No Subjects added',
        //             style: TextStyle(color: Colors.white, fontSize: 24),
        //           )
        //         :
  //                FutureBuilder<List<Subject>>(
  // future: DatabaseHelper.instance.getAllSubjects(),
  // builder: (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
  //   if (!snapshot.hasData) {
  //     return Center(child: Text('Loading....'),);
  //   }
  //    return snapshot.data!.isEmpty ? Center(
  //             child: Text('No Groceries in the List'),
  //           ):
  //           ListView(
  //             children: snapshot.data!.map((sub) {
  //               return Center(
  //                 child: ListTile(
  //                   title: Text(sub.subName!),
  //                 ),
  //               );
  //             }).toList()

  //           );
      // ListView.builder(
      //   itemCount: snapshot.data!.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     Subject subject = snapshot.data![index];
      //     return ListTile(
      //       title: Text(subject.subName),
      //       subtitle: Text(subject.subCode),
      //     );
      //   },
      // );
    // } else {
    //   return CircularProgressIndicator();
    // }
//   },
// )
      ),
    );
  }
}
