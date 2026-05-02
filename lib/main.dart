import 'package:flutter/material.dart';
import 'package:notes_app/notes.dart';
// import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(anonKey: 
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNkaWtscXh1b3Vud2lldW1yaWhnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc0NDgzMDMsImV4cCI6MjA5MzAyNDMwM30.eeCoR0qfidLW7quqEBuDgoM2Yoqhy2rX1GGxfQhi9kA",
  url: "https://sdiklqxuounwieumrihg.supabase.co",);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return MaterialApp(
      title: 'notes app',
      home: NotesApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
