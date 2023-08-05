import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SMSScreen extends StatelessWidget {
  static const platform = MethodChannel('sms_fetch_channel');

  Future<List<String>> fetchSMS() async {
    try {
      final List<dynamic> messages =
          await platform.invokeMethod('fetchSMS') ?? [];
      return messages.cast<String>();
    } catch (e) {
      print('Error fetching SMS: $e');
      return [];
    }
  }

  Future<void> sendSMSDataToFirestore(List<String> smsMessages) async {
    // Initialize the Firestore instance
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      // Replace 'your_collection' with the name of the collection where you want to store the SMS data.
      final collectionReference = firestoreInstance.collection('sms');

      // Create a document to store the SMS data. You can use a unique ID as the document name.
      final documentReference = collectionReference.doc();

      // Store the SMS messages as a field in the Firestore document.
      await documentReference.set({'sms': smsMessages});
    } catch (e) {
      print('Error sending SMS data to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch SMS and Send to Firestore'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            List<String> smsMessages = await fetchSMS();
            await sendSMSDataToFirestore(smsMessages);

            print('SMS data sent to Firestore successfully.');
          },
          child: Text('Fetch SMS and Send to Firestore'),
        ),
      ),
    );
  }
}