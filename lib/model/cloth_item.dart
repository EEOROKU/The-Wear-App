
class ClothingDictionary {
  static Map<String, List<String>> categoryToSubcategories = {
    'Tops': ['tshirts', 'lonsleeve tshirt', 'sleeveless tshirt', 'polo shirts', 'tanksand camis', 'ctoptops', 'blouses', 'shirt', 'sweatshirts', 'hoodies', 'sweaters', 'sweater vest', 'cardigan', 'sports tops', 'bodysuit'],
    'Dresses': ['day dresses', 'mini dresses', 'tshirt dresses', 'shirt dresses', 'sweatshirt dresses', 'sweater dresses', 'jacket dresses', 'suspender dresses', 'jumpsuits', 'party dresses'],
    'Pants': ['shorts', 'jeans', 'trousers', 'dress pants', 'track pants', 'leggings'],
    'Skirts': ['mini skirt', 'midi skirt', 'maxi skirt'],
    'Outerwear': ['coats', 'trench coat', 'fur coat', 'shearling coats', 'blousons', 'varsity jackets', 'jackets', 'vest', 'zip hoodies', 'cardigans', 'blazers', 'trucket jackets', 'field jackets', 'biker jackets', 'fleece jackets', 'parkas', 'sports jackets', 'down jackets', 'puffer jackets'],
    'Shoes': ['sneakers', 'slipons', 'sports shoes', 'loafers and loafer mules', 'sandals', 'sandals heels', 'slides', 'mule heels', 'boots', 'combat boots', 'boat shoes', 'ugg boots', 'hiking shoes', 'flat shoes', 'heels'],
    'Bags': ['tote bags', 'shoulder bags', 'cross body', 'waist', 'canvas', 'backpacks', 'duffel', 'clutch', 'brief case', 'drawstring', 'suitcases'],
    'Headwear': ['cap', 'hats', 'beanies', 'berets', 'fedoras', 'sun hats'],
    'Jewelry': ['earrings', 'necklaces', 'bracelets', 'rings', 'brooches'],
    'Other Items': ['under ware', 'beach wear', 'co-ords', 'hair accessories', 'eye wear', 'ties', 'scarves', 'mufflers', 'watches', 'gloves', 'belts', 'socks', 'tights', 'wallets and purses', 'other accessories'],
  };

  // Method to return the list of subcategories connected to a parent category
  static List<String> getSubcategories(String parentCategory) {
    return categoryToSubcategories[parentCategory] ?? [];
  }

  // Method to return the parent category of a given item
  static String getParentCategory(String subcategory) {
    for (var entry in categoryToSubcategories.entries) {
      if (entry.value.contains(subcategory)) {
        return entry.key;
      }
    }
    return '';
  }
}
class ClothingItemModel {
  String subcategory = '';
  String imageUrl;
  String? color;
  String? material;

  String? notes;
  String? season;
  String? occasion;

  ClothingItemModel({
    required this.subcategory,
    required this.imageUrl,
    this.color,
    this.material,
    this.notes,
    this.season,
    this.occasion,
  });

  // Method to convert ClothingItemModel to a Map
  Map<String, dynamic> toMap() {
    return {

      'subcategory': subcategory,
      'color': color,
      'material': material,
      'imageUrl':imageUrl,
      'notes': notes,
      'season': season,
      'occasion': occasion,
    };
  }

  // Method to create a ClothingItemModel from a Map
  factory ClothingItemModel.fromMap(Map<String, dynamic> map) {
    return ClothingItemModel(
      imageUrl:map['imageUrl'] ,
      subcategory: map['subcategory'],
      color: map['color'],
      material: map['material'],
      notes: map['notes'],
      season: map['season'],
      occasion: map['occasion'],
    );
  }
String getImageUrl(){
    return this.imageUrl;
}

  // Method to get parent category of a ClothingItemModel
  String getParentCategory() {
    return ClothingDictionary.getParentCategory(subcategory);
  }
}