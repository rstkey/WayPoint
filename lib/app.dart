// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/gallery_options.dart';
import 'layout/adaptive.dart';
import 'model/app_state_model.dart';
import 'model/product.dart';
import 'page_status.dart';
import 'pages/authentication_screen.dart';
import 'pages/home.dart';
import 'pages/verify_phone_number_screen.dart';
import 'themes/theme.dart';
import 'widgets/backdrop.dart';
import 'widgets/category_menu_page.dart';
import 'widgets/expanding_bottom_sheet.dart';
import 'widgets/scrim.dart';
import 'widgets/supplemental/layout_cache.dart';

class ScreenArguments {
  final String number;

  ScreenArguments(this.number);
}

class ShrineApp extends StatefulWidget {
  const ShrineApp({super.key});

  @override
  State<ShrineApp> createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp>
    with TickerProviderStateMixin, RestorationMixin {
  // Controller to coordinate both the opening/closing of backdrop and sliding
  // of expanding bottom sheet
  late AnimationController _controller;

  // Animation Controller for expanding/collapsing the cart menu.
  late AnimationController _expandingController;

  final _RestorableAppStateModel _model = _RestorableAppStateModel();
  final RestorableDouble _expandingTabIndex = RestorableDouble(0);
  final RestorableDouble _tabIndex = RestorableDouble(1);
  final Map<String, List<List<int>>> _layouts = {};

  @override
  String get restorationId => 'shrine_app_state';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_model, 'app_state_model');
    registerForRestoration(_tabIndex, 'tab_index');
    registerForRestoration(
      _expandingTabIndex,
      'expanding_tab_index',
    );
    _controller.value = _tabIndex.value;
    _expandingController.value = _expandingTabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
      value: 1,
    );
    // Save state restoration animation values only when the cart page
    // fully opens or closes.
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _tabIndex.value = _controller.value;
      }
    });
    _expandingController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // Save state restoration animation values only when the menu page
    // fully opens or closes.
    _expandingController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _expandingTabIndex.value = _expandingController.value;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _expandingController.dispose();
    _tabIndex.dispose();
    _expandingTabIndex.dispose();
    super.dispose();
  }

  Widget mobileBackdrop() {
    return Backdrop(
      frontLayer: const ProductPage(),
      backLayer: CategoryMenuPage(onCategoryTap: () => _controller.forward()),
      frontTitle: const Text('SHRINE'),
      backTitle: Text(GalleryLocalizations.of(context)!.shrineMenuCaption),
      controller: _controller,
    );
  }

  Widget desktopBackdrop() {
    return const DesktopBackdrop(
      frontLayer: ProductPage(),
      backLayer: CategoryMenuPage(),
    );
  }

  // Closes the bottom sheet if it is open.
  Future<bool> _onWillPop() async {
    final status = _expandingController.status;
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.forward) {
      await _expandingController.reverse();
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Widget home = LayoutCache(
      layouts: _layouts,
      child: PageStatus(
        menuController: _controller,
        cartController: _expandingController,
        child: LayoutBuilder(
          builder: (context, constraints) => HomePage(
            backdrop: isDisplayDesktop(context)
                ? desktopBackdrop()
                : mobileBackdrop(),
            scrim: Scrim(controller: _expandingController),
            expandingBottomSheet: ExpandingBottomSheet(
              hideController: _controller,
              expandingController: _expandingController,
            ),
          ),
        ),
      ),
    );

    return ScopedModel<AppStateModel>(
      model: _model.value,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: MaterialApp(
          // By default on desktop, scrollbars are applied by the
          // ScrollBehavior. This overrides that. All vertical scrollables in
          // the gallery need to be audited before enabling this feature,
          // see https://github.com/flutter/gallery/issues/541
          scrollBehavior:
              const MaterialScrollBehavior().copyWith(scrollbars: false),
          restorationScopeId: 'shrineApp',
          title: 'Shrine',
          debugShowCheckedModeBanner: false,
          initialRoute: AuthenticationScreen.id,
          // routes: {
          //   ShrineApp.loginRoute: (context) => AuthenticationScreen(),
          //   ShrineApp.homeRoute: (context) => home,
          //   ShrineApp.verifyRoute : (context) => VerifyPhoneNumberScreen(phoneNumber: "212")
          // },
          onGenerateRoute: (settings) {
            final args = settings.arguments as dynamic;
            switch (settings.name) {
              case AuthenticationScreen.id:
                return MaterialPageRoute(
                    builder: (context) => (const AuthenticationScreen()));
              case VerifyPhoneNumberScreen.id:
                return MaterialPageRoute(
                    builder: (context) =>
                        (VerifyPhoneNumberScreen(phoneNumber: args)));
              case HomePage.id:
                return MaterialPageRoute(builder: (context) => (home));
              default:
                return MaterialPageRoute(
                  builder: (_) => Scaffold(
                    body: Center(
                      child: Text('ROUTE \n\n$settings.name\n\nNOT FOUND'),
                    ),
                  ),
                );
            }
          },
          theme: shrineTheme.copyWith(
            platform: GalleryOptions.of(context).platform,
          ),
          // L10n settings.
          localizationsDelegates: GalleryLocalizations.localizationsDelegates,
          supportedLocales: GalleryLocalizations.supportedLocales,
          locale: GalleryOptions.of(context).locale,
        ),
      ),
    );
  }
}

class _RestorableAppStateModel extends RestorableListenable<AppStateModel> {
  @override
  AppStateModel createDefaultValue() => AppStateModel()..loadProducts();

  @override
  AppStateModel fromPrimitives(Object? data) {
    final appState = AppStateModel()..loadProducts();
    final appData = Map<String, dynamic>.from(data as Map);

    // Reset selected category.
    final categoryIndex = appData['category_index'] as int;
    appState.setCategory(categories[categoryIndex]);

    // Reset cart items.
    final cartItems = appData['cart_data'] as Map<dynamic, dynamic>;
    cartItems.forEach((dynamic id, dynamic quantity) {
      appState.addMultipleProductsToCart(id as int, quantity as int);
    });

    return appState;
  }

  @override
  Object toPrimitives() {
    return <String, dynamic>{
      'cart_data': value.productsInCart,
      'category_index': categories.indexOf(value.selectedCategory),
    };
  }
}
