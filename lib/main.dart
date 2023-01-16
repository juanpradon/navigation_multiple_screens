import 'package:flutter/material.dart';
import 'package:navigation_multiple_screens/dummy_data.dart';
import 'models/meal.dart';
import 'screens/category_meals_screen.dart';
import 'screens/filters_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where(
        (meal) {
          if (_filters['gluten']! && !meal.isGlutenFree) return false;
          if (_filters['lactose']! && !meal.isLactoseFree) return false;
          if (_filters['vegan']! && !meal.isVegan) return false;
          if (_filters['vegetarian']! && !meal.isVegetarian) return false;
          return true;
        },
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodySmall: TextStyle(
                fontSize: 14,
                color: const Color.fromRGBO(50, 81, 31, 1),
              ),
              bodyMedium: TextStyle(
                fontSize: 18,
                color: const Color.fromRGBO(20, 21, 21, 1),
              ),
              bodyLarge: TextStyle(
                fontSize: 22,
                color: const Color.fromRGBO(20, 51, 51, 1),
              ),
              titleSmall: const TextStyle(
                fontSize: 14,
                fontFamily: 'RobotoCondensed',
              ),
              titleMedium: const TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
              titleLarge: const TextStyle(
                fontSize: 22,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
      /*  onGenerateRoute: (settings) {
        print(settings.arguments);
          return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },*/
      onUnknownRoute: (settings) {
        print(settings.arguments);
        /*   return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );*/
      },
    );
  }
}
