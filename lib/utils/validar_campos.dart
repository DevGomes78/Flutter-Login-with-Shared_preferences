class Validate {


  String? validateNome(String? value) {
    if (value!.isEmpty) {
      return 'Campo em Branco';
   // } else if (!RegExp(r'^[a-z-A-Z]+$').hasMatch(value)) {
     // return 'Somente Letras';
    } else if (value.trim().length < 4) {
      return 'Minimo 4 caracteres';
    } else {
      return null;
    }
  }

  String? validateSobreNome(String? value) {
    if (value!.isEmpty) {
      return 'Campo em Branco';
   // } else if (!RegExp(r'^[a-z-A-Z]+$').hasMatch(value)) {
     // return 'Somente Letras';
    } else if (value.trim().length < 3) {
      return 'Minimo 4 caracteres';
    } else {
      return null;
    }
  }

  String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return 'Campo em Branco';
    } else if (value.trim().length < 11) {
      return 'Informe Número com DDD';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Campo em Branco';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
      return 'email Invalido';
    } else {
      return null;
    }
  }

  String? validateSenha(String? value) {
    if (value!.isEmpty) {
      return 'campo senha em Branco';
    } else if (value.trim().length < 4) {
      return 'Minimo 4 caracteres';
    } else {
      return null;
    }
  }

  String? validateRepitaSenha(String? value) {
    if (value!.isEmpty) {
      return 'campo senha em Branco';
    } else if (value.trim().length < 4) {
      return 'Minimo 4 caracteres';
    } else {
      return null;
    }
  }
}
