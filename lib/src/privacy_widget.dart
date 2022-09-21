import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyWidget extends StatelessWidget {
  final String content;
  const PrivacyWidget({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          titleWidget(context),
          Expanded(child: buildMarkdown()),
        ],
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: const Center(
        child: Text(
          '温馨提示',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget buildMarkdown() {
    return MarkdownWidget(
      data: content,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      styleConfig: StyleConfig(pConfig: PConfig(onLinkTap: (url) {
        // Uri _url = Uri.parse(url ?? "");
        _launchUrl(url ?? "");
      })),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }
}
