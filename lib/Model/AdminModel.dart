class AdminModel {
  int ID = 0;
  int usernameID = 0;
  String username = "";
  String Password = "";
  String SSN = "";
  String FName = "";
  String MName = "";
  String LName = "";
  String B_D = "";
  double Salary = 0.0;
  String Address = "";
  String Job_Describtion = "";
  String Phone_1 = "";
  String Phone_2 = "";
  String gender = "";

  static AdminModel getModel(Map<String, dynamic> mp) {
    AdminModel m = AdminModel();
    m.ID = int.parse(mp['ID'].toString());
    m.Password = mp['password'];
    m.username = mp['username'];
    m.SSN = mp['SSN'];
    m.FName = mp['FName'];
    m.MName = mp['MName'];
    m.LName = mp['LName'];
    m.B_D = mp['B_D'];
    m.Salary = double.parse(mp['Salary'].toString());
    m.Address = mp['Address'];
    m.Job_Describtion = mp['Job_Describtion'];
    m.Phone_1 = mp['Phone_1'];
    m.Phone_2 = mp['Phone_2'];
    m.gender = (mp['gender']['data'][0] == 1) ? "Male":"Female";
    return m;
  }
}
