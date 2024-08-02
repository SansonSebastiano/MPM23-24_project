import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/style/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This file contains the implementation of all input fields belonging to the app forms.


/// The class [NameTextField] defines an input field to digit the name of the user.  
class NameTextField extends StatefulWidget {
  const NameTextField({super.key});

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  late TextEditingController _controller;
  
  // Widget state
  bool _isNameEmpty = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.lblName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.w,
            color: ColorPalette.oxfordBlue
          ),
        ),
        SizedBox(height: 8.h,),
        if (_isNameEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Name field cannot be empty',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        Container(
          width: 335.w,
          height: 52.h,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(198, 208, 250, 50),
            borderRadius: BorderRadius.all(Radius.circular(8.0),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration (
              border: InputBorder.none,
              hintText: '',
              contentPadding: EdgeInsets.only(left: 10.w),
            ),
            style: const TextStyle(color: ColorPalette.oxfordBlue),
            onSubmitted: (String value) {
              setState(() {
                _isNameEmpty = value.isEmpty;
              });

              if (!_isNameEmpty) {
                print('Submitted text: $value');
              }
            },
          )
        ),
      ],
    );
  }
}


/// The class [EmailTextField] defines an input field to digit the email of the user.  
class EmailTextField extends StatefulWidget {
  const EmailTextField({super.key});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  late TextEditingController _controller;
  
  // Widget state
  bool _isEmailEmpty = false;
  bool _userInteraction = false;
  
  final _emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.lblEmail,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.w,
            color: ColorPalette.oxfordBlue
          ),
        ),
        SizedBox(height: 8.h,),
        if (_isEmailEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Email field cannot be empty',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        if (_userInteraction && !_isEmailEmpty && !_emailRegExp.hasMatch(_controller.text))
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Email format is not valid',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        Container(
          width: 335.w,
          height: 52.h,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(198, 208, 250, 50),
            borderRadius: BorderRadius.all(Radius.circular(8.0),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration (
              border: InputBorder.none,
              hintText: '',
              contentPadding: EdgeInsets.only(left: 10.w),
            ),
            style: const TextStyle(color: ColorPalette.oxfordBlue),
            keyboardType: TextInputType.emailAddress,
            onSubmitted: (String value) {
              setState(() {
                _isEmailEmpty = value.isEmpty;
                _userInteraction = true;
              });

              if (!_isEmailEmpty) {
                print('Submitted text: $value');
              }
            },
          )
        ),
      ],
    );
  }
}


/// The class [LoginPswdTextField] defines an input field to digit the password during login process. 
class LoginPswdTextField extends StatefulWidget {
  const LoginPswdTextField({super.key});

  @override
  State<LoginPswdTextField> createState() => _LoginPswdTextFieldState();
}

class _LoginPswdTextFieldState extends State<LoginPswdTextField> {
  late TextEditingController _controller;
  
  // Widget state
  bool _isPswdEmpty = false;
  bool _userInteraction = false;
  bool _showPswd = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.lblPassword,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.w,
            color: ColorPalette.oxfordBlue
          ),
        ),
        SizedBox(height: 8.h,),
        if (_isPswdEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Password field cannot be empty',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        if (_userInteraction && !_isPswdEmpty && _controller.text.length<6)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Password must be at least 6 characters long',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        Container(
          width: 335.w,
          height: 52.h,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(198, 208, 250, 50),
            borderRadius: BorderRadius.all(Radius.circular(8.0),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration (
              border: InputBorder.none,
              hintText: '',
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPswd ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => _showPswd = !_showPswd),
              ),
            ),
            style: const TextStyle(color: ColorPalette.oxfordBlue),
            obscureText: _showPswd,
            enableSuggestions: false,
            autocorrect: false,
            onSubmitted: (String value) {
              setState(() {
                _isPswdEmpty = value.isEmpty;
                _userInteraction = true;
              });

              if (!_isPswdEmpty) {
                print('Submitted text: $value');
              }
            },
          )
        ),
      ],
    );
  }
}


/// The class [RegistrationPswdTextField] defines an input field to digit and confirm the password during registration process. 
class RegistrationPswdTextField extends StatefulWidget {
  const RegistrationPswdTextField({super.key});

  @override
  State<RegistrationPswdTextField> createState() => _RegistrationPswdTextFieldState();
}

class _RegistrationPswdTextFieldState extends State<RegistrationPswdTextField> {
  late TextEditingController _controllerChoosePswd;
  late TextEditingController _controllerConfirmPswd;
  
