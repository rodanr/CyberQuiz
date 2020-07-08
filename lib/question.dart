//Question class to enable us to use the object that holds the two structure which is question and answer
class Question {
  String questionText;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String correctOption;

  //this. refers to the variables of the object
  //where parameters of the constructor refers to the parametric variable and
  //contd. doesn't effect or relate to the class variables

  Question(String questionText, String optionA, String optionB, String optionC,
      String optionD, String correctOption) {
    this.questionText = questionText;
    this.optionA = optionA;
    this.optionB = optionB;
    this.optionC = optionC;
    this.optionD = optionD;
    this.correctOption = correctOption;
  }
}
