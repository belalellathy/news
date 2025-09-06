import 'package:flutter/material.dart';
import 'package:news/news/data/models/news_response/article.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';


class NewsItem extends StatelessWidget {
  NewsItem({super.key, required this.article});
  Article article ;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;
    
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isTablet ? 15 : 10,
        horizontal: isTablet ? 8 : 0,
      ),
      padding: EdgeInsets.all(isTablet ? 16 : 10),
      decoration: BoxDecoration(
        color: settingsProvider.isDark ? apptheme.black : apptheme.white,
        border: Border.all(
          color: settingsProvider.isDark ? apptheme.white : apptheme.black,
          width: isTablet ? 3 : 2,
        ),
    
        borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
      ),
      child: InkWell(
        onTap: () async {
        final Uri url = Uri.parse(article.url!);

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
        // Handle tap event, e.g., navigate to article details
      },
          
        
      
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
              child: Image.network(
                errorBuilder: (_, __, ___) {
                  return Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                    width: double.infinity,
                    fit: BoxFit.fill,
                    height: isLargeScreen ? screenHeight * 0.25 : isTablet ? screenHeight * 0.22 : screenHeight * 0.2,
                  );
                },
                article.urlToImage??"https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                width: double.infinity,
                fit: BoxFit.fill,
                height: isLargeScreen ? screenHeight * 0.25 : isTablet ? screenHeight * 0.22 : screenHeight * 0.2,
              ),
            ),
            SizedBox(height: isTablet ? 15 : 10),
            Text(
              article.description??" ",
              style: TextStyle(
                fontSize: isLargeScreen ? 20 : isTablet ? 18 : 16,
                fontWeight: FontWeight.w700,
                color: settingsProvider.isDark ? apptheme.white : apptheme.black,
              ),
            ),
            SizedBox(height: isTablet ? 15 : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  article.source!.name!,
                  style: TextStyle(
                    color: settingsProvider.isDark
                        ? apptheme.white
                        : apptheme.black,
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  timeago.format(article.publishedAt??DateTime.now()),
                  style: TextStyle(
                    color: settingsProvider.isDark
                        ? apptheme.white
                        : apptheme.black,
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
