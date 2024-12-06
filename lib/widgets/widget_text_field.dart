import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import 'widget_button.dart';
import 'widget_text.dart';

enum EnumTextFieldTitle { sideTitle, topTitle }

enum EnumTextField {
  none,
  datePicker,
  dropdown,
  verified,
  unverified,
}

enum EnumTextInputType {
  mobile,
  email,
  capitalLettersWithDigitsNoSpecialChars, //eg:ifsc
  onlyDigits, //eg:bank account no
  capitalLettersWithDigitsWithSpecialChars,
  onlyLetters, //eg:bank name
  panCardNumber,
  digitsWithDecimal,
  birthDate,
  vehicleNumber,
  name
}

enum EnumValidator {
  mobile,
  email,
  ifsc,
  adhar,
  text,
  panCard,
  passport,
  voterId,
  gstNumber,
  bankAccountNo,
  pincode,
  vehicleNo,
  upiId,
  fourDigitPassword,
}

class ModelTextField {
  String? title;
  EnumTextFieldTitle? enumTextFieldTitle;
  bool? isCompulsory, isEnable;

  ModelTextField({
    this.title,
    this.enumTextFieldTitle = EnumTextFieldTitle.topTitle,
    this.isCompulsory = false,
    this.isEnable = true,
  });
}

class WidgetTextField extends StatefulWidget {
  EnumTextField? eNum;
  final EnumTextInputType? enumTextInputType;
  final EnumValidator? enumValidator;
  final EnumWidgetSize? size;
  String? heleperText, suffixText, hintText, dropDownPreSelectedId, errorText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines; // should be always less than maxLines

  final Color? fillColor;
  final Color? borderColor;

  final bool? isLoading; //isCompulsory
  final bool? obscureText;
  final DateTime? initialDate, firstDate;
  final Widget? frontIconDynamic, backIconDynamic;
  final String? fronIconUrl;

  final TextEditingController controller;

  final Function(DateTime)? selectedDate;
  final Function(DateTimeRange)? selectedDateRage;

  final Function(String)? onChanged;
  final Function(String)? onSearch;

  final Function(String)? validator;

  final Function? onDelete;
  final VoidCallback? onEditingComplete;
  final Function? onEdit;

  final Function? clear;
  final Function? onTap;

  final TextStyle? errorStyle;

  final double? bottomMargin;
  final ModelTextField? modelTextField;

  final TextStyle? suffixTextStyle;
  TextAlign? textAlign;
  String? labelText;
  double? borderRadius;
  Widget? suffixIcon;
  bool? showOnlyBottomBorder;
  EdgeInsetsGeometry? contentPadding;
  String? dateFormatUrl;

  WidgetTextField(
      {Key? key,
      required this.controller,
      this.enumTextInputType,
      this.eNum,
      this.enumValidator,
      this.dropDownPreSelectedId,
      this.heleperText,
      this.hintText,
      this.suffixText,
      this.errorText,
      this.maxLength,
      this.fillColor,
      this.borderColor,
      this.isLoading,
      this.frontIconDynamic,
      this.backIconDynamic,
      this.validator,
      this.selectedDate,
      this.selectedDateRage,
      this.onChanged,
      this.onDelete,
      this.clear,
      this.onEdit,
      this.onTap,
      this.onSearch,
      this.errorStyle,
      this.bottomMargin,
      this.initialDate,
      this.size,
      this.maxLines = 1,
      this.minLines,
      this.modelTextField,
      this.onEditingComplete,
      this.obscureText,
      this.firstDate,
      this.suffixTextStyle,
      this.textAlign,
      this.labelText,
      this.borderRadius = 8,
      this.suffixIcon,
      this.fronIconUrl,
      this.showOnlyBottomBorder = false,
      this.contentPadding,
      this.dateFormatUrl});

  @override
  _WidgetTextFieldState createState() => _WidgetTextFieldState();
}

class _WidgetTextFieldState extends State<WidgetTextField> {
  bool isError = false;
  @override
  void initState() {
    super.initState();
    widget.eNum ?? EnumTextField.none;
  }

