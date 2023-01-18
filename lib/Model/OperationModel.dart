import 'DoctorModel.dart';

class Operation {
  int code = -1;
  String name = "";
  int patient = -1;
  int roomId = -1;
  String time = "";
  int duration = -1;
  double cost = -1;

  List<int> doctors = [];
  List<int> nurses = [];

  static Operation getOperationModel(Map<String, dynamic> m) {
    Operation op = Operation();
    op.code = int.parse(m['code'].toString());
    op.name = m['Name']!;
    op.patient = int.parse(m['Patient_Code'].toString());
    op.roomId = int.parse(m['Room_Number'].toString());
    op.time = m['Time']!;
    op.duration = int.parse(m['Duration'].toString());
    op.cost = double.parse(m['Cost'].toString());
    return op;
  }
}
