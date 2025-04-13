abstract class LanguageEvent {}

class SetLanguageEvent extends LanguageEvent {
  final int languageId;
  SetLanguageEvent(this.languageId);
}
