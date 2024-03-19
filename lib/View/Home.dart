import 'package:bts/Model/ModelToken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/Service.dart';
import '../Service/ServiceChecklist.dart';

class Home extends StatelessWidget {

   Home({super.key});

  final controllerService = Get.put(ServiceApiLoginRegister());
  final controllerServiceChecklist = Get.put(ServiceCheklist());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controllerService.token.token.toString()),
      ),
      body: FutureBuilder(future: controllerServiceChecklist.listall(controllerService.token.token.toString()), 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.builder(
            itemCount: controllerServiceChecklist.dataList!.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: () => controllerServiceChecklist.deleteData(controllerServiceChecklist.dataList![index].id.toString() , controllerService.token.token.toString() ),
                child: ListTile(
                  leading: Text(controllerServiceChecklist.dataList![index].id.toString()),
                  title: Text(controllerServiceChecklist.dataList![index].name.toString())),
              );
            },
          );
        }
      },),

      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          controllerServiceChecklist.showDialogAddKegiatan(controllerService.token.token.toString());
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      
      ));
      
  }
}