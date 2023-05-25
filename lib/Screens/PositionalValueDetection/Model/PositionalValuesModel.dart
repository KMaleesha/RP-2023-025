class PositionalValueModel{
  String? word;
  String? initialValue;
  String? middleValue;
  String? endValue;
  String? letter;
  String? number;
  String? letterCategory;
  String? mark;
  String? categoryFeedback;
  String? markFeedback;

  PositionalValueModel({
    this.word = "KATHA",
    this.initialValue = "KA",
    this.middleValue = "THA",
    this.endValue = "",
    this.letter,
    this.number,
    this.letterCategory,
    this.mark,
    this.categoryFeedback,
    this.markFeedback,
});

  factory PositionalValueModel.formMap(map){
    return PositionalValueModel(
        word:map['word'],
        initialValue:map['initialValue'],
        middleValue:map['middleValue'],
        endValue:map['endValue'],
        letter:map['letter'],
        number:map['number'],
        letterCategory:map['letterCategory'],
        mark:map['mark'],
        categoryFeedback:map['categoryFeedback'],
        markFeedback:map['markFeedback'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'word':word,
      'initialValue':initialValue,
      'middleValue':middleValue,
      'endValue':endValue,
      'letter':letter,
      'number':number,
      'letterCategory':letterCategory,
      'mark':mark,
      'categoryFeedback':categoryFeedback,
      'markFeedback':markFeedback,
    };
  }
}