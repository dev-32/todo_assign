import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assign/bloc/notes_bloc/category_cubit.dart';
import 'package:todo_assign/bloc/notes_bloc/flag_cubit.dart';
import 'package:todo_assign/bloc/notes_bloc/note_cubit.dart';
import 'package:todo_assign/bloc/posts_bloc/post_cubit.dart';
import 'package:todo_assign/constant/theme.dart';
import 'package:todo_assign/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.bottom]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NoteCubit>(
            create: (BuildContext context) => NoteCubit([]),
          ),
          BlocProvider<CategoryCubit>(
            create: (BuildContext context) => CategoryCubit(),
          ),
          BlocProvider<FlagCubit>(
            create: (BuildContext context) => FlagCubit(),
          ),
          BlocProvider<PostCubit>(
            create: (BuildContext context) => PostCubit(),
          ),
        ],
        child: MaterialApp(
            theme: AppThemeData.appTheme,
            title: 'Todo List Assign',
            debugShowCheckedModeBanner: false,
            home: const SplashScreen()));
  }
}
