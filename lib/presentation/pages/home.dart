import 'package:flutter/material.dart';
import 'package:sampleproject/data/firestore_service.dart';
import 'package:sampleproject/data/model/note.dart';
import 'package:sampleproject/presentation/pages/note_detail.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Flutter'),
      ),
      body: StreamBuilder(
        stream: FirestoreService().getNotes() ,
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot){
          if (snapshot.hasError || snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              Note note = snapshot.data[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.description),
                onTap: () => Navigator.push(
                  context, MaterialPageRoute(
                    builder: (_) => NoteDetailPage(note: note,),
                    ),
                ),
              );
            },
            );
        },
        ),
    );
  } 
}