  Color iconColor = const Color(0xff656565);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.modelTextField?.enumTextFieldTitle ==
            EnumTextFieldTitle.topTitle)
          if (widget.modelTextField?.title != null)
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [widgetTextTitle(), widgetIsCompulsory()],
                )),
        Container(
          height: widget.size == EnumWidgetSize.sm ? 55 : null,
          padding: EdgeInsets.only(
              bottom: widget.bottomMargin != null ? widget.bottomMargin! : 15),
          child: Row(
            children: [
              if (widget.modelTextField?.enumTextFieldTitle ==
                  EnumTextFieldTitle.sideTitle)
                if (widget.modelTextField?.title != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 7),
                        child: widgetTextTitle(),
                      ),
                      widgetIsCompulsory()
                    ],
                  ),
              Flexible(flex: 2, child: widgetTextField()),
            ],
          ),
        )
      ],
    );
  }

  Widget widgetTextTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 3, right: 2),
      child: Text(
        widget.modelTextField!.title!,
        maxLines: 3,
        style: textStylePoppins(
            fontSize: 15,
            textColor: Colors.grey.shade600,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget widgetIsCompulsory() {
    return Visibility(
        visible: widget.modelTextField?.isCompulsory == true &&
            widget.modelTextField!.title!.isNotEmpty,
        child: const Text(
          '*',
          style: TextStyle(color: Colors.red),
        ));
  }

  Widget widgetTextField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: widget.maxLines,
            minLines: widget.minLines,

            autofocus: false,
            //checking widget.eNUm==null because if we click same textfield more than once it gets assign null so
            //i am checking null condition
            readOnly: widget.eNum == EnumTextField.none || widget.eNum == null
                ? false
                : true,
            controller: widget.controller,
            obscureText: widget.obscureText ?? false,
            maxLength: widget.maxLength,
            //if custom validator is provided it will override widget.enumValidator
            validator: (value) => widget.validator != null
                ? widget.validator!(value!)
                : widget.enumValidator != null
                    ? validation(value!)
                    : null,

            enabled: widget.modelTextField != null
                ? widget.modelTextField?.isEnable == true
                    ? true
                    : false
                : true,
            onChanged: widget.onChanged == null
                ? null
                : (value) => widget.onChanged!(value),
            onEditingComplete: widget.onEditingComplete,
            textCapitalization: textCapitalization(),
            keyboardType: keyBoardType(),
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontSize: () {
                switch (widget.size) {
                  case EnumWidgetSize.sm:
                    return 14.0;
                  case EnumWidgetSize.md:
                    return 16.0;
                  case EnumWidgetSize.lr:
                    return 18.0;
                  default:
                    return 16.0;
                }
              }(),
            ),
            onTap: () {
              if (widget.eNum == EnumTextField.datePicker) {
                FocusScope.of(context).unfocus();
                selectDate(context);
              } else if (widget.eNum == EnumTextField.dropdown) {
                FocusScope.of(context).unfocus();
                widget.onTap!();
              }
            },
            textAlign: widget.textAlign ?? TextAlign.start,
            decoration: InputDecoration(
                errorMaxLines: 3,
                contentPadding: widget.contentPadding ??
                    (widget.labelText != null
                        ? const EdgeInsets.all(0.0)
                        : () {
                            switch (widget.size) {
                              case EnumWidgetSize.sm:
                                return const EdgeInsets.all(10.0);
                              case EnumWidgetSize.md:
                                return const EdgeInsets.all(20.0);
                              case EnumWidgetSize.lr:
                                return const EdgeInsets.only(
                                    left: 12, top: 20, bottom: 20, right: 12);
                              default:
                                return EdgeInsets.only(
                                    left: widget.frontIconDynamic != null
                                        ? 0
                                        : 10,
                                    top: 12,
                                    bottom: 12,
                                    right: 12);
                            }
                          }()),
                filled: widget.modelTextField?.isEnable == false
                    ? true
                    : widget.fillColor != null
                        ? true
                        : false,
                fillColor: widget.modelTextField?.isEnable == false
                    ? const Color(0xffF5F5F5)
                    : widget.fillColor ?? Colors.white,
                label: widget.labelText != null
                    ? Text(
                        widget.labelText!,
                        style: GoogleFonts.montserrat(),
                      )
                    : null,
                labelStyle: textStyleRubik(),
                floatingLabelStyle: textStyleRubik(),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                prefixIcon: prifix(),
                suffixIcon: widget.suffixIcon ?? sufix(),
                suffixText: widget.suffixText,
                suffixStyle: widget.suffixTextStyle,
                helperText: widget.heleperText,
                helperStyle: TextStyle(
                    fontSize: () {
                      switch (widget.size) {
                        case EnumWidgetSize.sm:
                          return 12.0;
                        case EnumWidgetSize.md:
                          return 14.0;
                        case EnumWidgetSize.lr:
                          return 16.0;
                        default:
                          return 14.0;
                      }
                    }(),
                    color: widget.borderColor != null
                        ? widget.borderColor!
                        : const Color(0xff656565)),
                errorText: widget.errorText,
                errorStyle:
                    textStylePoppins(fontSize: 14, fontWeight: FontWeight.w400),
                hintText: widget.hintText,
                hintStyle: textStylePoppins(
                    textColor: Colors.grey.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                counterText: "",
                counter: () {
                  if (widget.eNum == EnumTextField.verified) {
                    return const Text("verified");
                  } else if (widget.eNum == EnumTextField.unverified) {
                    return const Text("unverified");
                  } else {
                    return null;
                  }
                }(),
                disabledBorder: inputBorder(widget.borderColor != null
                    ? widget.borderColor!
                    : Colors.grey),
                enabledBorder: widget.labelText != null
                    ? UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: widget.borderColor != null
                                ? widget.borderColor!
                                : Colors.grey),
                      )
                    : inputBorder(widget.borderColor != null
                        ? widget.borderColor!
                        : Colors.grey.shade400),
                focusedBorder: widget.labelText != null
                    ? const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      )
                    : inputBorder(Colors.orange),
                errorBorder: widget.labelText != null
                    ? const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      )
                    : inputBorder(Colors.red),
                focusedErrorBorder: inputBorder(Colors.red)),
            inputFormatters: textInputformatter(),
          ),
        ),
        if (widget.onDelete != null)
          InkWell(
            onTap: widget.onDelete == null ? null : () => widget.onDelete!(),
            child: Container(
              margin: const EdgeInsets.only(
                  left: 12, right: 12, top: 10, bottom: 10),
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  InputBorder inputBorder(Color color) {
    return widget.showOnlyBottomBorder == true
        ? UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(
              color: color,
            ),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            borderSide: BorderSide(
              color: color,
            ),
          );
  }

  TextCapitalization textCapitalization() {
    if (widget.enumTextInputType == EnumTextInputType.email) {
      return TextCapitalization.none;
    }

    if (widget.enumTextInputType ==
            EnumTextInputType.capitalLettersWithDigitsNoSpecialChars ||
        widget.enumTextInputType ==
            EnumTextInputType.capitalLettersWithDigitsWithSpecialChars ||
        widget.enumTextInputType == EnumTextInputType.panCardNumber ||
        widget.enumTextInputType == EnumTextInputType.vehicleNumber) {
      return TextCapitalization.characters;
    }
    return TextCapitalization.words;
  }

  TextInputType keyBoardType() {
    if (widget.enumTextInputType == EnumTextInputType.digitsWithDecimal) {
      return const TextInputType.numberWithOptions(
          signed: false, decimal: true);
    } else if (widget.enumTextInputType == EnumTextInputType.mobile ||
        widget.enumTextInputType == EnumTextInputType.onlyDigits) {
      return const TextInputType.numberWithOptions(
          decimal: false, signed: false);
    } else if (widget.enumTextInputType == EnumTextInputType.email) {
      return TextInputType.emailAddress;
    }
    return TextInputType.text;
  }

  List<TextInputFormatter> textInputformatter() {
    List<TextInputFormatter> listFormatters = [];
    listFormatters.add(
      NoLeadingSpacesFormatter(),
    );
    if (widget.enumTextInputType == EnumTextInputType.mobile) {
      listFormatters.add(FilteringTextInputFormatter.digitsOnly);
      listFormatters.add(LengthLimitingTextInputFormatter(10));
    } else if (widget.enumTextInputType == EnumTextInputType.onlyDigits) {
      listFormatters.add(FilteringTextInputFormatter.digitsOnly);
    } else if (widget.enumTextInputType ==
        EnumTextInputType.capitalLettersWithDigitsNoSpecialChars) {
      listFormatters.add(UpperCaseTextFormatter());
      listFormatters
          .add(FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")));
    } else if (widget.enumTextInputType ==
        EnumTextInputType.capitalLettersWithDigitsWithSpecialChars) {
      listFormatters.add(UpperCaseTextFormatter());
    } else if (widget.enumTextInputType == EnumTextInputType.onlyLetters) {
      listFormatters.add(FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")));
    } else if (widget.enumTextInputType == EnumTextInputType.panCardNumber) {
      listFormatters.add(UpperCaseTextFormatter());
      listFormatters
          .add(FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")));
      listFormatters.add(LengthLimitingTextInputFormatter(10));
    } else if (widget.enumTextInputType ==
        EnumTextInputType.digitsWithDecimal) {
      listFormatters.add(
        FilteringTextInputFormatter.allow(RegExp(r"^(\d+)?([.]?\d{0,3})?$")),
      );
    } else if (widget.enumTextInputType == EnumTextInputType.name) {
      listFormatters.add(
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),
        // r'[a-zA-Z]'
      );
      listFormatters.add(FirstWordUpparCaseTextFormatter());
    } else {
      listFormatters.add(FirstWordUpparCaseTextFormatter());
    }
    return listFormatters;
  }

  Widget? prifix() {
    if (widget.eNum == EnumTextField.datePicker) {
      return SizedBox();
    } else if (widget.frontIconDynamic != null) {
      return Container(
        margin: const EdgeInsets.only(top: 1, left: 1, bottom: 1, right: 0),
        child: Container(
          margin: const EdgeInsets.only(right: 7, left: 7),
          child: widget.frontIconDynamic,
        ),
      );
    } else if (widget.fronIconUrl != null) {
      return SizedBox();
    } else if (widget.onEdit != null) {
      return InkWell(
        onTap: widget.onEdit == null ? null : () => widget.onEdit!(),
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          color: Colors.green.withOpacity(.2),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      );
    } else if (widget.onSearch != null) {
      return const Icon(Icons.search);
    } else {
      return null;
    }
  }

  Widget? sufix() {
    if (widget.eNum == EnumTextField.verified ||
        (widget.clear != null || widget.onSearch != null) &&
            widget.controller.text.isNotEmpty ||
        (widget.modelTextField?.isEnable == false) ||
        widget.backIconDynamic != null ||
        widget.isLoading != null ||
        widget.eNum == EnumTextField.dropdown) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.eNum == EnumTextField.verified)
            const Icon(
              Icons.done_rounded,
              color: Colors.green,
            ),
          if (widget.eNum == EnumTextField.dropdown)
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
              size: 35,
            ),
          if (isError)
            const Icon(
              Icons.warning,
              color: Colors.red,
            ),
          if ((widget.clear != null || widget.onSearch != null) &&
              widget.controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                widget.clear != null ? widget.clear!() : print('no action');
              },
              icon: const Icon(
                Icons.close,
                color: Colors.grey,
              ),
            ),
          // if (widget.modelTextField?.isEnable == false)
          //   const Icon(
          //     Icons.not_interested,
          //     color: Colors.grey,
          //   ),
          if (widget.backIconDynamic != null) widget.backIconDynamic!,
          if (widget.isLoading != null)
            Visibility(
              visible: widget.isLoading!,
              child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )),
            )
        ],
      );
    } else {
      return null;
    }
  }

  validation(String value) {
    if (value.isEmpty && widget.modelTextField?.isCompulsory != true) {
      return null;
    } else if (value.isEmpty && widget.modelTextField?.isCompulsory == true) {
      return 'This field should not be empty';
    } else if (widget.enumValidator == EnumValidator.email) {
      RegExp regExpEmail = RegExp(HelperRegEx.regExEmail);

      if (!regExpEmail.hasMatch(value.toString())) {
        return 'Please enter valid email id';
      }

      return null;
    } else if (widget.enumValidator == EnumValidator.mobile) {
      RegExp regExpMobile = RegExp(HelperRegEx.regExMobileNumber);

      if (!regExpMobile.hasMatch(value.toString())) {
        return 'Please enter valid mobile number';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.ifsc) {
      RegExp regExpIFSC = RegExp(HelperRegEx.regExIFSC);

      if (!regExpIFSC.hasMatch(value.toString())) {
        return 'Please enter valid ifsc code';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.panCard) {
      RegExp regExpPAN = RegExp(HelperRegEx.regExPanCard);

      if (!regExpPAN.hasMatch(value.toString())) {
        return 'Please enter valid pan card number';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.passport) {
      RegExp regExpPassport = RegExp(HelperRegEx.regExPassport);

      if (!regExpPassport.hasMatch(value.toString())) {
        return 'Please enter valid passport number';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.voterId) {
      RegExp regExpVoter = RegExp(HelperRegEx.regExVoterId);

      if (!regExpVoter.hasMatch(value.toString())) {
        return 'Please enter valid voter id number';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.gstNumber) {
      RegExp regExGst = RegExp(HelperRegEx.regExGst);

      if (!regExGst.hasMatch(value.toString())) {
        return 'Please enter valid gst number';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.bankAccountNo) {
      RegExp regExBankAccountNo = RegExp(HelperRegEx.regExBankAccountNo);

      if (!regExBankAccountNo.hasMatch(value.toString())) {
        return 'Please enter valid account number';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.pincode) {
      RegExp regExPincode = RegExp(HelperRegEx.regExPincode);

      if (!regExPincode.hasMatch(value.toString())) {
        return 'Please enter valid pincode';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.vehicleNo) {
      RegExp regExVehicle = RegExp(HelperRegEx.regexVehicleNumber);

      if (!regExVehicle.hasMatch(value.toString())) {
        return 'Please enter valid vehicle number';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.upiId) {
      RegExp regExUPIid = RegExp(HelperRegEx.regExUPIid);

      if (!regExUPIid.hasMatch(value.toString())) {
        return 'Please enter valid upi id';
      }
      return null;
    } else if (widget.enumValidator == EnumValidator.fourDigitPassword) {
      RegExp regExPassword = RegExp(HelperRegEx.regExFourDigit);

      if (!regExPassword.hasMatch(value.toString())) {
        return 'Pin Code Should be 4 digit';
      }
      return null;
    } else {
      return null;
    }
  }

  setError() {
    setState(() {
      isError = true;
    });
  }

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:
            widget.initialDate != null ? widget.initialDate! : selectedDate,
        firstDate:
            widget.firstDate != null ? widget.firstDate! : DateTime(1900, 8),
        lastDate: widget.enumTextInputType == EnumTextInputType.birthDate
            ? DateTime.now()
            : DateTime(2101));
    if (picked != null && picked != selectedDate) {
      widget.selectedDate!(picked);
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class FirstWordUpparCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text,
      selection: newValue.selection,
    );
  }
}

class HelperRegEx {
  static String regExMobileNumber = '^[6-9]{1}[0-9]{9}';
  static String regExFourDigit = r'^\d{4}$';
  static String regExEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String regExIFSC = r"^[A-Z]{4}0[A-Z0-9]{6}$";
  static String regExPanCard = r"[A-Z]{5}[0-9]{4}[A-Z]{1}";
  static String regExPassport = r"^[A-PR-WYa-pr-wy][1-9]\\d\\s?\\d{4}[1-9]$";
  //not sure for voter id
  static String regExVoterId = r"/^([a-zA-Z]){3}([0-9]){7}?$/g";
  static String regExGst =
      r"\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}";
  static String regExBankAccountNo = r"^\d{9,18}$";
  static String regExPincode = r"^[1-9][0-9]{5}$";
  static String regexVehicleNumber =
      r'(^[A-Z]{3}[0-9]{1,4}$)|^([A-Z]{2}[0-9]{1,2}(?:[A-Z])?(?:[A-Z]*)?[0-9]{4}$)';
  static String regExUPIid = r"^[\w.-]+@[\w.-]+$";
}

class NoLeadingSpacesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if the new text starts with a space
    if (newValue.text.startsWith(' ')) {
      // If it does, return the old value
      return oldValue;
    }
    // Otherwise, return the new value
    return newValue;
  }
}
