class PaginatedResult<T> {
  int total;
  int page;
  List<T> results;

  PaginatedResult({required this.total, required this.page, required this.results});
}