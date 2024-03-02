import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:untitled3/cubit/cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../screens/news.dart';


Widget itemBuilder(context, int index, List<dynamic>? list) {
  CubitClass cub = CubitClass.get(context);
  String? title = list?[index]['title'];
  String? url = list?[index]['url'];
  WebViewController controller = cub.controller(url!);
  String ? desc = list?[index]['description'];
  int ? descLines ;
  int ? titleLines ;


  changeTitleLines(){
    if (desc == null ) {
      titleLines = 2 ;
      descLines = 1 ;
    }  else {
      titleLines = 1 ;
      descLines = 2 ;
    }
    return titleLines ;
  }
  changeDescLines(){
    if (desc == null ) {
      titleLines = 2 ;
      descLines = 1 ;
    }  else {
      titleLines = 1 ;
      descLines = 2 ;
    }
    return descLines ;
  }

  return MaterialButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  News(controller),
          ));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      list?[index]['urlToImage'] != null
                          ? '${list?[index]['urlToImage']}'
                          : "https://i.pinimg.com/originals/76/27/af/7627af55c627e7f6b60880f1a684cd77.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      titleAndDesc(title, changeTitleLines(), FontWeight.w900,context),
                      titleAndDesc(desc, changeDescLines(),FontWeight.w400,context),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Text(
                              list?[index]['publishedAt'] != null
                                  ? '${list?[index]['publishedAt']}'
                                  : 'without date',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(color: cub.changeFontColor()),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget conditionalItemBuilder(context, List<dynamic>? list) =>
    ConditionalBuilder(
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => itemBuilder(context, index, list),
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        itemCount: list.length,
      ),
      condition: list!.isNotEmpty,
      fallback: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
Widget conditionalSearchItemsBuilder(context, List<dynamic>? list) =>
    ConditionalBuilder(
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => itemBuilder(context, index, list),
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        itemCount: list.length,
      ),
      condition: list!.isNotEmpty,
      fallback: (context)=>const Center()
    );

Widget titleAndDesc(String? str, int ? maxLine, FontWeight fontWeight,context) {
  CubitClass cub = CubitClass.get(context);
  return Text(
    str ?? '',
    overflow: TextOverflow.ellipsis,
    maxLines: maxLine,
    style: TextStyle(
      color: cub.changeFontColor(),
      fontSize: 18,
      fontWeight: fontWeight,
    ),
  );
}
