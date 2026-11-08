import 'package:moviles_auth/features/posts/domain/entities/post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The only file that talks to the posts and likes tables.
class SupabasePostDataSource {
  final SupabaseClient _client = Supabase.instance.client;

  static const _columns =
      'id, content, created_at, '
      'author:profiles!profile_id(username, full_name), '
      'likes(count), '
      'my_like:likes(profile_id)';

  String get _uid {
    return _client.auth.currentUser!.id;
  }

  Future<List<Post>> fetchFeed({required int page, required int size}) async {
    final from = page * size;
    try {
      final rows = await _client
          .from('posts')
          .select(_columns)
          .eq('my_like.profile_id', _uid)
          .order('created_at', ascending: false)
          .range(from, from + size - 1);
      return rows.map(_toPost).toList();
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<Post>> fetchMine({int limit = 3}) async {
    try {
      final rows = await _client
          .from('posts')
          .select(_columns)
          .eq('profile_id', _uid)
          .eq('my_like.profile_id', _uid)
          .order('created_at', ascending: false)
          .limit(limit);
      return rows.map(_toPost).toList();
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> create(String content, {String? imagePath}) async {
    try {
      await _client.from('posts').insert({
        'profile_id': _uid,
        'content': content,
      });
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> like(String postId) async {
    try {
      await _client.from('likes').upsert({
        'post_id': postId,
        'profile_id': _uid,
      }, onConflict: 'post_id,profile_id');
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> unlike(String postId) async {
    try {
      await _client
          .from('likes')
          .delete()
          .eq('post_id', postId)
          .eq('profile_id', _uid);
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }

  Post _toPost(Map<String, dynamic> row) {
    final author = row['author'] as Map<String, dynamic>;
    return Post(
      id: row['id'] as String,
      content: row['content'] as String,
      createdAt: DateTime.parse(row['created_at'] as String),
      authorUsername: author['username'] as String,
      authorName: author['full_name'] as String,
      likeCount: (row['likes'] as List).first['count'] as int,
      likedByMe: (row['my_like'] as List).isNotEmpty,
    );
  }
}
