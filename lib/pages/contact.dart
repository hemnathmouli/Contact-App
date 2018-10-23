import 'package:flutter/material.dart';


var first_name_cont = new TextEditingController();
var last_name_cont = new TextEditingController();
var home_num_cont = new TextEditingController();

var current_id;

class contactNew extends StatelessWidget {

  final int id;
  final String first_name;
  final String last_name;
  final String home_number;
  final String image;

  contactNew({
    this.id = 0,
    this.first_name = '',
    this.last_name = '',
    this.home_number = '',
    this.image = ''
  });


  @override
  Widget build(BuildContext context) {

    Widget circleAvatar;

    current_id = id;

    if ( image == "" ) {
      circleAvatar= new CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.person, color: Colors.blueGrey,)
      );
    } else {
      circleAvatar= Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(image),
          radius: 23.0,
        ),
      );
    }

    first_name_cont.text = first_name;
    last_name_cont.text = last_name;
    home_num_cont.text = home_number;


    return wrapScafold(
      Container(
       padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
       child: Table(
         columnWidths: {0: FractionColumnWidth(0.2)},
         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                circleAvatar,
                Column(
                  children: <Widget>[
                    TextField (
                        decoration: InputDecoration(
                            hintText: 'First Name',
                        ),
                      controller: first_name_cont,
                    ),

                    TextField (
                        decoration: InputDecoration(
                            hintText: 'Last Name'
                        ),
                      controller: last_name_cont,
                    ),
                  ],
                )
              ]
            ),

            TableRow(
                children: [
                  new CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(Icons.phone, color: Colors.blueGrey,)
                  ),

                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        child: TextField (
                            decoration: InputDecoration(
                                hintText: 'Home'
                            ),
                          controller: home_num_cont,
                        ),
                      ),

                      TextField (
                          decoration: InputDecoration(
                              hintText: 'Work'
                          )
                      ),
                    ],
                  )
                ]
            )
          ],
        )
      )
    );
  }
}

Widget wrapScafold(Widget x) {
  return Scaffold(
    appBar: AppBar(
      title: Text("New Contact"),
      actions: <Widget>[
        _deleteButton()
      ],
    ),
    body: x,
    floatingActionButton: FloatingActionButton.extended(
      elevation: 4.0,
      icon: const Icon(Icons.check),
      label: const Text('Save contact'),
      onPressed: () {
      },
    ),
    floatingActionButtonLocation: current_id != 0 ? FloatingActionButtonLocation.centerDocked : FloatingActionButtonLocation.centerFloat,
    bottomNavigationBar: _getBottomBar(),
  );
}

Widget _getBottomBar () {
  if ( current_id != 0 ) {
    return BottomAppBar(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            color: Colors.green,
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.orange,
            icon: Icon(Icons.message),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  return null;
}

Widget _deleteButton() {
  if ( current_id != 0 ) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {

      },
    );
  } else {
    return Text('');
  }


}