
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


// ─────────────────────────────────────────────
// New Note Screen
// ─────────────────────────────────────────────
class NewNoteScreen extends StatefulWidget {

    final Map<String, dynamic>? note; 

  // 2. Add 'this.note' to the constructor
  const NewNoteScreen({super.key, this.note}); 
  
//  const  NewNoteScreen({super.key});

  @override
  State<NewNoteScreen> createState() => NewNoteScreenState();
  
}

class NewNoteScreenState extends State<NewNoteScreen> {


late TextEditingController titlecnt;
late TextEditingController descriptioncnt;

@override
void initState(){
super.initState() ;

titlecnt = TextEditingController(text: widget.note? ['title']?? "");
descriptioncnt = TextEditingController(text: widget.note? ['description']?? "");
}
  // TextEditingController titlecnt = TextEditingController();
  //  TextEditingController descriptioncnt = TextEditingController();

   bool is_loading = false;

   Future<void> add_note (String title , String Description) async {
    try{
      setState(() {
        is_loading = true;
      });
      if (widget.note == null ) {
          await Supabase.instance.client.from("tblnote").insert({
        "title" : title,
        "description" : Description,
      }
      );
      }
      else{
        await Supabase.instance.client.
        from("tblnote").update({'title' :title , 'description' : Description})
        .eq("id", widget.note!['id']);
      }
    
    } catch (e) {
      print(e);
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── Back button ──────────────────────────
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                color: const Color(0xFF1C1B1A),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),

              const SizedBox(height: 32),

              // ── Title field ──────────────────────────
              TextField(
                controller: titlecnt ,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1B1A),
                  letterSpacing: -0.3,
                ),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFCDC9C3),
                    letterSpacing: -0.3,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 1,
              ),

              const SizedBox(height: 4),

              // ── Thin divider ─────────────────────────
              const Divider(color: Color(0xFFE8E4DF), thickness: 1),

              const SizedBox(height: 12),

              // ── Description field ────────────────────
               Expanded(
                child: TextField(
                  controller: descriptioncnt,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF3D3A36),
                    height: 1.6,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Write something...',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFCDC9C3),
                      height: 1.6,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),

              // ── Add Note button ──────────────────────
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: () async {
                      if (titlecnt.text.isNotEmpty) {
                          await add_note(titlecnt.text , descriptioncnt.text);
                      }
                      // is_loading ? Center(child: CircularProgressIndicator()) : 
                  
                     if (mounted) Navigator.pop(context , true);
                      
                      // TODO: add note logic
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1C1B1A),
                      foregroundColor: const Color(0xFFF7F6F3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Add note',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
