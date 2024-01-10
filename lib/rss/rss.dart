import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:url_launcher/url_launcher.dart';

class Rss extends StatefulWidget {
  const Rss({super.key});

  @override
  State<Rss> createState() => _RssState();
}

class _RssState extends State<Rss> {
  String rssUrl = 'https://blog.rosettastone.com/feed/';
  RssFeed? _feed;

  Future<void> loadFeed() async {
    final response = await http.get(Uri.parse(rssUrl));
    if (response.statusCode == 200) {
      setState(() {
        _feed = RssFeed.parse(response.body);
      });
    } else {
      throw Exception('Failed to load RSS');
    }
  }

  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch ${url.host}';
    }
  }

  @override
  void initState() {
    super.initState();
    loadFeed();
  }

  @override
  Widget build(BuildContext context) {
    return _feed == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _feed!.items!.length,
            itemBuilder: (context, index) {
              var item = _feed!.items![index];
              return ListTile(
                tileColor: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.onSecondary,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  item.title ?? '',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.inversePrimary ),
                ),
                subtitle: Text(item.pubDate.toString()),
                // style: Theme.of(context).colorScheme.onPrimaryContainer,
                onTap: () {
                  // Handle tapping on an item if needed
                  _launchURL(Uri.parse(item.link!));
                },
              );
            },
          );
  }
}
