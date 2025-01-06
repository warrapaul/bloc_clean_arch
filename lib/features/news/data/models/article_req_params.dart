class ArticleReqParams {
  final String searchPhrase;
  final int? page;
  final int? pageSize;
  final DateTime? from;
  final DateTime? to;
  final String? sortBy;
  final List<String>? searchIn;
  final List<String>? sources;
  // final String category;  //businessentertainmentgeneralhealthsciencesportstechnology
  // final String country;

  ArticleReqParams({
    this.from,
    this.to,
    this.sortBy,
    this.searchIn,
    this.sources,
    this.page,
    this.pageSize,
    required this.searchPhrase,
  });
}
