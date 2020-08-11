import 'dart:io';

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this._isLoading);

  final bool _isLoading;

  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _passwordController = TextEditingController();
  var _form = GlobalKey<FormState>();

  var _isLogin = true;

  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';

  void _saveForm() {
    var isValid = _form.currentState.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      _form.currentState.save();

      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName,
          _isLogin, context);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  decoration: InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide an email address';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    decoration: InputDecoration(labelText: 'Username'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a password';
                    }
                    if (value.length < 7) {
                      return 'Please enter atleast 7 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('confirm password'),
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text.trim()) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                SizedBox(
                  height: 10,
                ),
                if (widget._isLoading) CircularProgressIndicator(),
                if (!widget._isLoading)
                  RaisedButton(
                    onPressed: _saveForm,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                    color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                  ),
                if (!widget._isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create New Account'
                        : 'I already have an account!'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
