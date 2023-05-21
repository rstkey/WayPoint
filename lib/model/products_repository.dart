// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    final allProducts = [
      Product(
        category: categoryAccessories,
        id: 0,
        isFeatured: true,
        name: (context) =>
            'strawberry',
        price: 120,
        assetAspectRatio: 329 / 478,
      ),
      Product(
        category: categoryAccessories,
        id: 1,
        isFeatured: true,
        name: (context) =>
            GalleryLocalizations.of(context)!.shrineProductStellaSunglasses,
        price: 58,
        assetAspectRatio: 329 / 247,
      ),
      Product(
        category: categoryAccessories,
        id: 2,
        isFeatured: false,
        name: (context) =>
            GalleryLocalizations.of(context)!.shrineProductWhitneyBelt,
        price: 35,
        assetAspectRatio: 329 / 228,
      ),
      Product(
        category: categoryAccessories,
        id: 3,
        isFeatured: true,
        name: (context) =>
            GalleryLocalizations.of(context)!.shrineProductGardenStrand,
        price: 98,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryAccessories,
        id: 4,
        isFeatured: false,
        name: (context) =>
            GalleryLocalizations.of(context)!.shrineProductStrutEarrings,
        price: 34,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryAccessories,
        id: 5,
        isFeatured: false,
        name: (context) =>
            GalleryLocalizations.of(context)!.shrineProductVarsitySocks,
        price: 12,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryAccessories,
        id: 6,
        isFeatured: false,
        name: (context) =>
            GalleryLocalizations.of(context)!.shrineProductWeaveKeyring,
        price: 16,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryClothing,
        id: 7,
        isFeatured: false,
        name: (context) =>
            'sweet potatoes',
        price: 45,
        assetAspectRatio: 329 / 221,
      ),
      Product(
        category: categoryClothing,
        id: 8,
        isFeatured: false,
        name: (context) =>
            'spinach',
        price: 38,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 9,
        isFeatured: false,
        name: (context) =>
            'potatoes',
        price: 70,
        assetAspectRatio: 219 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 10,
        isFeatured: false,
        name: (context) =>
            'peas',
        price: 70,
        assetAspectRatio: 329 / 221,
      ),
      Product(
        category: categoryClothing,
        id: 11,
        isFeatured: true,
        name: (context) =>
            'onions',
        price: 60,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 12,
        isFeatured: false,
        name: (context) =>
            'mushrooms',
        price: 178,
        assetAspectRatio: 329 / 219,
      ),
      Product(
        category: categoryClothing,
        id: 13,
        isFeatured: false,
        name: (context) =>
            'lettuce',
        price: 74,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 14,
        isFeatured: true,
        name: (context) =>
            'green beans',
        price: 38,
        assetAspectRatio: 219 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 15,
        isFeatured: true,
        name: (context) =>
            'eggplant',
        price: 48,
        assetAspectRatio: 329 / 219,
      ),
      Product(
        category: categoryClothing,
        id: 16,
        isFeatured: true,
        name: (context) =>
            'cucumbers',
        price: 98,
        assetAspectRatio: 219 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 17,
        isFeatured: true,
        name: (context) =>
            'cauliflower',
        price: 68,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 18,
        isFeatured: false,
        name: (context) =>
            'carrots',
        price: 38,
        assetAspectRatio: 329 / 223,
      ),
      Product(
        category: categoryClothing,
        id: 19,
        isFeatured: false,
        name: (context) =>
            'cabbage',
        price: 58,
        assetAspectRatio: 221 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 20,
        isFeatured: true,
        name: (context) =>
            'brussels sprouts',
        price: 42,
        assetAspectRatio: 329 / 219,
      ),
      Product(
        category: categoryClothing,
        id: 21,
        isFeatured: false,
        name: (context) =>
            'broccoli',
        price: 27,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 22,
        isFeatured: false,
        name: (context) =>
            'bell peppers',
        price: 24,
        assetAspectRatio: 222 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 23,
        isFeatured: false,
        name: (context) =>
            'asparagus',
        price: 58,
        assetAspectRatio: 219 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 24,
        isFeatured: true,
        name: (context) =>
            'tomatoes',
        price: 58,
        assetAspectRatio: 219 / 329,
      ),
    ];
    if (category == categoryAll) {
      return allProducts;
    } else {
      return allProducts.where((p) => p.category == category).toList();
    }
  }
}
