// ignore_for_file: prefer_final_fields, prefer_const_constructors, unused_local_variable

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnhub/DataHelper/QuestionBasic.dart';
import 'package:learnhub/DataHelper/QuestionStringAndAnswers.dart';
import 'package:learnhub/DataHelper/QuestionStringAndFreeText.dart';
import 'package:learnhub/DataHelper/QuestionTypes.dart';

class EditQuestion extends StatefulWidget {
  QuestionBasic frage;

  EditQuestion(this.frage, {Key? key}) : super(key: key);

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  bool _isPictureQuestion = false;
  bool _isMultipleChoice = false;
  String? _image_base64;
  final TextEditingController _titleController = TextEditingController();
  List<TextEditingController> answerControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<String> _answer = ["", "", "", "", ""];
  final ImagePicker _picker = ImagePicker();

  String getFragenTitel() {
    if (_isPictureQuestion) {
      return "";
    } else {
      if (_isMultipleChoice) {
        QuestionStringAndAnswers textMultipleFrage =
            widget.frage as QuestionStringAndAnswers;
        return textMultipleFrage.question;
      } else {
        QuestionStringAndFreeText textBenutzerFrage =
            widget.frage as QuestionStringAndFreeText;
        return textBenutzerFrage.question;
      }
    }
  }

  void setRadioButtons() {
    if (widget.frage.questionType == QuestionTypes.stringAndFreeText) {
      _isMultipleChoice = false;
      _isPictureQuestion = false;
    } else if (widget.frage.questionType == QuestionTypes.stringAndAnswers) {
      _isMultipleChoice = true;
      _isPictureQuestion = false;
    }
  }

  @override
  void initState() {
    super.initState();
    setRadioButtons();
    print(_image_base64);
    _titleController.text = getFragenTitel();
    setAntwort();
  }

  void setAntwort() {
    if (widget.frage.questionType == QuestionTypes.stringAndFreeText) {
      _isMultipleChoice = false;
      _isPictureQuestion = false;
      QuestionStringAndFreeText textBenutzerFrage =
          widget.frage as QuestionStringAndFreeText;
      answerControllers[0].text = textBenutzerFrage.answer;
    } else if (widget.frage.questionType == QuestionTypes.stringAndAnswers) {
      _isMultipleChoice = true;
      _isPictureQuestion = false;
      QuestionStringAndAnswers textBenutzerFrage =
          widget.frage as QuestionStringAndAnswers;
      answerControllers[0].text = textBenutzerFrage.answers[0];
      answerControllers[1].text = textBenutzerFrage.answers[1];
      answerControllers[2].text = textBenutzerFrage.answers[2];
      answerControllers[3].text = textBenutzerFrage.answers[3];
    }
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
                            if (_image_base64 != null)
                              Image(
                                  image:
                                      Image.memory(base64Decode(_image_base64!)).image),
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
                    multipleChoiceWidgets()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: save,
        child: const Icon(Icons.check),
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
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      var imagepath = pickedImage.path;
      File imagefile = File(imagepath); //convert Path to File
      var imagebytes = await imagefile.readAsBytes(); //convert to bytes
      String base64string = base64.encode(imagebytes); //convert bytes to base64 string
      _image_base64 = base64string;
      setState(() {});
    }
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
    if (_isPictureQuestion) {
      //TODO: Bild speichern
    } else {
      String fragenname = _titleController.text;
      if (_isMultipleChoice) {
        String antwortnamerichtig = answerControllers[0].text;
        String antwortnamefalsch1 = answerControllers[1].text;
        String antwortnamefalsch2 = answerControllers[2].text;
        String antwortnamefalsch3 = answerControllers[3].text;
        QuestionStringAndAnswers frageMultiple = QuestionStringAndAnswers(
          question: fragenname,
          answers: [
            antwortnamerichtig,
            antwortnamefalsch1,
            antwortnamefalsch2,
            antwortnamefalsch3
          ],
        );
        Navigator.of(context).pop(frageMultiple);
      } else {
        String antwortnamerichtig = answerControllers[0].text;
        QuestionStringAndFreeText frageEingabe = QuestionStringAndFreeText(
            question: fragenname, answer: antwortnamerichtig);
        Navigator.of(context).pop(frageEingabe);
      }
    }
  }

  deleteStack() {}
}
