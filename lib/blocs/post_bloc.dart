import 'package:jvdream/models/post_model.dart';
import 'package:jvdream/resources/repository.dart';
import 'package:rxdart/subjects.dart';

class PostBloc {
  final postsRepository = PostsRepository();

  final _postsFetcher = PublishSubject<PostDataResponse>();
  Stream<PostDataResponse> get getPostData => _postsFetcher.stream;

  Future<List<PostModel>> getPostsList(
      Map<String, String> adata, String url) async {
    var data = await postsRepository.getPostListData(adata, url);
    _postsFetcher.sink.add(data);
    return data.listPosts;
  }
}

final postBloc = PostBloc();
