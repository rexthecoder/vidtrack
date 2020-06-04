import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vidtrack/providers/covid.dart';

class CasesForCorona {
  List<Covid> cases = [];

  Future<void> getCasesForCorona() async {
    String url = "https://api.covid19api.com/ghana";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      Covid gottencases = Covid(
        recovered: jsonData['recovered']['value'],
        deaths: jsonData['deaths']['value'],
      );
      cases.add(gottencases);
    } else {
      print(response.statusCode);
    }
  }
}

class GlobalTotalForCorona {
  List<Covid> cases = [];

  Future<void> getTotalCasesForCorona() async {
    String url = "https://covid19.mathdro.id/api";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      Covid gottencases = Covid(
        confirmed: jsonData['confirmed']['value'],
        recovered: jsonData['recovered']['value'],
        deaths: jsonData['deaths']['value'],
      );
      cases.add(gottencases);
    } else {
      print(response.statusCode);
    }
  }
}