import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../../User/credentialsFile/user_model.dart';
import '../../User/credentialsFile/user_repository.dart';

class ExhibitionAnnouncementPage extends StatefulWidget {
  @override
  _ExhibitionAnnouncementPageState createState() =>
      _ExhibitionAnnouncementPageState();
}

class _ExhibitionAnnouncementPageState
    extends State<ExhibitionAnnouncementPage> {
  final venueController = TextEditingController();
  final capacityController = TextEditingController();
  final dateController = TextEditingController(); // Added
  final timeController = TextEditingController(); // Added
  final userRepo=Get.put(User_repo());
  List<dynamic> dynamicEmailArray = [];
  var totalEmails;

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    venueController.dispose();
    capacityController.dispose();
    dateController.dispose(); // Added
    timeController.dispose(); // Added
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAlluserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              totalEmails =snapshot.data!.length;

              for(int i=0;i<snapshot.data!.length;i++)
              {
                dynamicEmailArray.add(snapshot.data![i].email);
              }
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 880,
                    child: Image.asset(
                      "assests/images/dbpic2.jpeg",
                      fit: BoxFit.fitHeight,
                    ),
                    //add background image here
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('exhibition')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final exhibitions =
                                snapshot.data!.docs.reversed.toList();
                                return ListView.separated(
                                  itemCount: exhibitions.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot exhibition =
                                    exhibitions[index];
                                    final venue = exhibition['venue'];
                                    final capacity = exhibition['capacity'];
                                    final date = exhibition['date'];
                                    final time = exhibition['time'];
                                    return Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        child: ListTile(
                                          title: Text('Exhibition ${index + 1}'),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text('Venue: $venue'),
                                              Text('Capacity: $capacity'),
                                              Text('Date: $date'),
                                              Text('Time: $time'),
                                            ],
                                          ),
                                          onTap: () {
                                            // Handle tapping on an exhibition
                                          },
                                        ),
                                      ),
                                      secondaryActions: [
                                        IconSlideAction(
                                          caption: 'Delete',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () {
                                            _deleteExhibition(exhibition.id);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          child:Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed:() {
                                _showAddExhibitionDialog(context);
                              } ,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xffA770EF), Color(0xffCF8BF3), Color(0xffFDB99B)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child:
                                  Text("Add Exhibition",style: TextStyle(color: Colors.white,fontSize: 18),),
                                ),
                              ),
                            ),
                          ),

                        )



                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('User not found');
            } else {
              return Text('Something went wrong');
            }
          }
          else {
            // Return Center widget to display CircularProgressIndicator in the center
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )

    );
  }

  void _showAddExhibitionDialog(BuildContext context) {
    final List<String> venues = [
      'The Chenab Club',
      'Lyallpur Galleria',
      'Faisalabad Serena Hotel'
    ];
    final List<int> capacities = [100, 200, 300];

    String selectedVenue = venues[0]; // Default value
    int selectedCapacity = capacities[0]; // Default value

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedVenue,
                    items: venues.map((String venue) {
                      return DropdownMenuItem<String>(
                        value: venue,
                        child: Text(venue),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedVenue = value!;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Venue',
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: selectedCapacity,
                    items: capacities.map((int capacity) {
                      return DropdownMenuItem<int>(
                        value: capacity,
                        child: Text('$capacity'),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        selectedCapacity = value!;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Capacity',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dateController.text =
                          pickedDate.toString().split(' ')[0];
                        });
                      }

                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          timeController.text = pickedTime.format(context);
                        });
                      }
                    },
                    child: Text('Pick Date and Time'),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 300,
                    height: 40,
                    child:Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:() async {
                          // Check if an exhibition with the same details exists
                          final existingExhibition = await FirebaseFirestore
                              .instance
                              .collection('exhibition')
                              .where('venue', isEqualTo: selectedVenue)
                              .where('date', isEqualTo: dateController.text)
                              .where('time', isEqualTo: timeController.text)
                              .get();

                          if (existingExhibition.docs.isEmpty) {
                            CollectionReference collRef = FirebaseFirestore.instance
                                .collection('exhibition');
                            collRef.add({
                              'venue': selectedVenue,
                              'capacity': selectedCapacity,
                              'date': dateController.text,
                              'time': timeController.text,
                            });
                            for(int i=0;i<totalEmails;i++)
                            {
                              sendmail(dynamicEmailArray[i],selectedVenue);
                            }
                            Navigator.of(context).pop();
                          } else {
                            // Display a message indicating that the exhibition already exists
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Exhibition with the same date, time, and venue already exists.'),
                            ));
                          }
                        } ,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffA770EF), Color(0xffCF8BF3), Color(0xffFDB99B)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child:
                            Text("Add Exhibition",style: TextStyle(color: Colors.white,fontSize: 18),),
                          ),
                        ),
                      ),
                    ),

                  )

                ],
              );
            },
          ),
        );
      },
    );
  }

  void _deleteExhibition(String id) {
    FirebaseFirestore.instance.collection('exhibition').doc(id).delete();
  }
  Future<List<User_model>> getAlluserData() async {
    return await userRepo.getAllUserDetail();
  }
}

sendmail(String mail,String venue) async {
  String username = 'ghazih808@gmail.com';
  String password = 'kfia mddb tbcs yyci';

  final smtpServer = gmail(username, password);
  final message = Message()
    ..from = Address('takhleeqish@gmail.com', 'Takhleeqish')
    ..recipients.add(mail)
  // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
  // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Takhleeqish! Artist Exhibition '
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Art Exhibition.</h1>\n<p>Hey! An amazing exhibition at $venue to learn and enhance skills has been scheduled. Go check it out!.</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: ExhibitionAnnouncementPage(),
  ));



}
