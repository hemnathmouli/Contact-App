import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'contact.dart';

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
  await client.get('http://hemzware.com/me/contact.json');

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parsePhotos, response.body);
}

// A function that will convert a response body into a List<Photo>
List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int id;
  final String first_name;
  final String last_name;
  final String home_number;
  final String image;

  Photo({this.id, this.first_name, this.last_name, this.home_number, this.image});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      home_number: json['home_number'] as String,
      image: json['image'] as String,
    );
  }
}

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

//    contacts.forEach((k, v){
//      contact_list.add( ListTile(
//          leading:new CircleAvatar(
//            backgroundImage: AssetImage('assets/hemmy.png'),
//          ),
//          title: Text(v),
//          subtitle: Text(k),
//          trailing: Icon(Icons.edit),
//          onTap: () => Navigator.of(context).pushNamed('/contacts')
//      ));
//    });
//
//    return ListView(
//      children: contact_list,
//    );

    return FutureBuilder<List<Photo>>(
      future: fetchPhotos(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? PhotosList(photos: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class SetNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/contacts');
        }
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {

          Widget circleAvatar;

          if ( photos[index].image == "" ) {
            circleAvatar= new CircleAvatar(
              child: Text(getInitials(photos[index].first_name, photos[index].last_name)),
            );
          } else {
            circleAvatar= new CircleAvatar(
              backgroundImage: new NetworkImage(photos[index].image),
            );
          }

          return ListTile(
              leading: circleAvatar,
              title: Text(photos[index].first_name+" "+photos[index].last_name),
              subtitle: Text(photos[index].home_number),
              trailing: Icon(Icons.edit),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new contactNew(
                    id: photos[index].id,
                    first_name: photos[index].first_name,
                    last_name: photos[index].last_name,
                    home_number: photos[index].home_number,
                    image: photos[index].image
                )),
              )
          );
        },
        itemCount: photos.length,
    );
  }
}

String getInitials( String first_name, String last_name ) {
  String fn, ln;
  try {
    fn = first_name.split('')[0];
  } catch (e) {
    fn = '';
  }

  try {
    ln = last_name.split('')[0];
  } catch (e) {
    ln = '';
  }

  return (fn+ln).toUpperCase();

}