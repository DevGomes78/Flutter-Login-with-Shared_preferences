class UserModel {
  String? name;
  String? sobrenome;
  String? mail;
  String? senha;
  String? repitasenha;

  UserModel({
    this.name,
    this.sobrenome,
    this.mail,
    this.senha,
    this.repitasenha,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sobrenome = json['sobrenome'];
    mail = json['mail'];
    senha = json['senha'];
    repitasenha = json['repitasenha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['sobrenome'] = sobrenome;
    data['mail'] = mail;
    data['senha'] = senha;
    data['repitasenha'] = repitasenha;
    return data;
  }

  String toString() {
    return "Name: " +
        this.name.toString() +
        "\nsobrenome: "+
        this.sobrenome.toString()+
        "\nE-mail :" +
        this.mail.toString() +
        "\nSenha :" +
        this.senha.toString()+
       "\nrepitasenha: " +
        this.repitasenha.toString();
  }
}
