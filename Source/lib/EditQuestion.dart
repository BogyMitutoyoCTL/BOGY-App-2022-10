// ignore_for_file: prefer_final_fields, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditQuestion extends StatefulWidget {
  const EditQuestion({Key? key}) : super(key: key);

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  bool _isPictureQuestion = false;
  bool _isMultipleChoice = false;
  final TextEditingController _titleController = TextEditingController();
  List<TextEditingController> answerControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  String _title = "";
  List<String> _answer = ["", "", "", "", ""];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _titleController.text = _title;
    for (int i = 0; i < 4; i++) {
      answerControllers[i].text = _answer[i];
      answerControllers[i].addListener(() {
        setState(() {
          _answer[i] = answerControllers[i].text;
        });
      });
    }

    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (int i = 0; i < 4; i++) {
      answerControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Karte bearbeiten"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                    RadioListTile(
                      value: false,
                      groupValue: _isPictureQuestion,
                      onChanged: questionTypeChange,
                      title: Text("Frage"),
                    ),
                    RadioListTile(
                      value: true,
                      groupValue: _isPictureQuestion,
                      onChanged: questionTypeChange,
                      title: const Text("Bild"),
                    ),
                    if (!_isPictureQuestion)
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Frage",
                        ),
                      ),
                    if (_isPictureQuestion) const Text("Bild:"),
                    if (_isPictureQuestion)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: importPic,
                            icon: const Icon(Icons.image),
                          ),
                          IconButton(
                            onPressed: importPic,
                            icon: const Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                    RadioListTile(
                      value: false,
                      groupValue: _isMultipleChoice,
                      onChanged: answerTypeChange,
                      title: Text("Benutzereingabe"),
                    ),
                    RadioListTile(
                      value: true,
                      groupValue: _isMultipleChoice,
                      onChanged: answerTypeChange,
                      title: const Text("Multiple Choice"),
                    ),
                    TextField(
                      controller: answerControllers[0],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Richtige Antwort",
                      ),
                    )
                  ] +
                  multipleChoiceWidgets() +
                  [
                    const Padding(padding: EdgeInsets.all(8.0)),
                    FloatingActionButton(
                      onPressed: save,
                      child: const Icon(Icons.check),
                    ),
                  ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> multipleChoiceWidgets() {
    List<Widget> widgets = [];
    if (!_isMultipleChoice) return widgets;

    for (int i = 1; i < 4; i++) {
      widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
      widgets.add(TextField(
        controller: answerControllers[i],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Falsche Antwort",
        ),
      ));
    }
    return widgets;
  }

  Future<void> importPic() async {
    //Funkt nur unter Android
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  void questionTypeChange(bool? type) {
    setState(() {
      _isPictureQuestion = type!;
    });
  }

  void answerTypeChange(bool? type) {
    setState(() {
      _isMultipleChoice = type!;
    });
  }

  void save() {
    // TODO: Speichern
    Navigator.of(context).pop(); //Zur Home seite
  }
}
