import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/photos_model.dart';
import 'details_wall.dart';
import 'home_page.dart';

class SearchData extends StatefulWidget {
   String value;
   String mColor;
   SearchData({required this.value,this.mColor=''});

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  ScrollController? scrollerController;
  int totalWallpaper=0;
  int totalPage=1;
  int pageCount=1;
  List<PhotoModel>allWallpaper=[];
  @override
  void initState() {
    super.initState();
    scrollerController=ScrollController();
    scrollerController!.addListener(() {
      if(scrollerController!.position.pixels==scrollerController!.position.maxScrollExtent){
        print('End List');
        totalPage=totalWallpaper~/16+1;
        if(totalPage > pageCount){
          pageCount++;

          getSearchWallpaper(wType: widget.value,color: widget.mColor,);
          setState(() {

          });
        }else{
          print('Page Not Add');
        }
      }

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wallpaper'),backgroundColor: Colors.blueGrey,centerTitle: true,),
      body: FutureBuilder(
        future: getSearchWallpaper(wType: widget.value,color: widget.mColor,page: pageCount),
        builder: (_,snap){

          if(snap.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snap.hasError){
            return Center(child: Text('${snap.error}'),);
          }else if(snap.hasData){
            totalWallpaper=snap.data!.total_results!;


            return ListView(

              controller: scrollerController,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${widget.value} ',style: TextStyle(fontSize: 32),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('${snap.data!.total_results} wallpaper available',style: TextStyle(fontSize: 20),),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snap.data!.photos!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9/15
                  ), itemBuilder: (context, index) {

                  var mData=snap.data!.photos![index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsWall(model: snap.data!,mIndex: index,),));
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
                },),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
//actions: [
//         InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder:  (context) => SearchPage(),));
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(Icons.search,size: 32,),
//             ))
//       ],),