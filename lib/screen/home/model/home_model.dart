class HomeModel {
  List<CandidateModel>? candidates;

  HomeModel({this.candidates});

  factory HomeModel.mapToModel(Map m1)
  {
    List l1 = m1["candidates"];
    return HomeModel(
      candidates: l1.map((e) => CandidateModel.mapToModel(e)).toList(),
    );
  }
}

class CandidateModel {
  Content? content;
  String? finishReason;
  int? index;
  List<SafetyRating>? safetyRatings;

  CandidateModel({
    this.content,
    this.finishReason,
    this.index,
    this.safetyRatings,
  });

  factory CandidateModel.mapToModel(Map m1)
  {
    List l1=m1['safetyRatings'];
    return CandidateModel(
      content: m1['content'],
      finishReason: m1['finishReason'],
      index: m1['index'],
      safetyRatings: l1.map((e) => SafetyRating.mapToModel(e)).toList(),
    );
  }
}

class Content {
  List<Part>? parts;
  String? role;

  Content({
    this.parts,
    this.role,
  });

  factory Content.mapToModel(Map m1)
  {
    List l1=m1['parts'];
    return Content(
      parts: l1.map((e) => Part.mapToModel(e)).toList(),
      role: m1["role"],
    );
  }
}

class Part {
  String? text;

  Part({
    this.text,
  });

  factory Part.mapToModel(Map m1) {
    return Part(
      text: m1["text"],
    );
  }
}

class SafetyRating {
  String? category;
  String? probability;

  SafetyRating({
    this.category,
    this.probability,
  });

  factory SafetyRating.mapToModel(Map m1) {
    return SafetyRating(
      category: m1["category"],
      probability: m1["probability"],
    );
  }
}