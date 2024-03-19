class modelCheklist {
  int? statusCode;
  String? message;
  Null? errorMessage;
  List<Data>? data;

  modelCheklist({this.statusCode, this.message, this.errorMessage, this.data});

  modelCheklist.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorMessage = json['errorMessage'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['errorMessage'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  Null? items;
  bool? checklistCompletionStatus;

  Data({this.id, this.name, this.items, this.checklistCompletionStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    items = json['items'];
    checklistCompletionStatus = json['checklistCompletionStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['items'] = this.items;
    data['checklistCompletionStatus'] = this.checklistCompletionStatus;
    return data;
  }
}