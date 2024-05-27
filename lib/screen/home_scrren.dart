
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpaper_api/domain/ui_helper.dart';
import 'package:wallpaper_api/screen/search_data.dart';
import 'details_wall.dart';
import 'home_page.dart';

class HomePageM extends StatelessWidget {
  var wallController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Wallpaper'),backgroundColor: Colors.blueGrey,centerTitle: true,),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: wallController,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Search',
                  suffixIcon: InkWell(
                      onTap: (){

                        if(wallController.text.isNotEmpty){
                          // newsController.text;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchData(value: wallController.text,),));
                        }

                      },
                      child: Icon(Icons.search,size: 30,)),

                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)
                  )
              ),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Best of the month',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 23),),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child:FutureBuilder(
              future: getWallpaper(),
              builder: (_,snap){
                if(snap.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }else if(snap.hasError){
                  return Center(child: Text('${snap.error}'),);
                }else if(snap.hasData){
                  return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snap.data!.photos!.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 500,
                        mainAxisExtent: 200
                        //childAspectRatio: 9/15
                    ), itemBuilder: (context, index) {
                    var mData=snap.data!.photos![index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsWall(mIndex: index,model: snap.data!,),));
                      },
                      child: Hero(
                        tag: '$index',
                        child: Container(
                          margin: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network('${mData.src!.portrait}',fit: BoxFit.fill,)),
                        ),
                      ),
                    );
                  },);
                }
                return Container();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('The color tone',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 23),),
              ],
            ),
          ),
          SizedBox(
            height: 80,
            child: GridView.builder(
             scrollDirection: Axis.horizontal,
              itemCount: AppConst.listCol.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
              ), itemBuilder: (c, i) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchData(
                      value: wallController.text.isNotEmpty?wallController.text:"Nature",mColor: AppConst.listCol[i]['code'],)));
                 

                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: (AppConst.listCol[i]['color']),
                  ),
                  margin: EdgeInsets.all(7),
                ),
              );
            },),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('Categories',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 23),),
              ],
            ),
          ),
          SizedBox(
            height: 350,
            child: GridView.builder(

              physics: NeverScrollableScrollPhysics(),
              itemCount: AppConst.listCat.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4/3

              ), itemBuilder: (c, i) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchData(value: AppConst.listCat[i]['Text']),));
                },
                child: myCatCon(image: '${AppConst.listCat[i]['Image']}', text: AppConst.listCat[i]['Text']),
              );
            },),
          ),

        ],
      ),
    );
  }
  myCatCon({required String image,required String text})=>Container(
    margin: EdgeInsets.all(5),
    width: double.infinity,
    height: double.infinity,
    
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(image: NetworkImage(image),fit: BoxFit.fill)
    ),
    child: Center(child: Text(text,style: TextStyle(fontSize: 22,color: Colors.white),),),
      );
}