import 'package:flutter/material.dart';

class SearchableLessonListScaffold<T> extends StatefulWidget {
  const SearchableLessonListScaffold({
    required this.title,
    required this.loader,
    required this.filterText,
    required this.itemBuilder,
    required this.emptyTitle,
    required this.emptySubtitle,
    super.key,
  });

  final String title;
  final Future<List<T>> Function() loader;
  final String Function(T item) filterText;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final String emptyTitle;
  final String emptySubtitle;

  @override
  State<SearchableLessonListScaffold<T>> createState() =>
      _SearchableLessonListScaffoldState<T>();
}

class _SearchableLessonListScaffoldState<T>
    extends State<SearchableLessonListScaffold<T>> {
  final _queryController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _queryController,
              onChanged: (value) => setState(() => _query = value.trim()),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'レッスンを検索',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<T>>(
              future: widget.loader(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = snapshot.data ?? <T>[];
                final filteredItems = items.where((item) {
                  if (_query.isEmpty) {
                    return true;
                  }

                  return widget
                      .filterText(item)
                      .toLowerCase()
                      .contains(_query.toLowerCase());
                }).toList();

                if (filteredItems.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.search_off, size: 36),
                          const SizedBox(height: 12),
                          Text(
                            widget.emptyTitle,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.emptySubtitle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) =>
                      widget.itemBuilder(context, filteredItems[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
