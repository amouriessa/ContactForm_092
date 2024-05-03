import 'package:contact_form/controller/contact_controller.dart';
import 'package:contact_form/models/contact.dart';
import 'package:contact_form/widgets/contact_screen.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ContactController _controller = ContactController();
  
  @override
  void initState() {
    super.initState();
    _controller.getPeople();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: FutureBuilder<List<Contact>>(
        future: _controller.getPeople(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Contact contact = snapshot.data![index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.email),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact.photo),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactScreen())
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}