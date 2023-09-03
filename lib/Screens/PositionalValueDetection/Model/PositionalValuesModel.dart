class PositionalValueModel{
  String? word;
  String? initialValue;
  String? middleValue;
  String? endValue;
  String? letters;
  int? letterCount;

  PositionalValueModel({
    this.word,
    this.initialValue,
    this.middleValue,
    this.endValue,
    this.letters,
    this.letterCount,
  });

  factory PositionalValueModel.formMap(map){
    return PositionalValueModel(
      word:map['word'],
      initialValue:map['initialValue'],
      middleValue:map['middleValue'],
      endValue:map['endValue'],
      letters: map['letters'],
      letterCount:map['letterCount'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'word':word,
      'initialValue':initialValue,
      'middleValue':middleValue,
      'endValue':endValue,
      'letters': letters,
      'letterCount':letterCount,
    };
  }
}