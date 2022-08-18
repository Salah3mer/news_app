abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class BottomNavBarState extends NewsStates{}

class NewsLoadingState extends NewsStates{}

class GetBusinessNewsSuccessState extends NewsStates{}

class GetBusinessNewsErrorState extends NewsStates{
final String error;
  GetBusinessNewsErrorState(this.error);
}

class GetSportNewsSuccessState extends NewsStates{}

class GetSportNewsErrorState extends NewsStates{
  final String error;
  GetSportNewsErrorState(this.error);
}

class GetSciencesNewsErrorState extends NewsStates{
  final String error;
  GetSciencesNewsErrorState(this.error);
}

class GetSciencesNewsSuccessState extends NewsStates{}

class GetEverythingSuccessState extends NewsStates{}

class GetEverythingErrorState extends NewsStates{
  final String error;
  GetEverythingErrorState(this.error);
}
class GetSearchSuccessState extends NewsStates{}

class GetSearchErrorState extends NewsStates{
  final String error;
  GetSearchErrorState(this.error);
}

class ChangeMoodState extends NewsStates{}