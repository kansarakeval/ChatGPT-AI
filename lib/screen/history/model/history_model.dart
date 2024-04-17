class HistoryModel {
  int? id;
  String? answer;

  HistoryModel({this.id,this.answer});

  factory HistoryModel.mapToModel(Map m1){
    return HistoryModel(
      id: m1['id'],
      answer: m1['answer']
    );
  }
}