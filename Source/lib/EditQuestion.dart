import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnhub/EditDeck.dart';

class EditQuestion extends StatefulWidget {
  const EditQuestion({Key? key}) : super(key: key);

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  //false = Frage; true = Bild
  bool _questionType = false;
  //false = Benutzereingabe; true = MultipleChoice
  bool _answerType = false;
  final TextEditingController _titleControll = TextEditingController();
  final TextEditingController _rightAnswerControll = TextEditingController();
  final TextEditingController _falseAnswerControll1 = TextEditingController();
  final TextEditingController _falseAnswerControll2 = TextEditingController();
  final TextEditingController _falseAnswerControll3 = TextEditingController();
  String _title = "";
  List<String> _answer = ["", "", "", "", ""];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _titleControll.text = _title;
    _rightAnswerControll.text = _answer[0];
    _falseAnswerControll1.text = _answer[1];
    _falseAnswerControll2.text = _answer[2];
    _falseAnswerControll3.text = _answer[3];

    _titleControll.addListener(() {
      setState(() {
        _title = _titleControll.text;
      });
    });
    _rightAnswerControll.addListener(() {
      setState(() {
        _answer[0] = _rightAnswerControll.text;
      });
    });

    _falseAnswerControll1.addListener(() {
      setState(() {
        _answer[1] = _falseAnswerControll1.text;
      });
    });
    _falseAnswerControll2.addListener(() {
      setState(() {
        _answer[2] = _falseAnswerControll2.text;
      });
    });
    _falseAnswerControll3.addListener(() {
      setState(() {
        _answer[3] = _falseAnswerControll3.text;
      });
    });
  }

  @override
  void dispose() {
    _titleControll.dispose();
    _rightAnswerControll.dispose();
    _falseAnswerControll1.dispose();
    _falseAnswerControll2.dispose();
    _falseAnswerControll3.dispose();
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
                  groupValue: _questionType,
                  onChanged: questionTypeChange,
                  title: Text("Frage"),
                ),
                RadioListTile(
                  value: true,
                  groupValue: _questionType,
                  onChanged: questionTypeChange,
                  title: const Text("Bild"),
                ),
                if (!_questionType)
                  TextField(
                    controller: _titleControll,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Frage",
                    ),
                  ),
                if (_questionType) const Text("Bild:"),
                if (_questionType)
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
                  groupValue: _answerType,
                  onChanged: answerTypeChange,
                  title: Text("Benutzereingabe"),
                ),
                RadioListTile(
                  value: true,
                  groupValue: _answerType,
                  onChanged: answerTypeChange,
                  title: const Text("Multiple Choice"),
                ),
                TextField(
                  controller: _falseAnswerControll1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Richtige Antwort",
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                if (_answerType)
                  TextField(
                    controller: _falseAnswerControll2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Falsche Antwort",
                    ),
                  ),
                const Padding(padding: EdgeInsets.all(8.0)),
                if (_answerType)
                  TextField(
                    controller: _falseAnswerControll3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Falsche Antwort",
                    ),
                  ),
                const Padding(padding: EdgeInsets.all(8.0)),
                if (_answerType)
                  TextField(
                    controller: _rightAnswerControll,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Falsche Antwort",
                    ),
                  ),
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

  Future<void> importPic() async {
    //Funkt nur unter Android
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  void questionTypeChange(bool? type) {
    setState(() {
      _questionType = type!;
    });
  }

  void answerTypeChange(bool? type) {
    setState(() {
      _answerType = type!;
    });
  }

  void save() {
    //Speichern
    Navigator.of(context).pop(EditDeck()); //Zur Homo seite
  }
}
