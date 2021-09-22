abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetHealthLoadingState extends NewsStates {}

class NewsGetHealthState extends NewsStates {}

class NewsGetHealthErrorState extends NewsStates {
  final String error;
  NewsGetHealthErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetGeneralLoadingState extends NewsStates {}

class NewsGetGeneralState extends NewsStates {}

class NewsGetGeneralErrorState extends NewsStates {
  final String error;
  NewsGetGeneralErrorState(this.error);
}

class NewsSearchLoadingState extends NewsStates {}

class NewsSearchState extends NewsStates {}

class NewsSearchErrorState extends NewsStates {
  final String error;
  NewsSearchErrorState(this.error);
}

class NewsChangeThemeState extends NewsStates {}


