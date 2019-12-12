class Logics {
  static String validateFormFields(String value){
    if(value != null && value !=''){
      return null;
    }
    return 'This field can\'t be empty';
  }
}