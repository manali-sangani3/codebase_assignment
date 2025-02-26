class ResponseBaseModel {
  dynamic response;

  ResponseBaseModel(this.response);

  ResponseBaseModel.setResponse({required this.response});
}

class SuccessResponse<T> extends ResponseBaseModel {
  T data;

  SuccessResponse({required this.data}) : super(data);
}

class FlowExceptionResponse<T> extends ResponseBaseModel {
  T data;

  FlowExceptionResponse({required this.data}) : super(data);
}

class FailedResponse extends ResponseBaseModel {
  String errorMessage;

  FailedResponse({required this.errorMessage}) : super(errorMessage);
}

class MessageData {
  int? statusCode;
  String? message;

  MessageData({this.statusCode, this.message});

  MessageData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}

class PackageIdRequest {
  String? packageId;

  PackageIdRequest({this.packageId});

  PackageIdRequest.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageId'] = packageId;
    return data;
  }
}
