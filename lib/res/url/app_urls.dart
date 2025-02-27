class AppUrls {
  static const String baseUrl = '';
  static const String fakeStoreApiUrl = 'https://fakestoreapi.com/products';
  static const String newsUrlTopHeadlines =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=c1ce3cb76fe2419193ffd86e5b85432d';
  static String newsUrlCategory(String category) {
    return 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=c1ce3cb76fe2419193ffd86e5b85432d';
  }
}
