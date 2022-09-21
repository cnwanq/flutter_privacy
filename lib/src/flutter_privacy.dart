import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_privacy/src/privacy_widget.dart';
import 'package:flutter_privacy/src/version.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterPrivacy extends StatefulWidget {
  final Widget child;
  final String privacyVersion;
  String? privacyContent;
  Function? agreenHandler;
  FlutterPrivacy({required this.child, required this.privacyVersion, this.privacyContent, this.agreenHandler, Key? key})
      : super(key: key);

  @override
  State<FlutterPrivacy> createState() => _FlutterPrivacyState();
}

class _FlutterPrivacyState extends State<FlutterPrivacy> {
  void checkPrivacyHandler(BuildContext context, String privacyVersion) async {
    final prefs = await SharedPreferences.getInstance();
    String version = prefs.getString(privacyKey) ?? "";
    if (privacyVersion.compareTo(version) > 0) {
      debugPrint('version:$version');
      // 显示弹窗
      showCupertinoModalPopup(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                height: 440,
                child: Column(
                  children: [
                    Expanded(
                        child: PrivacyWidget(
                      content: widget.privacyContent ?? "",
                    )),
                    Container(
                      decoration:
                          const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12, width: 0.5))),
                      height: 44,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                exit(0);
                              },
                              child: Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Text(
                                    '不同意并退出',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              // 设置记录
                              if (widget.agreenHandler != null) {
                                widget.agreenHandler!();
                              }
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              child: const Center(
                                child: Text(
                                  '同意',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkPrivacyHandler(context, widget.privacyVersion);
    return widget.child;
  }
}
