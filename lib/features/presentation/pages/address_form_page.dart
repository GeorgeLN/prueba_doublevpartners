import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:prueba_dvp/features/data/models/address_model.dart';

class AddressFormPage extends StatefulWidget {
  const AddressFormPage({super.key});

  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = AddressModel(
        country: _countryController.text,
        state: _stateController.text,
        city: _cityController.text,
      );
      Navigator.of(context).pop(address);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Dirección'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              FadeInUp(
                child: TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: 'País'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un país';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(labelText: 'Estado/Departamento'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un estado/departamento';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'Ciudad'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una ciudad';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.03),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Container(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _saveAddress,
                    child: const Text('Guardar dirección'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
