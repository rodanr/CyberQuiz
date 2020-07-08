import 'question.dart';

// Question('','','','','',''),
class QuizEngine {
  //Initializing the questionNumber to 0 as list starts from 0
  int questionNumber = 0;
  //My List of Question of Question Class type
  //Making this list private so that its value cannot be manipulated
  List<Question> _questionBank = [
    Question('The brain of any computer system is', 'ALU', 'Memory', 'CPU',
        'Control unit', 'c'),
    Question(
        'Which of the following computer language is used for artificial intelligence?',
        'FORTRAN',
        'PROLOG',
        'C',
        'COBOL',
        'b'),
    Question('Which of the following is the 1\'s complement of 10?', '01',
        '110', '11', '10', 'a'),
    Question(
        'Which part interprets program instructions and initiate control operations.',
        'Input',
        'Storage unit',
        'Logic unit',
        'Control unit',
        'd'),
    Question('The binary system uses powers of', '2', '10', '8', '16', 'a'),
    Question(
        'A computer program that converts assembly language to machine language is',
        'Compiler',
        'Interpreter',
        'Assembler',
        'Comparator',
        'c'),
    Question(
        'Which access method is used for obtaining a record from a cassette tape?',
        'Direct',
        'Sequential',
        'Random',
        'None of the above',
        'b'),
    Question('Which computer has been designed to be as compact as possible?',
        'Mini', 'Super computer', 'Micro computer', 'Mainframe', 'c'),
    Question('Which method is used to connect a remote computer?', 'Dialup',
        'Diagnostic', 'Logic circuit', 'None of the above', 'a'),
    Question('The symbols used in an assembly language are called', 'Codes',
        'Mnemonics', 'Assembler', 'All of the above', 'b'),
    Question(
        'The 2\'s complement of a binary no. is obtained by adding....to its 1\'s complement.',
        '0',
        '1',
        '10',
        '11',
        'b'),
    Question('Which of the following is still useful for adding numbers?',
        'EDSAC', 'ENIAC', 'Abacus', 'UNIVAC', 'c'),
    Question(
        'Which output device is used for translating information from a computer into pictorial form on paper.',
        'Mouse',
        'Plotter',
        'Touch panel',
        'Card punch',
        'b'),
    Question('Any device that performs signal conversion is', 'Modulator',
        'Modem', 'Keyboard', 'Plotter', 'a'),
    Question(
        'Codes consisting of light and dark marks which may be optically read is known as',
        'Mnemonics',
        'Bar code',
        'Decoder',
        'All of the above',
        'b'),
    Question(
        'The first generation of computers available was based on the bit micro processors.',
        '4',
        '8',
        '16',
        '64',
        'b'),
    Question(
        'A device for converting handwritten impressions into coded characters & positional coordinates for input to a computer is',
        'Touch panel',
        'Mouse',
        'Wand',
        'Writing tablet',
        'd'),
    Question('In which year was the first iphone launched?', '2009', '2005',
        '2007', '2008', 'c'),
    Question('At what age bill gates become a billionaire', '27', '31', '28',
        '32', 'b'),
    Question('In which year was facebook launched', '2003', '2005', '2004',
        '2007', 'c'),
  ];

  //Getters method to get the question , options and the correct option
  String getQuestionText() {
    return _questionBank[questionNumber].questionText;
  }

  String getOptionA() {
    return _questionBank[questionNumber].optionA;
  }

  String getOptionB() {
    return _questionBank[questionNumber].optionB;
  }

  String getOptionC() {
    return _questionBank[questionNumber].optionC;
  }

  String getOptionD() {
    return _questionBank[questionNumber].optionD;
  }

  String getCorrectOption() {
    return _questionBank[questionNumber].correctOption;
  }
  //GettersMethodEnd

  //Function that increment the questionNumber so that the next question comes
  void nextQuestion() {
    //added if statement to avoid a bug that increased the questionNumber counter even after the quiz game ended
    if (questionNumber < _questionBank.length - 1) {
      questionNumber++;
    }
  }

  //this function returns true if the present question is the last question of the list and returns false if not
  bool isThisLastQuestion() {
//    print(questionNumber); did this for debugging as last question wasn't showing
    if (questionNumber == (_questionBank.length - 1)) {
      return true;
    } else {
      return false;
    }
  }

  //when the quiz completes everything needs to reset even the questions so this function allows to start from first question by initialising questionNumber to zero
  void resetTheQuestionNumber() {
    questionNumber = 0;
  }
}
