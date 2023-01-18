class Room {
  int ID = 0;
  int Floor = 0;
  bool Full = false;
  String Name = "";
  String Type = "";
  static Room getModel(Map<String, dynamic> mp) {
    Room r = Room();
    r.Floor = int.parse(mp['Floor'].toString());
    r.Full = mp['Full']['data'][0] == 1;
    r.ID = int.parse(mp['ID'].toString());
    r.Name = mp['Name'];
    r.Type = mp['Type'];
    return r;
  }
}
