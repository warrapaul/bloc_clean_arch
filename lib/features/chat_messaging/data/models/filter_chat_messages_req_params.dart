class FilterChatMessagesReqParams {
  final String? searchPhrase;
  final int? page;
  final int? pageSize;
  final String? sortBy;
  final String? sortOrder;

  FilterChatMessagesReqParams({
    this.searchPhrase,
    this.page,
    this.pageSize,
    this.sortBy,
    this.sortOrder,
  });
}