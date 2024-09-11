class EMADistressDetection {
  final double alpha;
  final double distressThreshold;
  double? _currentEMA;

  EMADistressDetection(this.alpha, this.distressThreshold);

  double updateEMA(double score) {
    // If EMA is not initialized yet, set it to the current score
    if (_currentEMA == null) {
      _currentEMA = score;
    } else {
      // EMA_new = alpha * score + (1 - alpha) * EMA_previous
      _currentEMA = alpha * score + (1 - alpha) * _currentEMA!;
    }

    return _currentEMA!;
  }

  bool isUserInDistress() {
    // Check if EMA has crossed the distress threshold
    if (_currentEMA == null) return false;
    return _currentEMA! > distressThreshold;
  }
}
