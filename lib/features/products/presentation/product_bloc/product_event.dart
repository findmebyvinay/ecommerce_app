sealed class ProductEvent{
}

final class GetProductEvent extends ProductEvent{
  final bool isToRefresh;
  GetProductEvent({this.isToRefresh=false});
  
}