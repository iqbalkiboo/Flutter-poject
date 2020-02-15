import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sampleproject/data/models/employee_model.dart';

class EmployeeProvider extends ChangeNotifier {
  List<EmployeeModel> _data = [];
  List<EmployeeModel> get dataEmployee => _data;
  
  Future<List<EmployeeModel>> getEmployee() async {
    final url = 'http://dummy.restapiexample.com/api/v1/employees';
    // 'http://dummy.restapiexample.com/api/v1/employees';
    final response = await http.get(url);

    if (response.statusCode == 200){
      final result = json.decode(response.body)['data'].cast<Map<String , dynamic>>();
      _data = result.map<EmployeeModel>((json) => EmployeeModel.fromJson(json)).toList();
      //  print(_data);
      return(_data);
    } else {
      throw Exception();
    }
  }

  Future<bool> storeEmployee(String name, String salary, String age) async {
    final url = 'http://dummy.restapiexample.com/api/v1/employees';
    final response = await http.post(url, body: {
      'employee_name': name,
      'employee_salary': salary,
      'employee_age': age
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<EmployeeModel> findEmployee(String id) async {
    return _data.firstWhere((i) => i.id == id);
  }

  Future<bool> updateEmployee(id, name, salary, age) async {
    final url = 'http://dummy.restapiexample.com/api/v1/employees';
    final response = await http.post(url, body: {
      'id': id,
      'employee_name': name,
      'employee_salary': salary,
      'employee_age': age
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> deleteEmployee(String id) async {
    final url = 'http://dummy.restapiexample.com/api/v1/employees';
    await http.get(url + '?id=$id');
  }
}