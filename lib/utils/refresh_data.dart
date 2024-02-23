import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_aa/models/posts_model.dart';

// class RefreshData {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
  
//   Future<List<PostsModel>>onRefresh({required documentSnapshot}) async{
//     var postColRef = firestore.collection('post');
//     var res = await postColRef
//         .orderBy('timestamp', descending: true)
//         .limit(10)
//         .startAfterDocument(documentSnapshot).get();
//     return res.docs.map((doc) => PostsModel.fromJson(doc.data())).toList();
//   }
// }

class RefreshData {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  Future<List<PostsModel>> onRefresh({DocumentSnapshot? documentSnapshot}) async {
    var postColRef = firestore.collection('post');
    var query = postColRef.orderBy('timestamp', descending: true).limit(5);
    if (documentSnapshot != null) {
      query = query.startAfterDocument(documentSnapshot);
    }
    var res = await query.get();
    return res.docs.map((doc) => PostsModel.fromJson(doc.data())).toList();
  }
}
