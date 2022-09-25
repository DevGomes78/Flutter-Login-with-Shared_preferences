class UserModel {
  String? name;
  String? mail;
  String? senha;

  UserModel({this.name, this.mail, this.senha});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mail = json['mail'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['mail'] = mail;
    data['senha'] = senha;
    return data;
  }
  String toString(){
    return "Name: "+ this.name.toString() +
        "\nE-mail :" +this.mail.toString()+
         "\nSenha :" + this.senha.toString();

  }
}
