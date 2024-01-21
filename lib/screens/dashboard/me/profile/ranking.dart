import 'package:flutter/material.dart';
import 'package:get/get.dart';

List users = [
  {
    'name': 'Girl Friend.Com',
    'subname': 'Sabhi New Users Ka swagat',
    'photUrl':
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2lybHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  },
  {
    'name': 'FRIENDSHIP CLUB',
    'subname': 'Come & Share ur fellings',
    'photUrl':
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2lybHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  },
  {
    'name': 'Gf Bf Dating Eoom',
    'subname': 'Agar Apko banai hai Grilfrie....',
    'photUrl':
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2lybHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  },
  {
    'name': 'Nisha Hosting......',
    'subname': 'Welcome to my room,lets.',
    'photUrl':
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2lybHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  },
  {
    'name': 'Dimple Ayesha',
    'subname': 'Welcome to my room,lets.',
    'photUrl':
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2lybHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  },
  {
    'name': 'Sheikh Papia',
    'subname': 'Welcome to my room,lets.',
    'photUrl':
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2lybHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  },
  {
    'name': 'no love Only Friend',
    'subname': 'Welcome to my room,lets.',
    'photUrl':
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2lybHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  },
];

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingState();
}

class _RankingState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: const Text('Room'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(23.0 * a),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Room',
                    style: TextStyle(fontSize: 20 * a, fontFamily: 'Poppins'),
                  )),
              ListTile(
                leading: Image.network(
                    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2lybHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'),
                title: Text(
                  'name',
                  style:
                      TextStyle(fontSize: 25 * a, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'subname',
                  style: TextStyle(
                    fontSize: 15 * a,
                  ),
                ),
              ),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Joined',
                    style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                  )),
              ListView(
                shrinkWrap: true,
                children: users.map((e) {
                  return ListTile(
                    leading: Image.network(e['photUrl']),
                    title: Text(
                      e['name'],
                      style: TextStyle(
                          fontSize: 20 * a, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      e['subname'],
                      style: TextStyle(
                        fontSize: 15 * a,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
