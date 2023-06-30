import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core_features/theme/presentation/utils/colors/app_static_colors.dart';
import 'platform_text_form_field.dart';
import '../../helpers/platform_helper.dart';
import '../../styles/font_styles.dart';
import '../../styles/sizes.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.initialValue,
    this.controller,
    this.validator,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.enabled,
    this.contentPadding,
    this.hintText,
    this.materialPrefix,
    this.cupertinoPrefix,
    this.suffix,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.errorMaxLines,
  });

  final String? initialValue;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final bool? enabled;
  final EdgeInsets? contentPadding;
  final String? hintText;
  final Widget? materialPrefix;
  final Widget? cupertinoPrefix;
  final Widget? suffix;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final int? errorMaxLines;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PlatformTextFormField(
          initialValue: initialValue,
          controller: controller,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          enabled: enabled,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          style: TextStyle(
            color: AppStaticColors.blue,
            fontSize: Sizes.font12,
            fontFamily: FontStyles.latoFontFamily(context),
          ),
          cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
          materialData: MaterialTextFormFieldData(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    vertical: Sizes.textFieldPaddingV14,
                    //horizontal: 0,
                  ),
              filled: false,
              //fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: Sizes.font12,
                fontFamily: FontStyles.fontFamily(context),
                color: Colors.grey,
              ),
              prefixIcon: materialPrefix,
              prefixIconColor:
                  Theme.of(context).inputDecorationTheme.prefixIconColor,
              prefixIconConstraints: const BoxConstraints(),
              suffixIcon: suffix != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: Sizes.paddingH14,
                      ),
                      child: suffix,
                    )
                  : null,
              suffixIconColor:
                  Theme.of(context).inputDecorationTheme.suffixIconColor,
              suffixIconConstraints: const BoxConstraints(),
              errorStyle: TextStyle(
                color: Theme.of(context).inputDecorationTheme.errorStyle?.color,
                fontWeight: FontStyles.fontWeightNormal,
                fontSize: Sizes.font12,
                fontFamily: FontStyles.fontFamily(context),
              ),
              errorMaxLines: errorMaxLines,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Sizes.textFieldR12),
                ),
                borderSide:
                    Theme.of(context).inputDecorationTheme.border!.borderSide,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Sizes.textFieldR12),
                ),
                borderSide: Theme.of(context)
                    .inputDecorationTheme
                    .enabledBorder!
                    .borderSide,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Sizes.textFieldR12),
                ),
                borderSide: Theme.of(context)
                    .inputDecorationTheme
                    .focusedBorder!
                    .borderSide,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Sizes.textFieldR12),
                ),
                borderSide: Theme.of(context)
                    .inputDecorationTheme
                    .errorBorder!
                    .borderSide,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Sizes.textFieldR12),
                ),
                borderSide: Theme.of(context)
                    .inputDecorationTheme
                    .errorBorder!
                    .borderSide,
              ),
            ),
          ),
          cupertinoData: CupertinoFormRowData(
            padding: contentPadding ??
                EdgeInsetsDirectional.only(
                  top: Sizes.textFieldPaddingV14,
                  bottom: Sizes.textFieldPaddingV14,
                  end: suffix != null ? Sizes.textFieldPaddingH38 : 0.0,
                ),
            placeHolder: hintText,
            placeholderStyle: TextStyle(
              fontSize: Sizes.font12,
              fontFamily: FontStyles.fontFamily(context),
              color: Theme.of(context).hintColor,
            ),
            prefix: cupertinoPrefix,
          ),
        ),
        //Add suffix manually for iOS https://github.com/flutter/flutter/issues/103385
        if (suffix != null && !PlatformHelper.isMaterialApp())
          PositionedDirectional(
            top: (contentPadding?.top ?? Sizes.textFieldPaddingV10) * 1.5,
            end: Sizes.paddingH14,
            child: suffix!,
          ),
      ],
    );
  }
}
