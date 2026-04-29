import 'package:flutter/material.dart';
import '../models/contato.dart';

class ContatoCard extends StatelessWidget {
  final Contato contato;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onToggleFavorite;

  const ContatoCard({
    super.key,
    required this.contato,
    required this.onTap,
    required this.onDelete,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(contato.nome[0].toUpperCase()),
        ),
        title: Text(contato.nome),
        subtitle: Text(contato.telefone),
        trailing: IconButton(
          icon: Icon(
            contato.favorito ? Icons.star : Icons.star_border,
            color: contato.favorito ? Colors.amber : Colors.grey,
          ),
          onPressed: onToggleFavorite,
        ),
        onTap: onTap,
        onLongPress: onDelete,
      ),
    );
  }
}
