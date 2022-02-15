class Product {
  static const ID = 'id';
  static const TITLE = 'title';
  static const PRICE = 'price';
  static const DESC = 'description';
  static const CATEGORY = 'category';
  static const IMAGE = 'image';

  late int _id;
  late String _title;
  late double _price;
  late String _description;
  late String _category;
  late String _image;

  int get id => _id;
  String get title => _title;
  double get price => _price;
  String get description => _description;
  String get category => _category;
  String get image => _image;

  Product.fromMap(Map data) {
    _id = data[ID];
    _title = data[TITLE];
    _price = data[PRICE] + .0;
    _description = data[DESC];
    _category = data[CATEGORY];
    _image = data[IMAGE];
  }
}