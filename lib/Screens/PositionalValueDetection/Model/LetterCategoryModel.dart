import 'dart:core';

class LetterCategoryModel{
  String? letter;
  String? letterCategory;
  String? letterFeedback;

  LetterCategoryModel({
    this.letter,
    this.letterCategory,
    this.letterFeedback,
  });

  factory LetterCategoryModel.formMap(map){
    return LetterCategoryModel(
      letter: map['letter'],
      letterCategory: map['letterCategory'],
      letterFeedback: map['letterFeedback']
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'letter': letter,
      'letterCategory': letterCategory,
      'letterFeedback': letterFeedback
    };
  }

}