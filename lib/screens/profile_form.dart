import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_list/blocs/user/user_bloc.dart';
import 'package:soft_list/blocs/user/user_event.dart';
import 'package:soft_list/blocs/user/user_state.dart';
import 'package:soft_list/models/user.dart';

class ProfileFormScreen extends StatelessWidget {
  const ProfileFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final TextEditingController nameController = TextEditingController(
          text: state is UserLoaded ? state.user.name : '',
        );
        final TextEditingController currencyController = TextEditingController(
          text: state is UserLoaded ? state.user.currency : '',
        );

        return Scaffold(
          appBar: AppBar(title: const Text('Perfil')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: currencyController,
                  decoration: const InputDecoration(
                    labelText: 'Moeda (ex.: BRL)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        currencyController.text.isNotEmpty) {
                      final user = User(
                        name: nameController.text,
                        currency: currencyController.text,
                      );
                      context.read<UserBloc>().add(UpdateUser(user));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
