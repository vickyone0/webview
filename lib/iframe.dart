//import 'dart:html' as html;
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:webview/main.dart';

class IframeScreen extends StatefulWidget {
  final String ChannelName;

  IframeScreen({required this.ChannelName});
  @override
  State<IframeScreen> createState() => _IframeScreenState();
}

class _IframeScreenState extends State<IframeScreen> {
  //late IFrameElement _iFrameElement;
  //late Widget _iframeWidget;
  final html.IFrameElement _iFrameElement = html.IFrameElement();
  late Widget _iframeWidget;

  @override
  void didChangeDependencies() {
    setState(() {
      iFrameCreate();
      _iFrameElement.src = 'add your url';
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    //_iFrameElement = IFrameElement();
    iFrameCreate();
    super.initState();
    _iframeWidget = HtmlElementView(
      viewType: 'iframeElement',
    );
  }

  void iFrameCreate() {
    _iFrameElement.style.height = '80%';
    _iFrameElement.style.width = '80%';
    updateIframeUrl();

    _iFrameElement.style.border = 'none';
    _iFrameElement.allow = 'camera' + ';microphone';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iFrameElement,
    );
  }

  void updateIframeUrl() {
    print('${widget.ChannelName}');

    setState(() {
      _iFrameElement.src = 'add your url';
    });
  }

  @override
  void dispose() {
    _iFrameElement.remove();
    _iFrameElement.src;
    // Clean up the iframe element
    super.dispose();
  }

  //final Widget _iframeWidget = HtmlElementView(
  //  viewType: 'iframeElement',
  //  key: UniqueKey(),
  //);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .9,
            width: MediaQuery.of(context).size.width,
            child: _iframeWidget,
          ),
          ElevatedButton(
            onPressed: () {
              html.window.location.reload();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => FirstPage()));
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}
