import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditQuestion extends StatefulWidget {
  const EditQuestion({Key? key}) : super(key: key);

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  //false = Frage; true = Bild
  bool questionType = false;
  final TextEditingController _titleControll = TextEditingController();
  String _title = "";
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _titleControll.text = _title;
    _titleControll.addListener(() {
      setState(() {
        _title = _titleControll.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Karte bearbeiten"),
      ),
      body: Column(
        children: [
          RadioListTile(
            value: false,
            groupValue: questionType,
            onChanged: questionTypeChange,
            title: Text("Frage"),
          ),
          RadioListTile(
            value: true,
            groupValue: questionType,
            onChanged: questionTypeChange,
            title: Text("Bild"),
          ),
          Text("Frage:"),
          TextField(
            controller: _titleControll,
          ),
        ],
      ),
    );
  }
}

void questionTypeChange(bool? type) {}
