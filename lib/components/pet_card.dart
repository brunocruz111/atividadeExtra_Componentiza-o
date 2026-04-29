import 'package:flutter/material.dart';
import '../models/pet.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;
  final VoidCallback onInfoTap;

  const PetCard({
    super.key,
    required this.pet,
    required this.onTap,
    required this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(pet.name[0]),
        ),
        title: Text(pet.name),
        subtitle: Text('${pet.species} • ${pet.service}'),
        trailing: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: onInfoTap,
        ),
        onTap: onTap,
      ),
    );
  }
}
