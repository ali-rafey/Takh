import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/User/payments/database/model/model.dart';
import 'package:takhleekish/User/payments/database/repository/Repository.dart';

import '../../../Artist/artistPersonal/artist_authentication.dart';
import '../../credentialsFile/user_model.dart';
import '../../credentialsFile/user_repository.dart';

class PaymentStatus extends StatelessWidget
{
  final authrepo = Get.put(Artist_Auth());

  final userRepo = Get.put(User_repo());
  final PaymentRepo=Get.put(Payment_repo());
  var email;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              email=snapshot.data!.email;
              return FutureBuilder(
                future: getAllData(email),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Scaffold(
                          body:Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 880,
                                child: Image.asset("assests/images/dbpic2.jpeg"
                                  ,fit: BoxFit.fitHeight,),
                                //add background image here
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        itemCount: snapshot.data!.length, // Number of auction (fetch from the database)
                                        itemBuilder: (context, index) {

                                          return Slidable(
                                            actionPane: SlidableDrawerActionPane(),
                                            actionExtentRatio: 0.25,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15.0)
                                              ),
                                              child: ListTile(
                                                title: Text('Receipt ${index + 1}'),
                                                subtitle: Text("Total Amount:  ${snapshot.data![index].bill}"),
                                                trailing: Text(" ${snapshot.data![index].status}"),
                                                onTap: () {},
                                              ),
                                            ),
                                          );


                                        }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
                                      ),
                                    ),

                                  ],
                                ),
                              ) ,
                            ],
                          )
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
      ),
    );
  }
  Future<User_model?> getData() async {
    final email = authrepo.firebaseUser.value?.email;
    if (email != null) {
      return await userRepo.getUserDetail(email);
    }
    return null; // Handle the case where email is null
  }
  Future<List<Payment_model>> getAllData(String email) async {
    return await PaymentRepo.getSpecificReceiptDetail(email);
  }
}
