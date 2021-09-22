import 'package:conditional/conditional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/modules/webview%20screen/webview_screen.dart';

Widget buildNewsCard(articles, context) {
  return InkWell(
    onTap: () => navigateTo(context, WebViewScreen(
      articles['url']
    )),
      child: Row(
      children: [
        Expanded(
            flex: 1,
            child: articles['urlToImage'] == null
                ? Center(child: Icon(Icons.photo))
                : Image(image: NetworkImageWithRetry(articles['urlToImage']))),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articles['title'],
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(DateFormat.yMMMd()
                    .format(DateTime.parse(articles['publishedAt'])))
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildNewsList(List list, context, {isSearch = false}) {
  return Conditional(
      condition: list.length > 0,
      onConditionTrue: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
            itemBuilder: (context, index) =>
                buildNewsCard(list[index], context),
            separatorBuilder: (context, index) => Divider(
                  height: 20,
                  thickness: 2,
                ),
            itemCount: list.length),
      ),
      onConditionFalse: Center(
        child: isSearch
            ? Text('Please type something')
            : CircularProgressIndicator(),
      ));
}

navigateTo(context, widget) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
