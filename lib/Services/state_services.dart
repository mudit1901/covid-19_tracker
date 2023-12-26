import 'dart:convert';

import 'package:covid_tracker/Model/world_state_model.dart';
import 'package:covid_tracker/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StateService {
  Future<WorldStateModel> fetchWorldStateRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldstateApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countrylist() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
