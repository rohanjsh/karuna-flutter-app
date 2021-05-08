import 'package:flutter/material.dart';

/// Keeps the state of each tab even as you navigate through routes. This is done by creating a new navigator for each [screenWidget] given.
///
/// [screenWidgets] should be a list of Widgets where each Widget contains its own `Scaffold`.
///
/// `PersistentTabs` is commonly used with a `BottomNavigationBar` for iOS style navigation.
class PersistentTabs extends StatelessWidget {
  const PersistentTabs({
    @required this.screenWidgets,
    this.currentTabIndex = 0,
  });
  final int currentTabIndex;
  final List<Widget> screenWidgets;

  List<Widget> _buildOffstageWidgets() {
    return screenWidgets
        .map(
          (w) => Offstage(
            offstage: currentTabIndex != screenWidgets.indexOf(w),
            child: Navigator(
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(builder: (_) => w);
              },
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildOffstageWidgets(),
    );
  }
}

//Custom Widgets

class SimpleTextField extends StatefulWidget {
  const SimpleTextField({
    this.onChanged,
    this.textEditingController,
    this.autofillHints,
    this.textInputType,
    this.autoFocus = false,
    this.obscureText = false,
    this.textInputAction,
    this.focusNode,
    this.prefixIconData,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.showLabelAboveTextField = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.fillColor,
    this.accentColor,
    this.textColor = Colors.black,
    this.borderRadius = 6,
    this.validator,
    this.showConfirmation = true,
    this.showError = true,
    this.verticalPadding = 20,
    this.horizontalPadding = 12,
  });

  final Function(String) onChanged;
  final TextEditingController textEditingController;
  final Iterable<String> autofillHints;
  final TextInputType textInputType;
  final bool autoFocus;
  final bool obscureText;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final IconData prefixIconData;
  final String hintText;
  final String labelText;
  final String errorText;

  /// Text placed below the text field
  final String helperText;
  final bool showLabelAboveTextField;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Color fillColor;
  final Color accentColor;
  final Color textColor;
  final double borderRadius;
  final bool Function(String) validator;
  final bool showConfirmation;
  final bool showError;
  final double verticalPadding;
  final double horizontalPadding;

  @override
  _SimpleTextFieldState createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  FocusNode focusNode;
  TextEditingController textEditingController;
  bool hasConfirmation;
  bool hasError;
  bool hasFocus;

  @override
  void initState() {
    super.initState();
    hasFocus = false;
    textEditingController = widget.textEditingController != null
        ? widget.textEditingController
        : TextEditingController();
    hasConfirmation = textEditingController.text != null ? isValid : false;
    hasError = textEditingController != null ? !isValid : false;
    focusNode = widget.focusNode != null ? widget.focusNode : FocusNode();

    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasPrimaryFocus;
        bool valid = isValid;
        hasConfirmation = valid;
        hasError = !valid;
      });
    });
  }

  bool get isValid {
    if (hasValidator) {
      return widget.validator(textEditingController.text);
    }
    return false;
  }

  bool get hasValidator {
    return widget.validator != null;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    OutlineInputBorder buildFocusedBorder() {
      if (hasValidator) {
        if (hasConfirmation && widget.showConfirmation) {
          return OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 1.25),
              borderRadius: BorderRadius.circular(widget.borderRadius));
        } else if (hasError) {
          return OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.25),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          );
        }
      }
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.accentColor ?? currentTheme.primaryColor,
          width: 1.25,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      );
    }

    OutlineInputBorder buildEnabledBorder() {
      if (hasValidator) {
        if (hasConfirmation) {
          return OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          );
        } else if (hasError) {
          return OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          );
        }
      }
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: Colors.black,
        ),
      );
    }

    TextStyle buildLabelStyle() {
      if (hasFocus) {
        return TextStyle(color: widget.accentColor);
      } else {
        return TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
      }
    }

    Icon buildSuffixIcon() {
      if (hasValidator) {
        if (hasConfirmation) {
          return Icon(Icons.check, color: Colors.green);
        } else if (hasError) {
          return Icon(
            Icons.error,
            color: Colors.red,
            size: 24,
          );
        }
      }
      return null;
    }

    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: widget.accentColor?.withOpacity(.33) ??
            currentTheme.primaryColor.withOpacity(.33),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null && widget.showLabelAboveTextField) ...[
            Text(
              widget.labelText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6),
          ],
          TextField(
            focusNode: focusNode,
            controller: textEditingController,
            autofillHints: widget.autofillHints,
            keyboardType: widget.textInputType,
            autofocus: widget.autoFocus,
            onChanged: (val) {
              setState(() {
                hasError = false;
                hasConfirmation = isValid;
              });
              if (widget.onChanged != null) {
                widget.onChanged(val);
              }
            },
            style:
                TextStyle(color: widget.textColor, fontWeight: FontWeight.bold),
            cursorColor: widget.textColor,
            obscureText: widget.obscureText,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: widget.verticalPadding,
                  horizontal: widget.horizontalPadding),
              isDense: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: widget.textColor.withOpacity(.45)),
              labelText:
                  widget.showLabelAboveTextField ? null : widget.labelText,
              labelStyle: buildLabelStyle(),
              errorText: widget.errorText != null && hasError && hasValidator
                  ? widget.errorText
                  : null,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              fillColor: widget.fillColor,
              filled: widget.fillColor != null,
              focusedBorder: buildFocusedBorder(),
              enabledBorder: buildEnabledBorder(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              prefixIcon: widget.prefixIconData != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 8),
                      child: Icon(
                        widget.prefixIconData,
                        color: hasFocus
                            ? widget.accentColor
                            : widget.textColor.withOpacity(.6),
                        size: 20,
                      ),
                    )
                  : null,
              prefixIconConstraints:
                  BoxConstraints(minHeight: 24, minWidth: 24),
              suffixIcon: buildSuffixIcon(),
            ),
          ),
          if (widget.helperText != null) ...[
            SizedBox(height: 6),
            Text(
              widget.helperText,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ]
        ],
      ),
    );
  }
}

Iterable<T> intersperse<T>(T element, Iterable<T> iterable) sync* {
  final iterator = iterable.iterator;
  if (iterator.moveNext()) {
    yield iterator.current;
    while (iterator.moveNext()) {
      yield element;
      yield iterator.current;
    }
  }
}

class SimpleElevatedButton extends StatelessWidget {
  const SimpleElevatedButton({
    this.child,
    this.color,
    this.onPressed,
    this.borderRadius = 6,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  });
  final Color color;
  final Widget child;
  final Function onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return ElevatedButton(
      child: child,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(500, 46),
        elevation: 0.2,
        padding: padding,
        primary: color ?? currentTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

_pushTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

//custom widgets
class SimpleListTile extends StatelessWidget {
  const SimpleListTile({
    Key key,
    @required this.imageURL,
    @required this.title,
    this.toPage,
  }) : super(key: key);
  final String imageURL;
  final String title;
  final toPage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (toPage != null) {
          _pushTo(context, toPage);
        } else {
          return null;
        }
      },
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: NetworkImage(imageURL),
        backgroundColor: Colors.transparent,
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  FormButton({this.text = "", this.onPressed});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String errorText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final bool obscureText;
  const InputField({
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.autoFocus = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
