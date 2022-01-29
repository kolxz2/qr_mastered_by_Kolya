class InputValidators {
  static String? validateID(String? id) {
    String pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);
    if (id!.isEmpty) {
      return 'Ид не может быть пустым';
    } else if (!regex.hasMatch(id)) {
      return 'Некоректный ИД';
    } else {
      return null;
    }
  }

  /* static String? validatePass(String? pass) {
    //String pattern = r'(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*]{6,}';
    //RegExp regex = RegExp(pattern);
    if (pass!.isEmpty) {
      return 'Пароль не может быть пустым';
    } //else if (!regex.hasMatch(pass)) {
      //return 'Пароль не может быть меньше ';
   // }
     else {
      return null;
    }
  }*/
}
