import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'data/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final database = DataBasePrefs();
  await database.init();
  
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final DataBasePrefs database;
  
  const MyApp({super.key, required this.database});
  
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: database,
      child: MaterialApp(
        title: 'Camp David',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const AppNavigation(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}