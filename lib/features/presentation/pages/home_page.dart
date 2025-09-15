import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:prueba_dvp/core/widgets/add_user_floating_button.dart';
import 'package:prueba_dvp/features/presentation/pages/user_details_page.dart';
import 'package:prueba_dvp/features/presentation/pages/user_form_page.dart';
import 'package:prueba_dvp/features/presentation/viewmodels/user_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios'),
        centerTitle: true,
      ),
      body: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.state) {
            case ViewState.loading:
              return const Center(child: CircularProgressIndicator());

            case ViewState.content:
              if (viewModel.users.isEmpty) {
                return Center(
                    child: Text(
                  'No se encontraron usuarios.',
                  style: TextStyle(fontSize: size.width * 0.045),
                ));
              }
              return ListView.builder(
                itemCount: viewModel.users.length,
                itemBuilder: (context, index) {
                  final user = viewModel.users[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UserFormPage(user: user),
                              ),
                            );
                          },
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Editar',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            Provider.of<UserViewModel>(context, listen: false).deleteUser(user.id!);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Eliminar',
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        size: size.width * 0.08,
                      ),
                      title: Text('${user.name} ${user.lastName}'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserDetailsPage(user: user),
                          ),
                        );
                      },
                    ),
                  );
                },
              );

            case ViewState.error:
              return Center(
                child: Text(
                  'Ha ocurrido un error.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: size.width * 0.045),
                ),
              );
          } // Switch
        },
      ),
      floatingActionButton: ZoomIn(
        child: const AddUserFloatingButton(),
      ),
    );
  }
}