import 'package:flutter/material.dart';

class AddSub extends StatefulWidget {
  const AddSub({super.key});

  @override
  State<AddSub> createState() => _AddSubState();
}

class _GroupControllers {
  TextEditingController name = TextEditingController();
  TextEditingController code = TextEditingController();
  void dispose() {
    name.dispose();
    code.dispose();
  }
}

class _AddSubState extends State<AddSub> {
  List<_GroupControllers> _groupControllers = [];
  List<TextField> _nameFields = [];
  List<TextField> _codeFields = [];
  @override
  void dispose() {
    for (final controller in _groupControllers) {
      controller.dispose();
    }
    _okController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
          width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _addButton(),
                SizedBox(width: 5,),
                _remButton()

              ],
            ),
          ),
           
              Expanded(child: _listView()),
              _okButton(context),
        ],
      ),
    );
  }


  Widget _addButton() {
    return IconButton(onPressed: () {
      final group = _GroupControllers();

        final nameField = _generateTextField(group.name, "Course name");
        final codeField = _generateTextField(group.code, "Course code");

        setState(() {
          _groupControllers.add(group);
          _nameFields.add(nameField);
          _codeFields.add(codeField);
        });
      
    }, icon: Icon(Icons.add));
  }
  Widget _remButton(){
    return IconButton(onPressed: () {
      _groupControllers.removeLast();
      _nameFields.removeLast();
      setState(() {
        
      });
    }, icon: Icon(Icons.close));
  }
  Widget _listView() {
    final children = [
      for (var i = 0; i < _groupControllers.length; i++)
        Container(
          margin: EdgeInsets.all(5),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: (i+1).toString(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 180,
                  child: _nameFields[i],
                ),SizedBox(width: 5,),
                Container(
                  width: 180,
                  child: _codeFields[i],
                ),
                
              ],
            ),
          ),
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }
  TextField _generateTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hint,
      ),
    );
  }

  final _okController = TextEditingController();
  
  Widget _okButton(BuildContext context) {
    final textField = TextField(
      controller: _okController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );

    final button = ElevatedButton(
      onPressed: () async {
        final index = int.parse(_okController.text);
        String text = "name: ${_groupControllers[index].name.text}\n" +
            "tel: ${_groupControllers[index].code.text}\n" ;
        await showMessage(context, text, "Result");
      },
      child: const Text("OK"),
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: textField,
          width: 100,
          height: 50,
        ),

        button,
      ],
    );
  }

  Future<void> showMessage(BuildContext context, String msg, String title) async {
  final alert =  AlertDialog(
    title: Text(title),
    content: Text(msg),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("OK"),
      ),
    ],
  );
  await showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  );
}
}
