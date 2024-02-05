class CompareString {
  static double calculateSimilarity(String s1, String s2) {
    if (s1 == s2) {
      return 1.0;
    }

    final int maxLength = s1.length > s2.length ? s1.length : s2.length;

    int editDistance = calculateEditDistance(s1, s2);
    return 1 - (editDistance / maxLength);
  }

  static int calculateEditDistance(String s1, String s2) {
    List<int> costs = List<int>.filled(s2.length + 1, 0);

    for (int i = 0; i <= s1.length; i++) {
      int lastValue = i;
      for (int j = 0; j <= s2.length; j++) {
        if (i == 0) {
          costs[j] = j;
        } else if (j > 0) {
          int newValue = costs[j - 1];
          if (s1.codeUnitAt(i - 1) != s2.codeUnitAt(j - 1)) {
            newValue = newValue < lastValue ? newValue : lastValue;
            newValue = newValue < costs[j] ? newValue : costs[j];
            newValue++;
          }
          costs[j - 1] = lastValue;
          lastValue = newValue;
        }
      }
      if (i > 0) {
        costs[s2.length] = lastValue;
      }
    }
    return costs[s2.length];
  }
}