  // Widget state
  bool _isChoosePswdEmpty = false;
  bool _userChooseInteraction = false;

  bool _isConfirmPswdEmpty = false;
  bool _userConfirmInteraction = false;

  bool _passwordsMatch = true;

  bool _showChoosePswd = true;
  bool _showConfirmPswd = true;

  @override
  void initState() {
    super.initState();
    _controllerChoosePswd = TextEditingController();
    _controllerConfirmPswd = TextEditingController();
  }

  @override
  void dispose() {
    _controllerChoosePswd.dispose();
    _controllerConfirmPswd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        // Choose a password
        Text(
          AppLocalizations.of(context)!.lblChoosePswd,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.w,
            color: ColorPalette.oxfordBlue
          ),
        ),
        SizedBox(height: 8.h,),
        if (_isChoosePswdEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Password field cannot be empty',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        if (_userChooseInteraction && !_isChoosePswdEmpty && _controllerChoosePswd.text.length<6)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Password must be at least 6 characters long',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        Container(
          width: 335.w,
          height: 52.h,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(198, 208, 250, 50),
            borderRadius: BorderRadius.all(Radius.circular(8.0),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _controllerChoosePswd,
            decoration: InputDecoration (
              border: InputBorder.none,
              hintText: '',
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
              suffixIcon: IconButton(
                icon: Icon(
                  _showChoosePswd ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => _showChoosePswd = !_showChoosePswd),
              ),
            ),
            style: const TextStyle(color: ColorPalette.oxfordBlue),
            obscureText: _showChoosePswd,
            enableSuggestions: false,
            autocorrect: false,
            onSubmitted: (String value) {
              setState(() {
                _isChoosePswdEmpty = value.isEmpty;
                _userChooseInteraction = true;
              });

              if (!_isChoosePswdEmpty) {
                print('Submitted text: $value');
              }
            },
          )
        ),

        SizedBox(height: 20.w,),

        // Confirm password
        Text(
          AppLocalizations.of(context)!.lblConfirmPswd,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.w,
            color: ColorPalette.oxfordBlue
          ),
        ),
        SizedBox(height: 8.h,),
        if (_isConfirmPswdEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Password field cannot be empty',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        if (_userConfirmInteraction && !_isConfirmPswdEmpty && _controllerConfirmPswd.text.length<6)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Password must be at least 6 characters long',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        if (_userConfirmInteraction && !_isConfirmPswdEmpty && !_passwordsMatch)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'Password does not match with the previous one',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.w,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        Container(
          width: 335.w,
          height: 52.h,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(198, 208, 250, 50),
            borderRadius: BorderRadius.all(Radius.circular(8.0),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: _controllerConfirmPswd,
            decoration: InputDecoration (
              border: InputBorder.none,
              hintText: '',
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
              suffixIcon: IconButton(
                icon: Icon(
                  _showConfirmPswd ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => _showConfirmPswd = !_showConfirmPswd),
              ),
            ),
            style: const TextStyle(color: ColorPalette.oxfordBlue),
            obscureText: _showConfirmPswd,
            enableSuggestions: false,
            autocorrect: false,
            onSubmitted: (String value) {
              setState(() {
                _isConfirmPswdEmpty = value.isEmpty;
                _userConfirmInteraction = true;
                _passwordsMatch = _controllerChoosePswd.text == _controllerConfirmPswd.text;
              });

              if (!_isConfirmPswdEmpty) {
                print('Submitted text: $value');
              }
            },
          )
        ),
      ],
    );
  }
}


/// The class [MessageInputField] defines the input text field to digit and send a new message in a chat page.
class MessageInputField extends StatefulWidget {
  final void Function() onTap;

  const MessageInputField({
    super.key,
    required this.onTap,
  });

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  late TextEditingController _controller;
  
  // Widget state
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _controller.addListener(() {
      setState(() {
        _isButtonActive = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            minLines: 1,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Write a message',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: const Color.fromRGBO(9, 31, 72, 70),
                  width: 3.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: const Color.fromRGBO(9, 31, 72, 70),
                  width: 3.w,
                ),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                color: _isButtonActive ? ColorPalette.oxfordBlue : ColorPalette.lavenderBlue,
                onPressed: _isButtonActive ? widget.onTap : null,
                padding: EdgeInsets.all(8.w),
                iconSize: 20.w,
                splashRadius: 24.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
