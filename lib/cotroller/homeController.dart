import 'dart:developer';
import 'dart:io';

import 'package:anglealgopython/model/scriptmodel.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  Dio _dio = Dio();
  RxList<ScriptModel> scriptList = <ScriptModel>[].obs;
  RxDouble downloadProgress = 0.0.obs;
  Rx<DownloadState> downloadingState = DownloadState.noState.obs;
  RxBool isDownloading = false.obs;
  downloadScripFile() async {
    downloadProgress.value = 0.0;
    downloadingState.value = DownloadState.inProgress;
    isDownloading.value = true;
    final path =
        "${(await getTemporaryDirectory()).path}/OpenAPIScripMaster.json";
    // final a = await _dio.get(
    //   "https://margincalculator.angelbroking.com/OpenAPI_File/files/OpenAPIScripMaster.json",
    // );

    await _dio.download(
      "https://margincalculator.angelbroking.com/OpenAPI_File/files/OpenAPIScripMaster.json",
      path,
      onReceiveProgress: (re, to) {
        downloadProgress.value = (re / to);
        log("DownLoad---> ${downloadProgress.value}");
        if (downloadProgress.value == 1.0) {
          isDownloading.value = false;
          downloadingState.value = DownloadState.done;
          Future.delayed(Duration(seconds: 10), () {
            downloadingState.value = DownloadState.noState;
          });
        }
      },
    );

    final a = scriptListModelFromJson(File(path).readAsStringSync());
    scriptList.value = a
        .where((element) =>
            element.instrumenttype!.toLowerCase() == "FUTIDX".toLowerCase())
        .toList();
    log("Length ---> ${scriptList.length}");
    scriptVaue.value = scriptList.first;
  }

  RxString timeFrameValue = timeFrame.keys.toList()[2].obs;
  Rx<ScriptModel> scriptVaue = ScriptModel().obs;
}

enum DownloadState { inProgress, done, noState }

Map<String, String> timeFrame = {
  "1 Minute": "ONE_MINUTE",
  "3 Minute": "THREE_MINUTE",
  "5 Minute": "FIVE_MINUTE",
  "10 Minute": "TEN_MINUTE",
  "15 Minute": "FIFTEEN_MINUTE",
  "30 Minute": "THIRTY_MINUTE",
  "1 Hour": "ONE_HOUR",
  "1 Day": "ONE_DAY"
};



// {
//         "exchange": "NFO",
//         "symboltoken": "48756",
//         "interval": "FIVE_MINUTE",
//         "fromdate": "2023-03-21 09:15",
//         "todate": "2023-03-21 15:30"
//     }