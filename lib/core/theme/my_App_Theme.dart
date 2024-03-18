import 'package:flutter/material.dart';
import '../../../../core/constants.dart';

class MyAppTheme {
  static final ThemeData myTheme = ThemeData(
    // GENERAL CONFIGURATION
    applyElevationOverlayColor: false,
    cupertinoOverrideTheme: null,
    extensions: null,

    inputDecorationTheme:const InputDecorationTheme(
      
        hintStyle: TextStyle(
          color: Constants.cyanColoraec6cf,
          fontSize: Constants.fontSizeHintText ,
          fontWeight: FontWeight.w400),
        border:  OutlineInputBorder(),
        enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Constants.cyanColoraec6cf)),
        focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Constants.cyanColoraec6cf))
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    pageTransitionsTheme: const PageTransitionsTheme(),
    platform: TargetPlatform.android,
    scrollbarTheme: const ScrollbarThemeData(),
    splashFactory: null,
    useMaterial3: false,
    visualDensity: VisualDensity.standard,
    // COLOR
    brightness: Brightness.light,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    colorSchemeSeed: null,
    dialogBackgroundColor: Colors.white,
    disabledColor: Colors.grey,
    dividerColor: Colors.grey,
    focusColor: Colors.blue,
    highlightColor: Colors.transparent,
    hintColor: Colors.grey,
    hoverColor: Colors.grey,
    indicatorColor: Colors.blue,
    primaryColor: Colors.white,

    primaryColorDark: Colors.blue[700],
    primaryColorLight: Colors.blue[200],
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    secondaryHeaderColor: Colors.grey,
    shadowColor: Colors.black,
    splashColor: Colors.transparent,
    unselectedWidgetColor: Colors.grey,
    // TYPOGRAPHY & ICONOGRAPHY
    fontFamily: 'Roboto',
    fontFamilyFallback: null,
    package: null,
    iconTheme: const IconThemeData(   size: 18,
        color: Constants.cyanColoraec6cf),
    primaryIconTheme:const IconThemeData(
      size: 18,
      color: Constants.cyanColoraec6cf
    ),
    primaryTextTheme: const TextTheme(
    ),
    textTheme: const TextTheme(
      bodyMedium:  TextStyle(
          fontSize: Constants.fontSizeCharactersInTextFormField,
          color: Constants.blackColor),
      labelMedium:  TextStyle(
          fontSize: Constants.fontSizeLableText,
          color: Constants.blackColor),
      headlineMedium: TextStyle(
          fontSize:16,
          color: Constants.primaryColor),
      titleMedium: TextStyle(
        color: Constants.secondaryColor,
        fontSize:16,
      ),
      displayLarge:  TextStyle(
        color: Constants.secondaryColor,
        fontSize: Constants.sizeWordsPages,
        fontWeight:Constants.fontWeight,
      ),
      displaySmall:TextStyle(
        fontSize: 14.0 ,
        fontWeight: FontWeight.w400,
        color:  Constants.blackColor,
      ),
      titleSmall: TextStyle(
        color: Constants.secondaryColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
    typography: Typography.material2018(),
    // COMPONENT THEMES
    appBarTheme: const AppBarTheme(
      backgroundColor: Constants.primaryColor,
    ),
    badgeTheme: const BadgeThemeData(),
    bannerTheme: const MaterialBannerThemeData(),
    bottomAppBarTheme: const BottomAppBarTheme(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
    bottomSheetTheme: const BottomSheetThemeData(),
    buttonBarTheme: const ButtonBarThemeData(),
    buttonTheme: const ButtonThemeData(),
    cardTheme: const CardTheme(),
    checkboxTheme: const CheckboxThemeData(),
    chipTheme: const ChipThemeData(),
    dataTableTheme: const DataTableThemeData(),
    dialogTheme: const DialogTheme(),
    dividerTheme: const DividerThemeData(),
    drawerTheme: const DrawerThemeData(),
    dropdownMenuTheme:  DropdownMenuThemeData(

    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(),
    expansionTileTheme: const ExpansionTileThemeData(),
    filledButtonTheme: const FilledButtonThemeData(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    iconButtonTheme: const IconButtonThemeData(),
    listTileTheme: const ListTileThemeData(),
    menuBarTheme: const MenuBarThemeData(),
    menuButtonTheme: const MenuButtonThemeData(),
    menuTheme: const MenuThemeData(),
    navigationBarTheme: const NavigationBarThemeData(),
    navigationDrawerTheme: const NavigationDrawerThemeData(),
    navigationRailTheme: const NavigationRailThemeData(),
    outlinedButtonTheme: const OutlinedButtonThemeData(),
    popupMenuTheme: const PopupMenuThemeData(),
    progressIndicatorTheme: const ProgressIndicatorThemeData(),
    radioTheme: const RadioThemeData(),
    segmentedButtonTheme: const SegmentedButtonThemeData(),
    sliderTheme: const SliderThemeData(),
    snackBarTheme: const SnackBarThemeData(),
    switchTheme: const SwitchThemeData(),
    tabBarTheme: const TabBarTheme(),
    textButtonTheme: const TextButtonThemeData(),
    textSelectionTheme:const TextSelectionThemeData(
      cursorColor: Constants.secondaryColor
    ),
    timePickerTheme: const TimePickerThemeData(),
    toggleButtonsTheme: const ToggleButtonsThemeData(),
    tooltipTheme: const TooltipThemeData(),

  );
}
