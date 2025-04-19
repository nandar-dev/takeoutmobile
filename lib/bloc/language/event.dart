abstract class LanguageEvent {}

class SetLanguageEvent extends LanguageEvent {
  final String languageId;
  SetLanguageEvent(this.languageId);
}
