import 'package:adriel_flutter_app/doc_manager/quill/quill_screen.dart';
import 'package:adriel_flutter_app/doc_manager/quill/settings/cubit/settings_cubit.dart';
import 'package:adriel_flutter_app/doc_manager/views/documents_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocsRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: ThemeMode.system, // System theme mode
            home: Navigator(
              onGenerateRoute: (settings) {
                // Define your routes here
                if (settings.name == '/' ||
                    settings.name == DocumentListPage.routeName) {
                  return MaterialPageRoute(
                    builder: (context) => DocumentListPage(),
                  );
                } else if (settings.name == QuillScreen.routeName) {
                  return MaterialPageRoute(
                    builder: (context) {
                      final args = settings.arguments as QuillScreenArgs;
                      return QuillScreen(
                        args: args,
                      );
                    },
                  );
                } else {
                  // Handle unknown routes
                  return MaterialPageRoute(
                    builder: (context) => NotFoundPage(),
                  );
                }
              },
            ),
          );
          // Your code here
        },
      ),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Found'),
      ),
      body: Center(
        child: Text('Page Not Found'),
      ),
    );
  }
}
