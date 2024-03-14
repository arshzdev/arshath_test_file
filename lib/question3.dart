List<String> getBalancedSubstrings(List<String> S) {
  List<String> result = [];

  // Function to check if a string is balanced
  bool isBalanced(String s) {
    if (s.length < 2) return false;
    Set<String> chars = s.split('').toSet();
    if (chars.length != 2) return false;
    int count1 = s.split(chars.first).length - 1;
    int count2 = s.split(chars.last).length - 1;
    return count1 == count2;
  }

  // Function to find longest balanced substring
  void findLongestBalancedSubstring(String s) {
    int maxLength = 0;
    List<String> longestBalanced = [];
    for (int i = 0; i < s.length; i++) {
      for (int j = i + 2; j <= s.length; j++) {
        String substr = s.substring(i, j);
        if (isBalanced(substr) && substr.length >= maxLength) {
          if (substr.length > maxLength) {
            maxLength = substr.length;
            longestBalanced.clear();
          }
          longestBalanced.add(substr);
        }
      }
    }
    result.addAll(longestBalanced);
  }

  // Iterate through each string in the list
  for (String s in S) {
    findLongestBalancedSubstring(s);
  }

  return result;
}

void main() {
  List<String> S1 = ["cabbacc"];
  List<String> S2 = ["abababa"];
  List<String> S3 = ["aaaaaaa"];

  print(getBalancedSubstrings(S1)); // Output: ["abba"]
  print(getBalancedSubstrings(S2)); // Output: ["ababab", "bababa"]
  print(getBalancedSubstrings(S3)); // Output: []
}
