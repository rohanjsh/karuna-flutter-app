import 'package:flutter/material.dart';
import 'package:karuna_flutter_app/custom.dart';

//CHAT index 3
class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.lightGreen,
        mini: true,
        child: Icon(Icons.add),
        elevation: 2,
      ),
      body: Container(
        child: ListView(
          children: [
            SimpleListTile(
              title: 'Need Help?',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1z08HHtOXb3xbiijlobLbRGLKmb4X5Lk4=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Live Oxygen Leads',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1GcwItk-hhdPjt0GeeueFT-5GJByxszzg=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Vacant Beds Tracker',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1Rc4AYhu4DSGt6PxaEmVPBbuYvI_Z6r29=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Donate/ Request Plasma',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1Eoz-SeMc8hU3ccAiOVGEb4NVBV5HxJR2=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Contribute by Filling Survey',
              imageURL:
                  'https://lh3.googleusercontent.com/d/121mHxEMbWiddmObragKhA-qMvhgyJMsw=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Food',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1v8213hT6ApSqOc0-tdnnb4Kg9Ni50N-T=w150-h150?authuser=0',
            ),
            ListTile(
              onTap: () {},
              title: Text(
                'Private Messages',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleLoginScreen extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String email, String password) onSubmitted;

  const SimpleLoginScreen({this.onSubmitted});
  @override
  _SimpleLoginScreenState createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
  String email, password;
  String emailError, passwordError;
  Function(String email, String password) get onSubmitted => widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    email = "";
    password = "";

    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = "Email is invalid";
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = "Please enter a password";
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() {
    _pushTo(context, Chat());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(height: screenHeight * .07),
          Text(
            "Sign in to chat with local doctors and hospital administrators",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * .03),
          Text(
            "Chat with others, feedback and more",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * .07),
          InputField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            labelText: "Email",
            errorText: emailError,
            keyboardType: TextInputType.emailAddress,
            autoFocus: true,
          ),
          SizedBox(height: screenHeight * .025),
          InputField(
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            onSubmitted: (val) => submit(),
            labelText: "Password",
            errorText: passwordError,
            obscureText: true,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * .04,
          ),
          FormButton(
            text: "Sign In",
            onPressed: submit,
          ),
          SizedBox(
            height: screenHeight * .02,
          ),
          TextButton(
            onPressed: () {
              _pushTo(context, SimpleRegisterScreen());
            },
            child: RichText(
              text: TextSpan(
                text: "Don't have an account?, ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "Sign up here!",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SimpleRegisterScreen extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String email, String password) onSubmitted;

  SimpleRegisterScreen({this.onSubmitted});

  @override
  _SimpleRegisterScreenState createState() => _SimpleRegisterScreenState();
}

class _SimpleRegisterScreenState extends State<SimpleRegisterScreen> {
  String email, password, confirmPassword;
  String emailError, passwordError;
  Function(String email, String password) get onSubmitted => widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    email = "";
    password = "";
    confirmPassword = "";

    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = "Email is invalid";
      });
      isValid = false;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        passwordError = "Please enter a password";
      });
      isValid = false;
    }
    if (password != confirmPassword) {
      setState(() {
        passwordError = "Passwords do not match";
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted(email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Sign up',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .12),
            InputField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              labelText: "Email*",
              errorText: emailError,
              keyboardType: TextInputType.emailAddress,
              autoFocus: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              labelText: "Choose Password*",
              errorText: passwordError,
              obscureText: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
                });
              },
              onSubmitted: (value) => submit(),
              labelText: "Repeat Password*",
              errorText: passwordError,
              obscureText: true,
            ),
            SizedBox(
              height: screenHeight * .10,
            ),
            Text(
              'By proceeding you also agree to Terms of Service and Privacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black38),
            ),
            SizedBox(
              height: screenHeight * .02,
            ),
            FormButton(
              text: "Sign Up",
              onPressed: submit,
            ),
            SizedBox(
              height: screenHeight * .03,
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: RichText(
                text: TextSpan(
                  text: "Already have an account?, ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_pushTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}
