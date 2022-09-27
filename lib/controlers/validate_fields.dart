class Validate {


  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Campo nome em Branco';
   // } else if (!RegExp(r'^[a-z-A-Z]+$').hasMatch(value)) {
     // return 'Somente Letras';
    } else if (value.trim().length < 4) {
      return 'Minimo 4 caracteres';
    } else {
      return null;
    }
  }

  String? validateLastName(String? value) {
    if (value!.isEmpty) {
      return 'Campo sobrenome em Branco';
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
      return 'Campo telefone em Branco';
    } else if (value.trim().length < 11) {
      return 'Informe Número com DDD';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Campo email em Branco';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
      return 'email Invalido';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'campo senha em Branco';
    } else if (value.trim().length < 4) {
      return 'Minimo 4 caracteres';
    } else {
      return null;
    }
  }

  String? validateRepeatPassword(String? value) {
    if (value!.isEmpty) {
      return 'campo senha em Branco';
    } else if (value.trim().length < 4) {
      return 'Minimo 4 caracteres';
    } else {
      return null;
    }
  }
}
