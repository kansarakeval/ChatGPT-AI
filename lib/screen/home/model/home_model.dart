class HomeModel {

  List<CandidatesModel>? candidateList = [];

  HomeModel({required this.candidateList});

  factory HomeModel.mapToModel(Map m1){
    List candidate = m1['candidates'];

    return HomeModel(
        candidateList: candidate.map((e) => CandidatesModel.mapToModel(e))
            .toList()
    );
  }

}

class CandidatesModel {

  ContentModel? content;

  CandidatesModel({this.content});

  factory CandidatesModel.mapToModel(Map m1){
    return CandidatesModel(
      content: ContentModel.mapToModel(m1['content']),
    );
  }
}

class ContentModel {
  List<PartsModel>? partsList = [];

  ContentModel({required this.partsList});

  factory ContentModel.mapToModel(Map m1){

    List parts = m1['parts'];
    return ContentModel(
      partsList: parts = parts.map((e) => PartsModel.mapToModel(e)).toList(),
    );
  }
}

class PartsModel {

  String? text;

  PartsModel({this.text});

  factory PartsModel.mapToModel(Map m1){
    return PartsModel(
      text: m1['text'],
    );
  }
}

