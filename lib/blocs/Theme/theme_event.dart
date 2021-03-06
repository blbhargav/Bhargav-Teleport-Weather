part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final bool value;

  ThemeChanged(this.value) : assert(value != null);

  @override
  List<Object> get props => [value];
}

class ThemeLoadStarted extends ThemeEvent {}

class DarkThemeEvent extends ThemeEvent{}
class LightThemeEvent extends ThemeEvent{}
class SystemDefaultEvent extends ThemeEvent{}