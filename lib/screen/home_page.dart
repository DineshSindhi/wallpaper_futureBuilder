// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;
// import 'package:wallpaper_api/domain/ui_helper.dart';
// import 'package:wallpaper_api/screen/search_page.dart';
//
// import 'details_wall.dart';
// import '../model/data_page.dart';
//
// class HomePage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Wallpaper'),backgroundColor: Colors.blueGrey,centerTitle: true, actions: [
//         InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder:  (context) => SearchPage(),));
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(Icons.search,size: 32,),
//             ))
//       ],),
//       body: FutureBuilder(
//         future: getWallpaper('all'),
//         builder: (_,snap){
//           if(snap.connectionState==ConnectionState.waiting){
//             return Center(child: CircularProgressIndicator(),);
//           }else if(snap.hasError){
//             return Center(child: Text('${snap.error}'),);
//           }else if(snap.hasData){
//             return GridView.builder(
//               itemCount: snap.data!.photos!.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 9/15
//               ), itemBuilder: (context, index) {
//                 var mData=snap.data!.photos![index];
//               return InkWell(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsWall(mIndex: index,model: snap.data!,),));
//                 },
//                 child: Hero(
//                   tag: '$index',
//                   child: Container(
//                     margin: EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: Colors.blueGrey,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                         child: Image.network('${mData.src!.portrait}',fit: BoxFit.fill,)),
//                   ),
//                 ),
//               );
//             },);
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:http/http.dart'as http;

import '../model/data_page.dart';

Future<DataModel?>getSearchWallpaper({required String wType ,String color='',int page= 1 })async{
  DataModel? wall;
  String url='https://api.pexels.com/v1/search?query=$wType&per_page=16&color=$color&page=$page';
  var response=await http.get(Uri.parse(url),
      headers:{'Authorization': 'QIaZFt9m8QO4wY327frFMidOVsz2QQ27DR4RpaeyZncQ2NAWEGJ0vrhb'});
  if(response.statusCode==200){
    var mData=response.body;
    //print(mData);
    var rawData=jsonDecode(mData);
    wall=DataModel.fromJson(rawData);
  }
  return wall;
}
Future<DataModel?>getWallpaper()async{
  DataModel? wall;
  String url='https://api.pexels.com/v1/curated?per_page=50';
  var response=await http.get(Uri.parse(url),
      headers:{'Authorization': 'QIaZFt9m8QO4wY327frFMidOVsz2QQ27DR4RpaeyZncQ2NAWEGJ0vrhb'});
  if(response.statusCode==200){
    var mData=response.body;
    //print(mData);
    var rawData=jsonDecode(mData);
    wall=DataModel.fromJson(rawData);
  }
  return wall;
}
