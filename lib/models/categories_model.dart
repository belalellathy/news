class CategoriesModel {
  String id;
  String image;
  String name;
  CategoriesModel({
    required this.name,
    required this.id,
    required this.image,
  });
  static List<CategoriesModel> categoriesLight = [
    CategoriesModel(id: 'general', image: 'assets/images/General.png', name: 'General'),
    CategoriesModel(id: 'business', image: 'assets/images/busniess.png', name: 'Business'),
    CategoriesModel(id: 'entertainment', image: 'assets/images/entertainment.png', name: 'Entertainment'),
    CategoriesModel(id: 'health', image: 'assets/images/helth.png', name: 'Health'),
    CategoriesModel(id: 'science', image: 'assets/images/science.png', name: 'Science'),
    CategoriesModel(id: 'sports', image: 'assets/images/sport.png', name: 'Sports'),
    CategoriesModel(id: 'technology', image: 'assets/images/technology.png', name: 'Technology'),
  ];
  static List<CategoriesModel> categoriesDark = [
    CategoriesModel(id: 'general', image: 'assets/images/General_dark.png', name: 'General'),
    CategoriesModel(id: 'business', image: 'assets/images/busniess_dark.png', name: 'Business'),
    CategoriesModel(id: 'entertainment', image: 'assets/images/entertainment_dark.png', name: 'Entertainment'),
    CategoriesModel(id: 'health', image: 'assets/images/health_dark.png', name: 'Health'),
    CategoriesModel(id: 'science', image: 'assets/images/science_dark.png', name: 'Science'),
    CategoriesModel(id: 'sports', image: 'assets/images/sports_dark.png', name: 'Sports'),
    CategoriesModel(id: 'technology', image: 'assets/images/tech_dark.png', name: 'Technology'),
  ];

}