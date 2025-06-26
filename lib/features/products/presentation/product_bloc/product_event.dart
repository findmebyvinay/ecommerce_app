sealed class ProductEvent{
}

final class GetProductEvent extends ProductEvent{
  final bool isToRefresh;
  GetProductEvent({this.isToRefresh=false});
  
}

final class SaveProductEvent extends ProductEvent{
  final bool isToRefresh;
  SaveProductEvent({this.isToRefresh=false});
}

final class SearchProductEvent extends ProductEvent{
  final String query;
  SearchProductEvent(this.query);

}

