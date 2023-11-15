import 'dart:convert';

import 'package:covid_19_tracker/Model/WorldStatesModel.dart';
import 'package:covid_19_tracker/Services/Utilities/App_url.dart';
import 'package:http/http.dart' as http;

class States_Service{

  Future<WorldStatesModel> fetchWorldStatesRecords() async{

    final response= await http.get(Uri.parse(App_url.worldStatesApi));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Error");
    }

  }

  Future<List<dynamic>> countriesListApi() async{
    var data;
    final response= await http.get(Uri.parse(App_url.countriesList));
    if(response.statusCode==200){
      data=jsonDecode(response.body);
      return data;
    }else{
      throw Exception("Error");
    }

  }

}

