String? nameValidator(String? value) {
  if (value!.isEmpty) {
    return 'should not be empty';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value!.isEmpty) {
    return 'should not be empty';
  } else if (!value.contains('@') || !value.contains('.com')) {
    return 'enter valid email';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value!.isEmpty) {
    return 'should not be empty';
  } else if (value.length < 6) {
    return 'password should not be less than 6 characters';
  }
  return null;
}
