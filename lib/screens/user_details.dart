import 'package:flutter/material.dart';
import '../models/user_model.dart';

//? StateLess details screen as its only used for  reading data!

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //! get selected user as passed argument from prev screen
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        centerTitle: true,
      ),
      
      //? for responsiveness updates UI based on screen constraints 
      
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isWide ? 700 : double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // built three sections for info, address, company info
                    _buildSectionCard(
                      context,
                      title: 'Personal Info',
                      children: [
                        _infoTile('Name', user.name),
                        _infoTile('Username', user.username),
                        _infoTile('Email', user.email),
                        _infoTile('Phone', user.phone),
                        _infoTile('Website', user.website),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      context,
                      title: 'Address',
                      children: [
                        _infoTile('Street', user.address.street),
                        _infoTile('Suite', user.address.suite),
                        _infoTile('City', user.address.city),
                        _infoTile('Zipcode', user.address.zipcode),
                        _infoTile('Geo', '${user.address.geo.lat}, ${user.address.geo.lng}'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSectionCard(
                      context,
                      title: 'Company',
                      children: [
                        _infoTile('Name', user.company.name),
                        _infoTile('Catch Phrase', user.company.catchPhrase),
                        _infoTile('BS', user.company.bs),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// card helper function 
  Widget _buildSectionCard(BuildContext context, {required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                    )),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

// tile helper used in section to show data
  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
