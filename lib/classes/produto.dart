class Produto {
  final int id;
  final String item;
  final String unidadeMedida;
  final double preco;
  final bool destaque;
  final String foto;

  Produto(this.id, this.item, this.unidadeMedida, this.preco, this.destaque,
      this.foto);

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(json['id'], json['item'], json['unidadeMedida'],
        json['preco'].toDouble(), json['destaque'], json['foto']);
  }
}
