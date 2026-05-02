import 'package:flutter/material.dart';
import 'package:notes_app/add_note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  bool is_loading = false;

  List<Map<String , dynamic >> users = [];
  void fetch () async {
    try {
      setState(() {
        is_loading = true;
      });
      dynamic data = await Supabase.instance.client.from("tblnote").select().order("id" , ascending: true);
      print(data);
      setState(() {
        
      
      users.clear();
      users = data;
      });
    } catch (e) {
      print(e);
    } finally {
      is_loading = false;
    }
  }
  @override
 
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F6F3),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF1C1B1A),
          surface: const Color(0xFFF7F6F3),
        ),
        useMaterial3: true,
      ),
    
      home: NotesScreen(users: users, isLoading: is_loading , onrefresh: fetch,),
    );
  }
}

class NotesScreen extends StatelessWidget {
   final List<Map<String, dynamic>> users;
  final bool isLoading;
  final VoidCallback onrefresh;
  

  // 2. Create the constructor
  const NotesScreen({super.key, required this.users, required this.isLoading , required this.onrefresh});
  // const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              // App title
              const Text(
                'Notes',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1B1A),
                  letterSpacing: -0.5,
                ),
              ),

              Expanded(
                child: isLoading ? Center(child: CircularProgressIndicator()) :
                 users.isEmpty ? Center(
                  child: Text(
                    'No notes yet',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFFB0AAA3),
                      letterSpacing: 0.1,
                    ),
                  ),
                ) :
                 ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${users[index]['title']}"),
                    subtitle: Text("${users[index]['description']}"),
                  );
                },),
              ),

              // Empty state — centered in remaining space
              // const Expanded(
              //   child: 
              // ),
            ],
          ),
        ),
      ),

      // Floating Add button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
        final result = await  Navigator.push(context, MaterialPageRoute(builder: (context) => NewNoteScreen(),));
          // TODO: open new note
          if (result == true) {
           onrefresh();
          }
        },
        backgroundColor: const Color(0xFF1C1B1A),
        foregroundColor: const Color(0xFFF7F6F3),
        elevation: 2,
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          'New note',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      
    );
    
  }
}