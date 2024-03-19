import 'dart:convert';

import 'package:bts/Model/ModelDataCheklist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../LinkAPi.dart';

class ServiceCheklist extends GetxController{

  modelCheklist model = modelCheklist();
  List<Data>? dataList= [];

  Future<void> listall(String token) async {
    print('tesssss');
  var url = Uri.parse("${LINKAPI.BASEURL}checklist");
 
  var response = await http.get(
    url,
    headers: {
      //"Content-Type": "application/json",
      "Authorization": "Bearer $token", // Add this line
    },
  );

  var responseJson = jsonDecode(response.body);
  print('Response status checklist: ${response.statusCode}');
  print('Response body checklist: ${response.body}');

  if(response.statusCode == 200){
      var checklist = modelCheklist.fromJson(responseJson);
     dataList = checklist.data;

    // Now you can use dataList
    for (var data in dataList!) {
      print('ID: ${data.id}, Name: ${data.name}');
    }


    update();
  }else{
    Get.snackbar("Checklist", "Gagal Load Data");
  }
  
  }
  Future<void> add(String token, String name) async {
  var url = Uri.parse("${LINKAPI.BASEURL}checklist");
  var body = jsonEncode({
    "name": name,
  });

  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token", // Remove the space
    },

    body: body,
  );

  var responseJson = jsonDecode(response.body);
  print('Response status add checklist: ${response.statusCode}');
  print('Response body add checklist: ${response.body}');

  if(response.statusCode == 200){
    dataList!.clear();
    Get.snackbar("Checklist", "Berhasil Add Data");
    listall(token);
   update();
   refresh();
  }

  }


  void showDialogAddKegiatan(String token) {
    TextEditingController name = TextEditingController();
    SmartDialog.show(
      //displayTime: Duration(seconds: 2),
      backDismiss: false,
      clickMaskDismiss: true,
      builder: (context) {
        return Center(
          child: Container(
            width: 250,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Name :',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        SmartDialog.dismiss();
                      },
                      child: Container(
                        width: 70,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Tidak',
                          textAlign: TextAlign.center,
                          
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SmartDialog.dismiss();
                        add(token, name.text);
                        //deleteData(id);
                        // deleteData(id);
                      },
                      child: Container(
                        width: 70,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Add',
                          textAlign: TextAlign.center,
                       ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteData(String id, String token) async {
  var url = Uri.parse("${LINKAPI.BASEURL}checklist/$id");
  var response = await http.delete(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    },
  );

  var responseJson = jsonDecode(response.body);
  print('Response status delete checklist: ${response.statusCode}');
  print('Response body delete checklist: ${response.body}');

}
}


  
