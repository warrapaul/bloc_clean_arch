class FilterDummyPostsReqParams {
  final String? searchPhrase;
  final int? page;
  final int? pageSize;
  final String? sortBy;
  final String? sortOrder;
  final String? tag;

  FilterDummyPostsReqParams({
  this.tag,
  this.searchPhrase, 
  this.page, 
  this.pageSize, 
  this.sortBy, 
  this.sortOrder,
  });
}

//posts/search?q=love')
//?limit=10&skip=10
//?sortBy=title&order=asc