import 'dart:developer';

import 'package:anglealgopython/cotroller/homeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _homecontroller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {
                _homecontroller.downloadScripFile();
              },
              icon: Obx(
                () => _homecontroller.downloadingState.value ==
                        DownloadState.inProgress
                    ? SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                          value: _homecontroller.downloadProgress.value,
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : _homecontroller.downloadingState.value ==
                            DownloadState.done
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            grade: 20,
                          )
                        : const Icon(
                            Icons.download,
                            color: Colors.white,
                            grade: 10,
                          ),
              ),
              label: const Text(
                "Download Script File",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Column(
        children: [
          Obx(() => _homecontroller.scriptList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: DropdownButtonFormField(
                      value: _homecontroller.scriptVaue.value,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      items: _homecontroller.scriptList
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text("${e.name}(${e.expiry})"),
                              ))
                          .toList(),
                      onChanged: (v) {
                        log(v!.toJson().toString());
                      }),
                )
              : const SizedBox()),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(20),
              child: DropdownButtonFormField(
                  value: _homecontroller.timeFrameValue.value,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  items: timeFrame.keys
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text("${e}"),
                          ))
                      .toList(),
                  onChanged: (v) {
                    _homecontroller.timeFrameValue.value = v!;
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
