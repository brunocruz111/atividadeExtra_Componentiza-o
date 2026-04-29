class Contato {
  final String nome;
  final String telefone;
  final bool favorito;

  const Contato({
    required this.nome,
    required this.telefone,
    required this.favorito,
  });

  Contato copyWith({
    String? nome,
    String? telefone,
    bool? favorito,
  }) {
    return Contato(
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      favorito: favorito ?? this.favorito,
    );
  }
}
