import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/shared/cubit/cubit.dart';

import '../styles/iconbroken.dart';
//import 'package:metest/modules/webview/web.dart';

Widget dTextBoton({required Function? func, required String Ttxt}) =>
    TextButton(
        onPressed: () {
          func!();
        },
        child: Text(Ttxt.toUpperCase()));
Widget defultbouton({
  double radius = 3,
  double widthw = double.infinity,
  Color background = Colors.blue,
  bool isuper = true,
  required Function? function,
  required String text,
}) =>
    Container(
      height: 40,
      width: widthw,
      child: MaterialButton(
        onPressed: () {
          function!();
        },
        child: Text(
          isuper ? text.toUpperCase() : text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
    );
Widget defualtAppbar(
        {required BuildContext context,
        String? title,
        List<Widget>? actions}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
      title: Text(title!),
      actions: actions,
    );
Widget defultTxtform({
  required TextEditingController controller,
  required TextInputType Texttypein,
  Function? onchanget,
  Function? onsubmitt,
  Function? ontap,
  required Function? valedate,
  required String? label,
  required IconData? icn,
  bool obsu = false,
  IconData? sufex,
  Function? suffixpressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: Texttypein,
      obscureText: obsu,
      decoration: InputDecoration(
        labelText: label,
        prefix: Icon(icn),
        suffix: sufex != null
            ? IconButton(
                onPressed: () {
                  suffixpressed!();
                },
                icon: Icon(sufex))
            : null,
        border: OutlineInputBorder(),
      ),
      onFieldSubmitted: (s) {
        onsubmitt!(s);
      },
      onChanged: (s) {
        onchanget!(s);
      },
      validator: (s) {
        valedate!();
      },
      onTap: () {
        ontap!();
      },
    );
Widget BuildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                child: Text(
                  '${model['time']}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                radius: 40.00,
                backgroundColor: Colors.pink,
              ),
              SizedBox(
                width: 10.00,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${model['title']}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.00,
                          color: Colors.pink),
                    ),
                    Text(
                      '${model['data']}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.00,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    AppCubit.getApp(context)
                        .updateStates(states: 'done', id: model['id']);
                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.pink,
                  )),
              SizedBox(
                width: 10.00,
              ),
              IconButton(
                  onPressed: () {
                    AppCubit.getApp(context)
                        .updateStates(states: 'archive', id: model['id']);
                  },
                  icon: Icon(
                    Icons.archive_sharp,
                    color: Colors.grey,
                  ))
            ],
          ),
        ),
      ),
      onDismissed: (derection) {
        AppCubit.getApp(context).deletedatabase(id: model['id']);
      },
    );

Widget NewsArticleItem(Article, context) => InkWell(
      child: Padding(
        padding: EdgeInsetsDirectional.all(
          10.00,
        ),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              //${Article['urlToImage']}
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(8.00),
                image: DecorationImage(
                    image: NetworkImage(' ${Article['urlToImage']}'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 10.00,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      ' ${Article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )),
                    Text(
                      ' ${Article['publishedAt']}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.00),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        //  Navigateto(context, webviewscreen(Article['url']));
      },
    );
Widget BuldSearchitem(List list, context, {issearch = false}) =>
    ConditionalBuilder(
        condition: list.length > 0,
        builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                NewsArticleItem(list[index], context),
            separatorBuilder: (context, index) => Container(
                  height: 3,
                  width: double.infinity,
                  color: Colors.amber,
                ),
            itemCount: 10),
        fallback: (context) => issearch
            ? Container()
            : Center(
                child: CircularProgressIndicator(),
              ));
void Navigateto(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void Navigatefinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);
void Showtost({required String text, required teaststates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: teastcolor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum teaststates {
  SUCCESS,
  ERROR,
  WORNING;
}

Color teastcolor(teaststates states) {
  Color colr;
  switch (states) {
    case teaststates.SUCCESS:
      colr = Colors.green;
      break;
    case teaststates.ERROR:
      colr = Colors.red;
      break;
    case teaststates.WORNING:
      colr = Colors.yellowAccent;
      break;
  }
  return colr;
}
/*
Widget buildfavoriteitrm(Product model, context) => Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        // padding: EdgeInsets.all(10),
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Text(
                      'dicoiunt',
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(height: 1.3),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                //  Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(height: 1.3),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 3.00,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.green, fontStyle: FontStyle.italic),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changefavorite(model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: // ShopCubit.get(context)
                            //     .Favorite[model.product!.id]!
                            //   ? Colors.blue
                            //    :
                            Colors.grey,
                        child: Icon(
                          Icons.favorite_border_outlined,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );


 */
