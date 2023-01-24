import 'package:instagram_aa/models/request_model.dart';
import 'package:instagram_aa/services/firebase_service.dart';

abstract class RequestController {
  Future<bool> addRequest({RequestModel request});
}

class RequestControllerImplement implements RequestController {
  @override
  Future<bool> addRequest({RequestModel? request}) async {
    final r = requestcol.doc();
    request?.requestId = r.id;
    request?.userId = mAuth.currentUser?.uid;
    request?.dateRequested = DateTime.now().toString();
    await r.set(request!.toJson());
    return true;
  }
}
