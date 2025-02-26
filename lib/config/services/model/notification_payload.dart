class FCMNotificationPayload {
  String? module;
  String? screenName;
  String? referenceId;

  FCMNotificationPayload.fromJson(Map<String, dynamic> json) {
    module = json['module'];
    screenName = json['screenName'];
    referenceId = json['referenceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['module'] = module;
    data['screenName'] = screenName;
    data['referenceId'] = referenceId;
    return data;
  }
}
