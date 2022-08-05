import 'package:flutter/material.dart';

class ResponceWebDrawer extends StatelessWidget {
  const ResponceWebDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Drawer(
      elevation: 0.0,
      child: Column(
        children: <Widget>[
          Image.network(
            'https://cdn.xxl.thumbs.canstockphoto.com/paper-layer-blue-abstract-background-use-for-banner-cover-poster-wallpaper-design-with-space-eps-vectors_csp75545932.jpg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width * 0.25 >= 125
                ? 125
                : MediaQuery.of(context).size.width * 0.25,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}
