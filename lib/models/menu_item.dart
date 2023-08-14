class MenuItem {
  final int id;
  // final List<dynamic>? images;
  // final List<Map<String, dynamic>>? originalImage;
  final String? createdAt;
  final String? modifiedAt;
  final String? uid;
  final String? slug;
  final String? name;
  final String? description;
  final double? basePrice;
  final double? virtualPrice;
  final String? currency;
  final int? menu;
  final int? restaurant;
  final List<int>? extraNames;
  final List<int>? extraDescriptions;
  final List<int>? category;
  final List<dynamic>? locations;

  MenuItem({
    required this.id,
    // this.images,
    // this.originalImage,
    this.createdAt,
    this.modifiedAt,
    this.uid,
    this.slug,
    this.name,
    this.description,
    this.basePrice,
    this.virtualPrice,
    this.currency,
    this.menu,
    this.restaurant,
    this.extraNames,
    this.extraDescriptions,
    this.category,
    this.locations,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      // images: json['images'] ?? [],
      // originalImage: json['original_image'],
      createdAt: json['created_date'],
      modifiedAt: json['modified_date'],
      uid: json['uid'],
      slug: json['slug'],
      name: json['name'],
      description: json['description'],
      basePrice: json['base_price'],
      virtualPrice: json['virtual_price'],
      currency: json['currency'],
      menu: json['menu'],
      restaurant: json['restaurant'],
      extraNames: List<int>.from(json['extra_names']),
      extraDescriptions: List<int>.from(json['extra_descriptions']),
      category: List<int>.from(json['category']),
      locations: json['locations'] ?? [],
    );
  }
}
