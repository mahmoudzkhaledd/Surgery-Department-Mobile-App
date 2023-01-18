import '../Services/AuthServices.dart';

class Doctor {
  int code = 0;
  int usernameID = 0;

  int successOperations = 0;
  int dayAttend = 0;
  int grade = 0;
  int takenNumber = 0;

  String username = "";

  String password = "";
  String Fname = "";

  String Mname = "";

  String Lname = "";

  String Email = "";

  double Salary = 0;

  String BirthDate = "";

  String city = "";

  String street = "";

  String building = "";

  String phone_1 = "";

  String phone_2 = "";

  String gender = "";

  String speciality = "";

  String imageLoc = "";
  String SSN = "";
  int rank = 0;
  int points = 0;

  static Doctor getModel(Map<String, dynamic> model) {
    Doctor m = Doctor();
    m.rank = model['Rank'].toString() == "Null"
        ? 0
        : int.parse(model['Rank'].toString());
    m.points = model['Points'].toString() == "Null"
        ? 0
        : int.parse(model['Points'].toString());
    m.imageLoc = (model['imageLoc'] != null && model['imageLoc'].toString() != "null") ?
    "${Services.serverURL}/images/${model['imageLoc']}" : "";

    m.successOperations = int.parse(model['successOperations'].toString());
    m.dayAttend = int.parse(model['dayAttend'].toString());
    m.grade = int.parse(model['grade'].toString());
    m.takenNumber = int.parse(model['takenNumber'].toString());

    m.code = model['code'];
    m.username = model['username'];
    m.password = model['password'] ?? "";
    m.Fname = model['Fname'];
    m.Mname = model['Mname'];
    m.Lname = model['Lname'];
    m.Email = model['Email'];
    m.Salary = double.parse(model['Salary'].toString());
    m.BirthDate = model['BirthDate'];
    m.city = model['city'];
    m.street = model['street'];
    m.building = model['building'];
    m.phone_1 = model['phone_1'];
    m.phone_2 = model['phone_2'];
    m.gender = (model['gender']['data'][0] == 1) ? "Male" : "Female";
    m.speciality = model['speciality'];
    m.SSN = model['SSN'];
    return m;
  }


  static Map<String, dynamic> getMap(Doctor model) {
    var x = <String, dynamic>{
      'code': model.code,
      'username': model.username,
      'Fname': model.Fname,
      'Mname': model.Mname,
      'Lname': model.Lname,
      'Email': model.Email,
      'Salary': model.Salary,
      'BirthDate': model.BirthDate,
      'city': model.city,
      'street': model.street,
      'building': model.building,
      'phone_1': model.phone_1,
      'phone_2': model.phone_2,
      'gender': model.gender,
      'speciality': model.speciality,
      'SSN': model.SSN,
      'imageLoc': model.imageLoc,
      'password': model.password,
      'usernameID': model.usernameID,
      'successOperations':model.successOperations,
      'dayAttend':model.dayAttend,
      'grade':model.grade,
      'takenNumber':model.takenNumber
    };

    return x;
  }

  Doctor copy() {
    Doctor m = Doctor();
    m.rank = rank;
    m.points = points;
    m.imageLoc = imageLoc;
    m.code = code;
    m.username = username;
    m.password = password;
    m.Fname = Fname;
    m.Mname = Mname;
    m.Lname = Lname;
    m.Email = Email;
    m.Salary = Salary;
    m.BirthDate = BirthDate;
    m.city = city;
    m.street = street;
    m.building = building;
    m.phone_1 = phone_1;
    m.phone_2 = phone_2;
    m.gender = gender;
    m.speciality = speciality;
    m.SSN = SSN;

    m. successOperations = successOperations;
    m. dayAttend = dayAttend;
    m. grade = grade;
    m. takenNumber = takenNumber;

    m.usernameID = usernameID;
    return m;
  }
}
