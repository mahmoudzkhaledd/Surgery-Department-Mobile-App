class Nurse {
  String B_D = "";
  String Building = "";
  String City = "";
  int Code = 0;
  String Email = "";
  String FName = "";
  String LName = "";
  String MName = "";
  String Phone_1 = "";
  String Phone_2 = "";
  double Salary = 0;
  String Sex = "";
  String SSN = "";
  String Street = "";
  String username = "";

  static Nurse getModel(Map<String, dynamic> mp) {
    Nurse n = Nurse();
    n.B_D = mp['B_D'];
    n.Building = mp['Building'];
    n.City = mp['City'];
    n.Code = int.parse(mp['Code'].toString());
    n.Email = mp['Email'];
    n.FName = mp['FName'];
    n.LName = mp['LName'];
    n.MName = mp['MName'];
    n.Phone_1 = mp['Phone_1'];
    n.Phone_2 = mp['Phone_2'];
    n.Salary = double.parse(mp['Salary'].toString());
    n.Sex = (mp['Sex']['data'][0]== 1) ? "Male" : "Female";
    n.SSN = mp['SSN'];
    n.Street = mp['Street'];
    n.username = mp['username'];
    return n;
  }
}