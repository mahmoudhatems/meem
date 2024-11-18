double calculateDiscountPercentage(double oldPrice, double newPrice) {
  if (oldPrice > newPrice) {
    return ((oldPrice - newPrice) / oldPrice) * 100;
  }
  return 0;
}
