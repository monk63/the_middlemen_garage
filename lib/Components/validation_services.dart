

class ValidationService {
 
  // Vehicle Details Registration

  String? modelNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid model name';
    }

    String pattern = r"^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$";
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid model name';
    }

    return null;
  }

  String? vehicleNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid vehicle number';
    }

    if (value.length < 8) {
      return 'Please enter a valid vehicle number';
    }

    String pattern = r"^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$";
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid vehicle number';
    }

    return null;
  }

  String? ownerNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid owner name';
    }

    String pattern = r"^[a-zA-Z]+$";
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid owner name';
    }

    return null;
  }

  String? colorValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid color';
    }

    String pattern = r"^[a-zA-Z]+$";
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid color';
    }

    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid aadhar number';
    }

    if (value.length != 12) {
      return 'Please enter a valid aadhar number';
    }

    String pattern = r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid aadhar number';
    }

    return null;
  }
}
