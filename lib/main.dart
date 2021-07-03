import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/screens/screens.dart';
import 'package:mobile/screens/splash/splash_screen.dart';
import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';

void main() {
  // debugPaintSizeEnabled = true;  // This would display helpful markers on the screen
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Only widgets that are listening to changes
      // in these Provider will be rebuilt
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          // The provider you want
          create: null,
          update: (ctx, authProvider, previousProductsProvider) {
            return ProductsProvider(
                authProvider.token,
                previousProductsProvider == null
                    ? []
                    : previousProductsProvider.items,
                authProvider.userId);
          },
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          // The provider you want
          create: null,
          update: (ctx, authProvider, previousOrdersProvider) {
            return OrdersProvider(
                authProvider.token,
                previousOrdersProvider == null
                    ? []
                    : previousOrdersProvider.items,
                authProvider.userId);
          },
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My Shop',
            theme: theme(),
            initialRoute: SplashScreen.routeName,
            routes: routes,
          );
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider( // Only widgets that are listening to changes
  // in these Provider will be rebuilt
  //     create: (BuildContext context) {
  //       return ProductsProvider();
  //     },
  //     child: MaterialApp(
  //       title: 'Flutter Demo',
  //       theme: ThemeData(
  //         primarySwatch: Colors.purple,
  //         accentColor: Colors.deepOrange,
  //         fontFamily: 'Overpass',
  //       ),
  //       home:ProductsScreen(),
  //       routes: routes,
  //     ),
  //   );
  // }
}
