import 'package:flutter/material.dart';
import '../models/contato.dart';
import '../components/contato_card.dart';
import 'adicionar_contato_page.dart';

class ContatosPage extends StatefulWidget {
  const ContatosPage({super.key});

  @override
  State<ContatosPage> createState() => _ContatosPagState();
}

class _ContatosPagState extends State<ContatosPage> {
  List<Contato> contatos = [];
  String busca = "";
  bool pesquisando = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Contato> filtrados() {
    return contatos
        .where((c) => c.nome.toLowerCase().contains(busca.toLowerCase()))
        .toList();
  }

  void adicionarContato() async {
    final novo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdicionarContatoPage()),
    );

    if (novo != null && novo is Contato) {
      setState(() {
        contatos.add(novo);
      });
    }
  }

  void deletarContato(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deletar contato'),
          content: Text(
            'Tem certeza que deseja deletar ${filtrados()[index].nome}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contatos.remove(filtrados()[index]);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${filtrados()[index].nome} deletado'),
                    backgroundColor: const Color(0xFF757575),
                  ),
                );
              },
              child: const Text('Deletar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void toggleFavorito(int index) {
    final contatoAtualizado =
        filtrados()[index].copyWith(favorito: !filtrados()[index].favorito);
    final indexOriginal = contatos.indexOf(filtrados()[index]);
    setState(() {
      contatos[indexOriginal] = contatoAtualizado;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          contatoAtualizado.favorito
              ? "${contatoAtualizado.nome} adicionado aos favoritos ⭐"
              : "${contatoAtualizado.nome} removido dos favoritos",
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: contatoAtualizado.favorito
            ? const Color(0xFF4CAF50)
            : const Color(0xFF757575),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: pesquisando
            ? TextField(
                controller: controller,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Buscar contatos...",
                  hintStyle: const TextStyle(color: Color(0xFFB3E5FC)),
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFB3E5FC),
                  ),
                ),
                onChanged: (v) {
                  setState(() {
                    busca = v;
                  });
                },
              )
            : const Text(
                "Contatos",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              pesquisando ? Icons.close : Icons.search,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              setState(() {
                pesquisando = !pesquisando;
                busca = "";
                controller.clear();
              });
            },
          )
        ],
      ),
      body: filtrados().isEmpty
          ? Center(
              child: Text(
                pesquisando
                    ? "Nenhum contato encontrado"
                    : "Nenhum contato adicionado",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
            )
          : ListView.separated(
              itemCount: filtrados().length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: Color(0xFFEEEEEE),
              ),
              itemBuilder: (context, i) {
                final contato = filtrados()[i];
                return ContatoCard(
                  contato: contato,
                  onTap: () {
                    // Aqui você pode adicionar navegação para tela de detalhes
                  },
                  onDelete: () => deletarContato(i),
                  onToggleFavorite: () => toggleFavorito(i),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarContato,
        child: const Icon(Icons.add),
      ),
    );
  }
}
