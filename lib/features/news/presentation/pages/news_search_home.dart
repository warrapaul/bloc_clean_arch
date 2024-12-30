import 'package:bloc_clean_arch/features/news/data/models/article_req_params.dart';
import 'package:bloc_clean_arch/features/news/presentation/cubit/cubit/article_cubit.dart';
import 'package:bloc_clean_arch/features/news/presentation/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewsSearchHomePage extends StatefulWidget {
  const NewsSearchHomePage({super.key});

  @override
  State<NewsSearchHomePage> createState() => _NewsSearchHomePageState();
}

class _NewsSearchHomePageState extends State<NewsSearchHomePage> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;
  String _sortBy = 'popularity';
  final List<String> _sortOptions = ['popularity', 'relevancy', 'publishedAt'];

  @override
  void initState() {
    super.initState();
    context.read<ArticleCubit>().fetchArticles();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  void _performSearch() {
    final params = ArticleReqParams(
      searchPhrase:
          _searchController.text.isEmpty ? 'bitcoin' : _searchController.text,
      from: _fromDate,
      to: _toDate,
      sortBy: _sortBy,
      pageSize: 20,
    );
    context.read<ArticleCubit>().searchArticles(params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search news...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSubmitted: (_) => _performSearch(),
                ),
                const SizedBox(height: 16),

                // Date and Sort Controls
                Row(
                  children: [
                    // From Date
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context, true),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'From',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _fromDate != null
                                ? DateFormat('yyyy-MM-dd').format(_fromDate!)
                                : 'Select date',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // To Date
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context, false),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'To',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _toDate != null
                                ? DateFormat('yyyy-MM-dd').format(_toDate!)
                                : 'Select date',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Sort Dropdown
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Sort By',
                          border: OutlineInputBorder(),
                        ),
                        value: _sortBy,
                        items: _sortOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _sortBy = newValue;
                            });
                            _performSearch();
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Search Button
                ElevatedButton(
                  onPressed: _performSearch,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Search'),
                ),
              ],
            ),
          ),

          // News List
          Expanded(
            child: BlocBuilder<ArticleCubit, ArticleState>(
              builder: (context, state) {
                if (state is ArticleLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ArticleLoadSuccessState) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];
                      return NewsCard(article: article);
                    },
                  );
                }

                if (state is ArticleLoadFailureState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${state.message}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _performSearch,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
