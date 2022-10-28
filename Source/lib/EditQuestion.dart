// ignore_for_file: prefer_final_fields, prefer_const_constructors, unused_local_variable, avoid_print, unused_field, unused_import, must_be_immutable, file_names, non_constant_identifier_names

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnhub/DataHelper/QuestionBasic.dart';
import 'package:learnhub/DataHelper/QuestionImageAndFreeText.dart';
import 'package:learnhub/DataHelper/QuestionImageAndSingleChoice.dart';
import 'package:learnhub/DataHelper/QuestionStringAndAnswers.dart';
import 'package:learnhub/DataHelper/QuestionStringAndFreeText.dart';
import 'package:learnhub/DataHelper/QuestionTypes.dart';

class EditQuestion extends StatefulWidget {
  QuestionBasic question;

  EditQuestion(this.question, {Key? key}) : super(key: key);

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  bool _validateTitle = false;
  List<bool> _validateAnswer = [false, false, false, false];
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
            widget.question as QuestionStringAndAnswers;
        return textMultipleFrage.question;
      } else {
        QuestionStringAndFreeText textBenutzerFrage =
            widget.question as QuestionStringAndFreeText;
        return textBenutzerFrage.question;
      }
    }
  }

  void setRadioButtons() {
    if (widget.question.questionType == QuestionTypes.stringAndFreeText) {
      _isMultipleChoice = false;
      _isPictureQuestion = false;
    } else if (widget.question.questionType == QuestionTypes.stringAndAnswers) {
      _isMultipleChoice = true;
      _isPictureQuestion = false;
    } else if (widget.question.questionType == QuestionTypes.imageAndFreeText) {
      _isMultipleChoice = false;
      _isPictureQuestion = true;
    } else if (widget.question.questionType ==
        QuestionTypes.imageAndSingleChoice) {
      _isMultipleChoice = true;
      _isPictureQuestion = true;
    }
  }

  @override
  void initState() {
    super.initState();
    setRadioButtons();
    _titleController.text = getFragenTitel();
    setAntwort();
  }

  void setAntwort() {
    if (widget.question.questionType == QuestionTypes.stringAndFreeText) {
      _isMultipleChoice = false;
      _isPictureQuestion = false;
      var questionStringAndFreeText = widget.question as QuestionStringAndFreeText;
      answerControllers[0].text = questionStringAndFreeText.answer;
    } else if (widget.question.questionType == QuestionTypes.stringAndAnswers) {
      _isMultipleChoice = true;
      _isPictureQuestion = false;
      var questionStringAndAnswers = widget.question as QuestionStringAndAnswers;
      answerControllers[0].text = questionStringAndAnswers.answers[0];
      answerControllers[1].text = questionStringAndAnswers.answers[1];
      answerControllers[2].text = questionStringAndAnswers.answers[2];
      answerControllers[3].text = questionStringAndAnswers.answers[3];
    } else if (widget.question.questionType ==
        QuestionTypes.imageAndSingleChoice) {
      _isMultipleChoice = true;
      _isPictureQuestion = true;
      var questionImageAndSingleChoice =
          widget.question as QuestionImageAndSingleChoice;
      answerControllers[0].text = questionImageAndSingleChoice.answers[0];
      answerControllers[1].text = questionImageAndSingleChoice.answers[1];
      answerControllers[2].text = questionImageAndSingleChoice.answers[2];
      answerControllers[3].text = questionImageAndSingleChoice.answers[3];
      _image_base64 = questionImageAndSingleChoice.imageString;
      ;
    } else if (widget.question.questionType == QuestionTypes.imageAndFreeText) {
      _isMultipleChoice = false;
      _isPictureQuestion = true;
      var questionImageAndFreeText = widget.question as QuestionImageAndFreeText;
      answerControllers[0].text = questionImageAndFreeText.answer;
      _image_base64 = questionImageAndFreeText.imageString;
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
                          maxLength: 50,
                          controller: _titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Frage",
                            errorText: _validateTitle
                                ? "Frage muss gesetzt werden"
                                : null,
                          ),
                        ),
                      if (_isPictureQuestion) const Text("Bild:"),
                      if (_isPictureQuestion)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_image_base64 != null)
                              Image(
                                  width: 50,
                                  image:
                                      Image.memory(base64Decode(_image_base64!))
                                          .image),
                            IconButton(
                              onPressed: () => importPic(ImageSource.gallery),
                              icon: const Icon(Icons.image),
                            ),
                            IconButton(
                              onPressed: () => importPic(ImageSource.camera),
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
                        maxLength: 40,
                        controller: answerControllers[0],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Richtige Antwort",
                          errorText: _validateAnswer[0]
                              ? "Richtige Antwort muss gesetzt werden"
                              : null,
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
        maxLength: 40,
        controller: answerControllers[i],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Falsche Antwort",
          errorText:
              _validateAnswer[i] ? "Falsche Antwort muss gesetzt werden" : null,
        ),
      ));
    }
    return widgets;
  }

  Future<void> importPic(ImageSource imageSource) async {
    XFile? pickedImage = await _picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      var imagebytes = await pickedImage.readAsBytes();
      String base64string =
          base64.encode(imagebytes); //convert bytes to base64 string
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
    setState(() {
      _titleController.text.replaceAll(" ", "").isEmpty
          ? _validateTitle = true
          : _validateTitle = false;
      answerControllers[0].text.replaceAll(" ", "").isEmpty
          ? _validateAnswer[0] = true
          : _validateAnswer[0] = false;
      if (_isMultipleChoice) {
        for (int i = 1; i < 4; i++) {
          answerControllers[i].text.replaceAll(" ", "").isEmpty
              ? _validateAnswer[i] = true
              : _validateAnswer[i] = false;
        }
      }
    });
    if (_titleController.text.replaceAll(" ", "").isEmpty &&
        !_isPictureQuestion) return;
    if (answerControllers[0].text.replaceAll(" ", "").isEmpty) return;
    if (_isMultipleChoice) {
      for (int i = 1; i < 4; i++) {
        if (answerControllers[i].text.replaceAll(" ", "").isEmpty) return;
      }
    }
    //Keine gleichen Antworten
    if (answerControllers[0].text.replaceAll(" ", "").toLowerCase() !=
            answerControllers[1].text.replaceAll(" ", "").toLowerCase() &&
        answerControllers[0].text.replaceAll(" ", "").toLowerCase() !=
            answerControllers[2].text.replaceAll(" ", "").toLowerCase() &&
        answerControllers[0].text.replaceAll(" ", "").toLowerCase() !=
            answerControllers[3].text.replaceAll(" ", "").toLowerCase()) {
      // TODO: Speichern

      if (_isPictureQuestion) {
        if (_isMultipleChoice) {
          GenerateQuestionImageAndSingleChoice();
        } else {
          GenerateQuestionImageAndFreeText();
        }
      } else {
        if (_isMultipleChoice) {
          GenerateQuestionStringAndAnswers();
        } else {
          GenerateQuestionStringAndFreeText();
        }
      }
    }
  }

  void GenerateQuestionStringAndFreeText() {
    var questionStringAndFreeText = QuestionStringAndFreeText(
        question: _titleController.text, answer: answerControllers[0].text);
    Navigator.of(context).pop(questionStringAndFreeText);
  }

  void GenerateQuestionImageAndFreeText() {
    var questionImageAndFreeText = QuestionImageAndFreeText(
        imageString: _image_base64!, answer: answerControllers[0].text);
    Navigator.of(context).pop(questionImageAndFreeText);
  }

  void GenerateQuestionStringAndAnswers() {
    var questionStringAndAnswers = QuestionStringAndAnswers(
      question: _titleController.text,
      answers: [
        answerControllers[0].text,
        answerControllers[1].text,
        answerControllers[2].text,
        answerControllers[3].text
      ],
    );
    Navigator.of(context).pop(questionStringAndAnswers);
  }

  void GenerateQuestionImageAndSingleChoice() {
    var questionImageAndSingleChoice = QuestionImageAndSingleChoice(
      imageString: _image_base64!,
      answers: [
        answerControllers[0].text,
        answerControllers[1].text,
        answerControllers[2].text,
        answerControllers[3].text
      ],
    );
    Navigator.of(context).pop(questionImageAndSingleChoice);
  }

  deleteStack() {}
}
