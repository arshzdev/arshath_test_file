import 'dart:collection';

int fibonacci(int n, Map<int, int> memo) {
  if (memo.containsKey(n)) {
    return memo[n]!;
  }

  if (n <= 1) {
    memo[n] = n;
  } else {
    memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo);
  }

  return memo[n]!;
}

int fibonacciMemo(int n) {
  var memo = HashMap<int, int>();
  return fibonacci(n, memo);
}

void main() {
  int position = 100; // Change this to any position you want
  int fibValue = fibonacciMemo(position);
  print('Fibonacci value at position $position: $fibValue');
}
