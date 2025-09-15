// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_dvp/features/data/models/address_model.dart';
import 'package:prueba_dvp/features/data/models/user_model.dart';
import 'package:prueba_dvp/features/presentation/pages/address_form_page.dart';
import 'package:prueba_dvp/features/presentation/viewmodels/user_view_model.dart';
import 'package:intl/intl.dart';

class UserFormPage extends StatefulWidget {
  final UserModel? user;
  const UserFormPage({super.key, this.user});

  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  DateTime? _birthDate;
  late List<AddressModel> _addresses;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.name);
    _lastNameController = TextEditingController(text: widget.user?.lastName);
    _birthDate = widget.user?.birthDate;
    _addresses = widget.user?.addresses ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _birthDate) {
      setState(() {
        _birthDate = pickedDate;
      });
    }
  }

  Future<void> _addAddress() async {
    final result = await Navigator.of(context).push<AddressModel>(
      MaterialPageRoute(builder: (context) => const AddressFormPage()),
    );
    if (result != null) {
      setState(() {
        _addresses.add(result);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _birthDate != null) {
      if (widget.user == null) {
        final user = UserModel(
          name: _nameController.text,
          lastName: _lastNameController.text,
          birthDate: _birthDate!,
          addresses: _addresses,
        );
        Provider.of<UserViewModel>(context, listen: false).addUser(user).then((_) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Usuario agregado'),
              content: const Text('El usuario ha sido agregado exitosamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          );
        });
      } else {
        final updatedUser = UserModel(
          id: widget.user!.id,
          name: _nameController.text,
          lastName: _lastNameController.text,
          birthDate: _birthDate!,
          addresses: _addresses,
        );
        Provider.of<UserViewModel>(context, listen: false).updateUser(updatedUser);
        Navigator.of(context).pop();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Por favor, rellene todos los campos y agregue al menos una dirección.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Agregar usuario' : 'Editar usuario'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                FadeInUp(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un apellido';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _birthDate == null
                              ? 'No se ha seleccionado fecha'
                              : 'Fecha de nacimiento: ${DateFormat.yMd().format(_birthDate!)}',
                        ),
                      ),
                      TextButton(
                        onPressed: _pickDate,
                        child: const Text('Seleccionar fecha'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  child: Container(
                    width: size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: _addAddress,
                      child: const Text('Agregar Dirección'),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _addresses.length,
                  itemBuilder: (context, index) {
                    final address = _addresses[index];
                    return FadeInUp(
                      delay: Duration(milliseconds: 200 * (index + 1)),
                      child: ListTile(
                        title: Text('${address.city}, ${address.state}'),
                        subtitle: Text(address.country),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.03),
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  child: Container(
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Guardar Usuario'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
