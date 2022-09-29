import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Contacts Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<bool> allowPermission() async {
    return Permission.contacts.request().isGranted;
  }

  Future<bool> doesContactExists() async {
    List<Contact> contacts = await FlutterContacts.getContacts();
    return contacts.any((element) => element.displayName == 'João Sessa');
  }

  void insertNewContact() async {
    if (await allowPermission()) {
      if (!(await doesContactExists())) {
        final newContact = Contact()
          ..name.first = 'João'
          ..name.last = 'Sessa'
          ..phones = [Phone('+55 (27) 99713-2002')];
        await newContact.insert();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: insertNewContact,
              child: const Text('Insert new Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
