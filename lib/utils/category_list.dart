import 'package:rest_api_project/model/news_response.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  categories.add(CategoryModel(categoryName: 'Science'));
  categories.add(CategoryModel(categoryName: 'Sports'));
  categories.add(CategoryModel(categoryName: 'General'));
  categories.add(CategoryModel(categoryName: 'Entertainment'));
  categories.add(CategoryModel(categoryName: 'Health'));
  categories.add(CategoryModel(categoryName: 'Technology'));
  categories.add(CategoryModel(categoryName: 'Business'));
  return categories;
}
