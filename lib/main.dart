//TO use material objects like icons and all...
import 'package:flutter/material.dart';
//To use alert dialog widget
import 'package:rflutter_alert/rflutter_alert.dart';
//For showing the github media button in my about Alert Dialog/Alert Dialog Page... kinda own jargon
import 'package:social_media_buttons/social_media_buttons.dart';
import 'quiz_engine.dart';
//For playing the audio
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(CyberQuiz());
}

class CyberQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Alert Dialog was not popping when I was directly returning the QuizPage here and having MaterialApp and SafeArea widget inside the QuizPage
    //I thing some area should be allocated stateless to popup the alert dialog
    return MaterialApp(
        home: SafeArea(
      child: QuizPage(),
    ));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String _nameOfTheCreator = 'Rodan Ramdam';
  //Answer Counters to count the right and wrong answers to show it on the scoreBoard and appBar
  int rightAnswersCount = 0;
  int wrongAnswersCount = 0;

  //Variable to show the questionNumber while displaying the question
  int questionNumberForDisplayUse = 1;
  //Creating QuizEngine class object
  QuizEngine quizEngine = QuizEngine();
  //Initializing the audio player
  final player = AudioCache();
  //Not muted by default
  //False means it is not muted
  //True means it is muted
  bool muteFlag = false;

  //AlertStyle to give style to the AlertDialog
  AlertStyle alertStyle = AlertStyle(
      backgroundColor: Colors.grey.shade900,
      titleStyle: TextStyle(
        color: Colors.white,
      ));

  //Using AlertDialog as my about page
  _showAboutUsDialog(context) {
    Alert(
        style: alertStyle,
        title: 'About App Creator\n',
        context: context,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('images/my_photo.jpg'),
              radius: 50.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _nameOfTheCreator,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Github:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SocialMediaButton.github(
                  url: 'https://github.com/rodan0818/',
                  size: 40.0,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        )).show();
  }

  //Function to reset ever answer counters used in this class as shown inside this method
  void resetTheAnswerCounters() {
    rightAnswersCount = 0;
    wrongAnswersCount = 0;
    questionNumberForDisplayUse = 0;
  }

  //Alert Dialog shows up when the quiz ends showing score and playing a retro sound and also this function resets the questions
  _showQuizCompleteDialog(context) {
    Alert(
      context: context,
      style: alertStyle,
      title: 'Scoreboard:\n',
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.check,
                color: Colors.green,
              ),
              title: Text(
                'Correct Answers:' + rightAnswersCount.toString(),
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.close,
                color: Colors.red,
              ),
              title: Text(
                'Wrong Answers:' + wrongAnswersCount.toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ).show();
    //setState looks the code that may be effected by the code inside this code block as below and update those codes or refreshes their variables
    setState(() {
      //Resets the questions being displayed from start
      quizEngine.resetTheQuestionNumber();
      resetTheAnswerCounters();
      //Only playing the gameEnd music if user haven't set to mute
      if (muteFlag == false) {
        player.play('gameEnd.wav');
      }
    });
    //the issue why sound wasn't playing before was the sound file was not working correctly with the project
  }

  //function to check the answer
  void checkAnswer(String userPickedOption) {
    setState(() {
      if (userPickedOption == quizEngine.getCorrectOption()) {
        //Only playing the right answer music if user haven't set to mute
        if (muteFlag == false) {
          player.play('right.wav');
        }
        //rightAnswer counter gets incremeted
        rightAnswersCount++;
        //putting this Quiz Complete function at last as nextQuestion will be triggered even after resetting due to above function call
        //After adding up the score of the last question and playing sound if enabled the showQuizCompleteDialog gets executed
        if (quizEngine.isThisLastQuestion()) {
          _showQuizCompleteDialog(context);
        } else {
          quizEngine.nextQuestion();
        }
      } else {
        //Only playing the wrong answer music if user haven't set to mute
        //Done same as in the above if block but for the wrong answer
        if (muteFlag == false) {
          player.play('wrong.wav');
        }
        wrongAnswersCount++;
        if (quizEngine.isThisLastQuestion()) {
          _showQuizCompleteDialog(context);
        }
        //Bug was showing before I kept the code to nexQuestion inside this else block
        //The bug was the last question was not showing
        //Reason for the Bug:
        //As the questionNumber gets increased and it returns to be last question and dialog gets shown
        //so the nextQuestion method should be called after the showQuizCompleteDialog is called

        else {
          quizEngine.nextQuestion();
        }
      }

      questionNumberForDisplayUse++;
    });
  }

  //To show the icon dynamically whenever the user press the volume icon button
  //if user taps the icon when its un muted then it gets muted and vice versa
  Icon muteStatus() {
    if (muteFlag == false) {
      //returns not muted icon
      return (Icon(
        Icons.volume_up,
        color: Colors.green,
      ));
    } else {
      //returns muted icon
      return (Icon(
        Icons.volume_off,
        color: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      //Setting a great appBar
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        actions: <Widget>[
          //for showing the count of right answers
          Expanded(
            flex: 2,
            child: ListTile(
              leading: Icon(
                Icons.check,
                color: Colors.green,
              ),
              title: Text(
                ' $rightAnswersCount',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

          //for showing the count of wrong answers
          Expanded(
            flex: 2,
            child: ListTile(
              leading: Icon(
                Icons.close,
                color: Colors.red,
              ),
              title: Text(
                ' $wrongAnswersCount',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

          //To change the mute status and to show the mute status
          Expanded(
            flex: 1,
            child: FlatButton(
              //Icon looks dynamic as every time the muteFlag value changes icon changes as it is returning from the muteStatus() method
              child: muteStatus(),
              onPressed: () {
                setState(() {
                  if (muteFlag == false) {
                    muteFlag = true;
                  } else {
                    muteFlag = false;
                  }
                });
              },
            ),
          ),

          //Shows help icon and whenever pressed shows by alert dialog about page
          Expanded(
            flex: 1,
            child: FlatButton(
              child: Icon(
                Icons.live_help,
                color: Colors.red.shade50,
              ),
              onPressed: () {
                setState(() {
                  _showAboutUsDialog(context);
                });
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //To display the question
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  '$questionNumberForDisplayUse.' +
                      quizEngine.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //Showing Option
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      color: Colors.red.shade900,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'A. ' + quizEngine.getOptionA(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        checkAnswer('a');
                      },
                    ),
                  ),
                  //creating space between option a and b in horizontal axis
                  SizedBox(
                    width: 10.0,
                  ),

                  //Showing Option
                  Expanded(
                    child: FlatButton(
                      color: Colors.green.shade900,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'B. ' + quizEngine.getOptionB(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        checkAnswer('b');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      color: Colors.yellow.shade900,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'C. ' + quizEngine.getOptionC(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        checkAnswer('c');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: FlatButton(
                      color: Colors.blue.shade900,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'D. ' + quizEngine.getOptionD(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        checkAnswer('d');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
