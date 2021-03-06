import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_project/componensts/album_list.dart';
import 'package:sample_project/models/album.dart';
import 'package:sample_project/shared/api_provider.dart';

class AlbumListPage extends ConsumerWidget {
  const AlbumListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<List<Album>> asyncValue = watch(albumListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Project for Testing'),
      ),
      body: SafeArea(
        child: asyncValue.when(
          data: (albumList) => SingleChildScrollView(
            child: AlbumListWidget(
              albumList: albumList,
            ),
          ),
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (err, stack) => Text('$err'),
        ),
      ),
    );
  }
}
