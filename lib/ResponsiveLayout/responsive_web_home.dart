import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_design/ResponsiveLayout/device_responce.dart';
import 'package:flutter_web_design/ResponsiveLayout/sample_api.dart';
import 'response_web_drawer.dart';

class ResponsiveWebHome extends StatelessWidget {
  const ResponsiveWebHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        leading: (DeviceResponce.isMobile(context) ||
                DeviceResponce.isTablet(context))
            ? GestureDetector(
                onTap: () => scaffoldkey.currentState!.openDrawer(),
                child: const SizedBox(
                  width: 25,
                  height: 25,
                  child: Icon(
                    CupertinoIcons.arrow_right_arrow_left_square_fill,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
      drawer:
          (DeviceResponce.isMobile(context) || DeviceResponce.isTablet(context))
              ? const ResponceWebDrawer()
              : const SizedBox.shrink(),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Row(
          children: [
            if (DeviceResponce.isdekstop(context)) const ResponceWebDrawer(),
            const Expanded(
              child: BodyArea(),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyArea extends StatefulWidget {
  const BodyArea({Key? key}) : super(key: key);

  @override
  State<BodyArea> createState() => _BodyAreaState();
}

class _BodyAreaState extends State<BodyArea> {
  @override
  void initState() {
    super.initState();
    getUserDetails().then((value) {
      if (value != null) {
        log('getResponce : $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey[200]!,
      child: FutureBuilder<List<UserDetails>?>(
        future: getUserDetails(),
        builder: (context, AsyncSnapshot<List<UserDetails>?> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                ...snapshot.data!
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.98,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.1),
                            width: 0.75,
                          ),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('ID CARD'),
                                Text('ID : ${e.id}'),
                                Text('Name : ${e.name}'),
                                Text('Mobile : ${e.phone}'),
                                Text(
                                  'email : ${e.email}',
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 2),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Adress'),
                                  Text(
                                    'Street : ${e.address.street}',
                                    style: const TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text('Suite : ${e.address.suite}'),
                                  Text(
                                      '${e.address.city} city , \nzipcode ${e.address.zipcode}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                // anotherWay

                /*
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return const Text('bhuru');
                    })
                */
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
