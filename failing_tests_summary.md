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

## Root Cause
Most failures are due to insufficient floating-point precision (float64), which cannot represent or maintain the required number of decimal places for these operations.
