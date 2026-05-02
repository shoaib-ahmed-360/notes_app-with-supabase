import 'package:flutter/material.dart';
import 'package:notes_app/add_note.dart';
import 'package:notes_app/shimmer.dart';
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
      // body:     return Scaffold(
      // Apply the 'Superb' Aesthetic Background
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.7, -0.6),
            radius: 1.3,
            colors: [
              Color(0xFFFFFFFF), // Light source
              Color(0xFFF2F0EC), // Soft paper tone
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                
                // App title with tighter letter spacing for premium look
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1C1B1A),
                    letterSpacing: -1.0,
                  ),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: isLoading 
                    ? const Shimmerscreen() 
                    : users.isEmpty 
                      ? const Center(
                          child: Text(
                            'No notes yet',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFB0AAA3),
                              letterSpacing: 0.1,
                            ),
                          ),
                        ) 
                      : ListView.builder(
                          itemCount: users.length,
                          padding: const EdgeInsets.only(top: 8),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFF1C1B1A).withOpacity(0.05),
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                title: Text(
                                  "${users[index]['title']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Color(0xFF1C1B1A),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${users[index]['description']}",
                                    style: TextStyle(
                                      color: const Color(0xFF1C1B1A).withOpacity(0.6),
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
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