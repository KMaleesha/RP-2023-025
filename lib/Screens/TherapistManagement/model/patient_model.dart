class Patient {
  final String name;
  final int age;
  final List<PatientWord> wordList;

  Patient({
    required this.name,
    required this.age,
    required this.wordList,
  });
}

class PatientWord {
  final String word;
  final String date;

  PatientWord({required this.word, required this.date});
}
