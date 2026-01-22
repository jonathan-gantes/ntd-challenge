# Failing Tests and Bug Analysis

Below is a summary of all failing tests, including the expected and actual results. Most failures are related to floating-point precision issues (float64 limitations), where the implementation does not match the required decimal accuracy.

---

## 1. Repeating Decimals
- **Test:** 10 ÷ 3
  - Expected: 3.3333333333333335
  - Got: 3.33333333
- **Test:** 1 ÷ 3
  - Expected: 0.3333333333333333
  - Got: 0.33333333
- **Test:** 1 ÷ 7
  - Expected: 0.14285714285714285
  - Got: 0.14285714
- **Test:** 2 ÷ 7
  - Expected: 0.2857142857142857
  - Got: 0.28571429

## 2. Precision Boundary
- **Test:** Precision boundary multiply (0.3333333333333333 × 3)
  - Expected: 0.9999999999999999
  - Got: 1

## 3. Addition with High Decimal Precision
- **Test:** 1.000000001 + 1.000000001
  - Expected: 2.000000002
  - Got: 2
- **Test:** 1.0000000001 + 1.0000000001
  - Expected: 2.0000000002
  - Got: 2
- **Test:** 1.00000000001 + 1.00000000001
  - Expected: 2.00000000002
  - Got: 2
- **Test:** 1.000000000001 + 1.000000000001
  - Expected: 2.000000000002
  - Got: 2
- **Test:** 1.0000000000001 + 1.0000000000001
  - Expected: 2.0000000000002
  - Got: 2
- **Test:** 1.00000000000001 + 1.00000000000001
  - Expected: 2.00000000000002
  - Got: 2
- **Test:** 1.000000000000001 + 1.000000000000001
  - Expected: 2.000000000000002
  - Got: 2
- **Test:** 1.0000000000000001 + 1.0000000000000001
  - Expected: 2.0000000000000002
  - Got: 2

## 4. Subtraction with High Decimal Precision
- **Test:** 2.000000002 - 1.000000001
  - Expected: 1.000000001
  - Got: 1
- **Test:** 2.0000000002 - 1.0000000001
  - Expected: 1.0000000001
  - Got: 1
- **Test:** 2.00000000002 - 1.00000000001
  - Expected: 1.00000000001
  - Got: 1
- **Test:** 2.000000000002 - 1.000000000001
  - Expected: 1.000000000001
  - Got: 1
- **Test:** 2.0000000000002 - 1.0000000000001
  - Expected: 1.0000000000001
  - Got: 1
- **Test:** 2.00000000000002 - 1.00000000000001
  - Expected: 1.00000000000001
  - Got: 1
- **Test:** 2.000000000000002 - 1.000000000000001
  - Expected: 1.000000000000001
  - Got: 1
- **Test:** 2.0000000000000002 - 1.0000000000000001
  - Expected: 1.0000000000000001
  - Got: 1

## 5. Multiplication with High Decimal Precision
- **Test:** 2 × 1.000000001
  - Expected: 2.000000002
  - Got: 2
- **Test:** 2 × 1.0000000001
  - Expected: 2.0000000002
  - Got: 2
- **Test:** 2 × 1.00000000001
  - Expected: 2.00000000002
  - Got: 2
- **Test:** 2 × 1.000000000001
  - Expected: 2.000000000002
  - Got: 2
- **Test:** 2 × 1.0000000000001
  - Expected: 2.0000000000002
  - Got: 2
- **Test:** 2 × 1.00000000000001
  - Expected: 2.00000000000002
  - Got: 2
- **Test:** 2 × 1.000000000000001
  - Expected: 2.000000000000002
  - Got: 2
- **Test:** 2 × 1.0000000000000001
  - Expected: 2.0000000000000002
  - Got: 2

## 6. Division with High Decimal Precision
- **Test:** 2.000000002 ÷ 2
  - Expected: 1.000000001
  - Got: 1
- **Test:** 2.0000000002 ÷ 2
  - Expected: 1.0000000001
  - Got: 1
- **Test:** 2.00000000002 ÷ 2
  - Expected: 1.00000000001
  - Got: 1
- **Test:** 2.000000000002 ÷ 2
  - Expected: 1.000000000001
  - Got: 1
- **Test:** 2.0000000000002 ÷ 2
  - Expected: 1.0000000000001
  - Got: 1
- **Test:** 2.00000000000002 ÷ 2
  - Expected: 1.00000000000001
  - Got: 1
- **Test:** 2.000000000000002 ÷ 2
  - Expected: 1.000000000000001
  - Got: 1
- **Test:** 2.0000000000000002 ÷ 2
  - Expected: 1.0000000000000001
  - Got: 1

## 7. Large Number Multiplication
- **Test:** Large multiply
  - Expected: 999999999999000000
  - Got: 999999999999000060

---

## Failures Root Cause
The root cause of these failures is the use of 32-bit floating-point numbers (float32) for mathematical operations. The float32 type can only accurately represent about 6 to 9 significant decimal digits, which is insufficient for calculations requiring higher precision. As a result, many test cases that expect more than 6-9 digits of accuracy fail due to rounding errors and loss of precision. Even float64 (double precision) can represent about 15-17 significant digits, but the current implementation does not use it, leading to even greater inaccuracies. To resolve these issues and pass the tests, the application should use at least float64 (double precision) for all calculations, or consider arbitrary-precision arithmetic (such as Python's `decimal.Decimal` or similar libraries in other languages) if even higher precision is required.
