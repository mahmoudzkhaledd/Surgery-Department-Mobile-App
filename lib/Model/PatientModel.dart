class Patient {
  String username = '';
  String SSN = '';
  bool smoking = false;
  String Phone_Personal = '';
  String Phone_Family_2 = '';
  String Phone_Family_1 = '';
  String other_health_conditions = '';
  String MName = '';
  String LName = '';
  bool High_cholesterol = false;
  bool have_children = false;
  String gender = '';
  String FName = '';
  bool exercise = false;
  String Email = '';
  bool drink_alcohol = false;
  bool diabetes = false;
  int code = 0;
  String Address = '';
  static Patient getModel(Map<String, dynamic> mp) {
    Patient p = Patient();
    p.username = mp['username'];
    p.SSN = mp['SSN'];
    p.smoking = mp['smoking']['data'][0] == 1;
    p.Phone_Personal = mp['Phone_Personal'];
    p.Phone_Family_2 = mp['Phone_Family_2'];
    p.Phone_Family_1 = mp['Phone_Family_1'];
    p.other_health_conditions = mp['other_health_conditions'];
    p.MName = mp['MName'];
    p.LName = mp['LName'];
    p.High_cholesterol = mp['High_cholesterol']['data'][0] == 1;
    p.have_children = mp['have_children']['data'][0] == 1;
    p.gender = mp['gender']['data'][0] == 1 ? "Male":"Female";
    p.FName = mp['FName'];
    p.exercise = mp['exercise']['data'][0] == 1;
    p.Email = mp['Email'];
    p.drink_alcohol = mp['drink_alcohol']['data'][0] == 1;
    p.diabetes = mp['diabetes']['data'][0] == 1;
    p.code = int.parse(mp['code'].toString());
    p.Address = mp['Address'];
    return p;
  }
}
