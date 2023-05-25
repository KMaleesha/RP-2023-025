class MarkCalculationModel{
  int? mark;
  int? correctLetterCount;
  int? wrongLetterCount;
  String? markFeedback;

  MarkCalculationModel({
    this.mark,
    this.correctLetterCount,
    this.wrongLetterCount,
    this.markFeedback,
  });

  factory MarkCalculationModel.formMap(map){
    return MarkCalculationModel(
        mark: map['mark'],
        correctLetterCount: map['correctLetterCount'],
        wrongLetterCount: map['markFeedback'],
        markFeedback: map['markFeed']
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'mark': mark,
      'correctLetterCount': correctLetterCount,
      'wrongLetterCount': wrongLetterCount,
      'markFeedback': markFeedback
    };
  }
}