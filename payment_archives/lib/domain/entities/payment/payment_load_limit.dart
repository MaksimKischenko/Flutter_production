enum PaymentLoadedLimit {
  small(100),
  middle(500),
  huge(1000);
  
  const PaymentLoadedLimit(this.count);
  final int count;
}
