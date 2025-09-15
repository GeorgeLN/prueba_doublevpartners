// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:prueba_dvp/core/widgets/add_user_floating_button.dart';
import 'package:prueba_dvp/features/data/models/address_model.dart';
import 'package:prueba_dvp/features/data/models/user_model.dart';
import 'package:prueba_dvp/features/presentation/pages/address_form_page.dart';
import 'package:prueba_dvp/features/presentation/viewmodels/user_view_model.dart';

class UserDetailsPage extends StatefulWidget {
  final UserModel user;

  const UserDetailsPage({super.key, required this.user});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  Future<void> _addAddress() async {
    final result = await Navigator.of(context).push<AddressModel>(
      MaterialPageRoute(builder: (context) => const AddressFormPage()),
    );
    if (result != null) {
      setState(() {
        _user.addresses.add(result);
      });
      Provider.of<UserViewModel>(context, listen: false).updateUser(_user);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('${_user.name} ${_user.lastName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_location),
            onPressed: _addAddress,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            FadeInLeft(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Nombres: ',
                      style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: _user.name,
                      style: TextStyle(fontSize: size.width * 0.045, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            FadeInLeft(
              delay: const Duration(milliseconds: 200),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Apellidos: ',
                      style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: _user.lastName,
                      style: TextStyle(fontSize: size.width * 0.045, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            FadeInLeft(
              delay: const Duration(milliseconds: 400),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Fecha de Nacimiento: ',
                      style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: DateFormat.yMd().format(_user.birthDate),
                      style: TextStyle(fontSize: size.width * 0.045, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            FadeInUp(
              child: Text(
                'Direcciones:',
                style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Expanded(
              child: ListView.builder(
                itemCount: _user.addresses.length,
                itemBuilder: (context, index) {
                  final address = _user.addresses[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: 200 * (index + 1)),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: size.height / 150),
                      child: ListTile(
                        title: Text('${address.city}, ${address.state}'),
                        subtitle: Text(address.country),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const AddUserFloatingButton(),
    );
  }
}
