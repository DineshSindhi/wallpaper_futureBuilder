
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_api/screen/search_data.dart';

class SearchPage extends StatefulWidget {

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var wallController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: wallController,
                decoration: InputDecoration(
                    filled: true,
                    hintText: 'Search',
                    suffixIcon: InkWell(
                        onTap: (){
                          if(wallController.text.isNotEmpty){
                         // newsController.text;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchData(value: wallController.text,),));
                        }
                          },
                        child: Icon(Icons.search,size: 30,)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)
                    )
                ),),
            ),
          ),
        ],
      ),
    );
  }
}