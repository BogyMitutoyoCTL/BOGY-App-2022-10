import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageProcessing extends StatefulWidget {
  const ImageProcessing({Key? key}) : super(key: key);

  @override
  State<ImageProcessing> createState() => _ImageProcessingState();
}

class _ImageProcessingState extends State<ImageProcessing> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Image>(
      future: getImageData(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
          {
            return Center(
                child: Image(image: snapshot.data!.image));
          } // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }

  Future<Image> getImageData() async {
    var response = await http.get(Uri.parse(
        'https://images.pexels.com/photos/708587/pexels-photo-708587.jpeg?auto=compress&cs=tinysrgb&w=126&dpr=1'));
    var _base64 = base64Encode(response.bodyBytes);
    var _decodedImage = base64Decode(_base64);
    print(_base64);
    return Image.memory(_decodedImage);
  }
}
