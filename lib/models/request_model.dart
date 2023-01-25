class RequestModel{
  String? requestId;
  String? userId;
  String? seedType;
  String? dateRequested;
  String? seedQuantity;
  String? pickupLocation;
  String? userPhoneNumber;


  RequestModel({
    this.requestId,
    this.userId,
    this.seedType,
    this.seedQuantity,
    this.dateRequested,
    this.pickupLocation,
    this.userPhoneNumber
  });

  RequestModel.fromJson(Map<String, dynamic> snap){
    requestId = snap['request_id'];
    userId = snap['user_id'];
    seedType = snap['seed_type'];
    seedQuantity = snap['seed_quantity'];
    pickupLocation = snap['pickup_location'];
    userPhoneNumber = snap['user_phone_number'];
    dateRequested = snap['date_requested'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    data['user_id'] = userId;
    data['seed_type'] = seedType;
    data['seed_quantity'] = seedQuantity;
    data['pickup_location'] = pickupLocation;
    data['user_phone_number'] = userPhoneNumber;
    data['date_requested'] = dateRequested;

    return data;
  }

}