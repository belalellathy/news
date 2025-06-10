import 'package:flutter/material.dart';
import 'package:news/models/news_response/article.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:news/theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  NewsItem({super.key, required this.article});
  Article article ;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: settingsProvider.isDark ? apptheme.white : apptheme.black,
          width: 2,
        ),

        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              article.urlToImage??"https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
              width: double.infinity,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          SizedBox(height: 10),
          Text(
            article.description??" ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: settingsProvider.isDark ? apptheme.white : apptheme.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.source!.name!,
                style: TextStyle(
                  color: settingsProvider.isDark
                      ? apptheme.white
                      : apptheme.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                timeago.format(article.publishedAt??DateTime.now()),
                style: TextStyle(
                  color: settingsProvider.isDark
                      ? apptheme.white
                      : apptheme.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
