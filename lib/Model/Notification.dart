class MyNotification{
  String from = "";
  String content = "";
  int id = 0;
  static MyNotification getNotification(Map<String,dynamic> m){

    MyNotification n = MyNotification();
     n.id = int.parse(m['ID'].toString());
     n.from = m['fromName'];
     n.content = m['content'];
    return n;
  }
}