# Calculator Test Suite: All Test Cases

This document lists every test case defined in `test_calculator.sh` for the LoanPro calculator CLI.

---

## ADDITION TESTS
### Basic Functionality
- 5 + 3 = 8 (Positive + Positive)
- -5 + -3 = -8 (Negative + Negative)
- 5 + -3 = 2 (Positive + Negative)
- -5 + 3 = -2 (Negative + Positive)
- 0 + 5 = 5 (Zero + Positive)
- 0 + -5 = -5 (Zero + Negative)
- 0 + 0 = 0 (Zero + Zero)

### Decimal/Floating Point
- 1.5 + 2.5 = 4 (Decimals)
- 0.1 + 0.2 = 0.3 (Small decimals)
- 5 + 2.5 = 7.5 (Integer + Decimal)
- 1.1 + 2.2 = 3.3 (Decimals)

### Boundary Values
- 999999999999999 + 1 = 1000000000000000 (Large numbers)
- 0.0000000001 + 0.0000000002 = 0 (Very small numbers)
- -999999999999999 + -1 = -1000000000000000 (Large negative numbers)

## SUBTRACTION TESTS
### Basic Functionality
- 10 - 3 = 7 (Positive - Positive)
- 3 - 10 = -7 (Positive - Positive negative result)
- -5 - -3 = -2 (Negative - Negative)
- 5 - -3 = 8 (Positive - Negative)
- -5 - 3 = -8 (Negative - Positive)
- 0 - 5 = -5 (Zero - Positive)
- 5 - 0 = 5 (Positive - Zero)
- 0 - 0 = 0 (Zero - Zero)

### Decimal/Floating Point
- 5.5 - 2.2 = 3.3 (Decimals)
- 2.2 - 5.5 = -3.3 (Decimals negative result)
- 10 - 2.5 = 7.5 (Integer - Decimal)

### Boundary Values
- 1000000000000000 - 1 = 999999999999999 (Large numbers)
- 0.0000000002 - 0.0000000001 = 0 (Very small numbers)

## MULTIPLICATION TESTS
### Basic Functionality
- 5 × 3 = 15 (Positive × Positive)
- -5 × -3 = 15 (Negative × Negative)
- 5 × -3 = -15 (Positive × Negative)
- -5 × 3 = -15 (Negative × Positive)
- 5 × 0 = 0 (Number × Zero)
- 0 × 5 = 0 (Zero × Number)
- 0 × 0 = 0 (Zero × Zero)
- 5 × 1 = 5 (Number × One)
- 5 × -1 = -5 (Number × Negative One)
- -7 × 1 = -7 (Negative × One)

### Decimal/Floating Point
- 2.5 × 4 = 10 (Decimals)
- 0.1 × 0.1 = 0.01 (Small decimals)
- 3 × 2.5 = 7.5 (Integer × Decimal)
- 1.5 × 2.5 = 3.75 (Decimals)

### Boundary Values
- 1000000 × 1000000 = 1000000000000 (Large numbers)
- 0.00001 × 0.00001 = 0 (Very small numbers)

## DIVISION TESTS
### Basic Functionality
- 10 ÷ 2 = 5 (Positive ÷ Positive)
- -10 ÷ -2 = 5 (Negative ÷ Negative)
- 10 ÷ -2 = -5 (Positive ÷ Negative)
- -10 ÷ 2 = -5 (Negative ÷ Positive)
- 0 ÷ 5 = 0 (Zero ÷ Positive)
- 0 ÷ -5 = 0 (Zero ÷ Negative)
- 5 ÷ 0 = Error: Cannot divide by zero (Division by zero)
- 0 ÷ 0 = Error: Cannot divide by zero (Zero ÷ Zero)
- 5 ÷ 1 = 5 (Number ÷ One)
- 5 ÷ -1 = -5 (Number ÷ Negative One)

### Decimal/Floating Point
- 7.5 ÷ 2.5 = 3 (Decimals)
- 10 ÷ 3 = 3.3333333333333335 (Repeating decimals)
- 1 ÷ 3 = 0.3333333333333333 (Repeating decimals)
- 15 ÷ 2.5 = 6 (Integer ÷ Decimal)
- 5.5 ÷ 2 = 2.75 (Decimal ÷ Integer)

### Boundary Values
- 1000000000000 ÷ 1000000 = 1000000 (Large ÷ Large)
- 1 ÷ 1000000000000 = 0 (Small result)
- 0.000001 ÷ 1000000 = 0 (Very small result)

## EDGE CASES & SPECIAL SCENARIOS
### Commutative Property Tests
- 7 + 13 = 20 (Addition commutative)
- 13 + 7 = 20 (Addition commutative)
- 6 × 9 = 54 (Multiplication commutative)
- 9 × 6 = 54 (Multiplication commutative)

### Non-Commutative Verification
- 10 - 3 = 7 (Subtraction order matters)
- 3 - 10 = -7 (Subtraction order matters)
- 12 ÷ 3 = 4 (Division order matters)
- 3 ÷ 12 = 0.25 (Division order matters)

### Scientific Notation
- 1e10 + 1e10 = 20000000000 (Scientific notation)
- 1e5 × 1e5 = 10000000000 (Scientific notation)
- 1.5e2 + 2.5e2 = 400 (Scientific notation decimals)

### Negative Scientific Notation
- 1e-5 + 2e-5 = 0.00003 (Negative exponent)
- 1e-3 × 1e-3 = 0.000001 (Negative exponent multiply)

### Special Number Formats
- +5 + 3 = 8 (Leading plus sign)
- 5.0 + 3.0 = 8 (Trailing zeros)
- 005 + 003 = 8 (Leading zeros)

### Mixed Sign Operations
- -2.5 × -4.5 = 11.25 (Negative decimals multiply)
- -15.5 ÷ 3.1 = -5 (Negative decimal divide)
- -8.8 - -3.3 = -5.5 (Negative decimals subtract)

### Precision Edge Cases
- 0.9999999999999999 + 0.0000000000000001 = 1 (Precision boundary add)
- 0.3333333333333333 × 3 = 0.9999999999999999 (Precision boundary multiply)
- 1 ÷ 7 = 0.14285714285714285 (Repeating decimal)
- 2 ÷ 7 = 0.2857142857142857 (Repeating decimal)

## DECIMAL PRECISION LIMIT TESTS
### ADDITION Precision Tests (1.X + 1.X = 2.X)
- 1 + 1 = 2 (0 decimals)
- 1.1 + 1.1 = 2.2 (1 decimal)
- 1.01 + 1.01 = 2.02 (2 decimals)
- 1.001 + 1.001 = 2.002 (3 decimals)
- 1.0001 + 1.0001 = 2.0002 (4 decimals)
- 1.00001 + 1.00001 = 2.00002 (5 decimals)
- 1.000001 + 1.000001 = 2.000002 (6 decimals)
- 1.0000001 + 1.0000001 = 2.0000002 (7 decimals)
- 1.00000001 + 1.00000001 = 2.00000002 (8 decimals)
- 1.000000001 + 1.000000001 = 2.000000002 (9 decimals)
- 1.0000000001 + 1.0000000001 = 2.0000000002 (10 decimals)
- 1.00000000001 + 1.00000000001 = 2.00000000002 (11 decimals)
- 1.000000000001 + 1.000000000001 = 2.000000000002 (12 decimals)
- 1.0000000000001 + 1.0000000000001 = 2.0000000000002 (13 decimals)
- 1.00000000000001 + 1.00000000000001 = 2.00000000000002 (14 decimals)
- 1.000000000000001 + 1.000000000000001 = 2.000000000000002 (15 decimals)
- 1.0000000000000001 + 1.0000000000000001 = 2.0000000000000002 (16 decimals)
- 1.00000000000000001 + 1.00000000000000001 = 2 (17 decimals)

### SUBTRACTION Precision Tests (2.X - 1.X = 1.X)
- 2 - 1 = 1 (0 decimals)
- 2.2 - 1.1 = 1.1 (1 decimal)
- 2.02 - 1.01 = 1.01 (2 decimals)
- 2.002 - 1.001 = 1.001 (3 decimals)
- 2.0002 - 1.0001 = 1.0001 (4 decimals)
- 2.00002 - 1.00001 = 1.00001 (5 decimals)
- 2.000002 - 1.000001 = 1.000001 (6 decimals)
- 2.0000002 - 1.0000001 = 1.0000001 (7 decimals)
- 2.00000002 - 1.00000001 = 1.00000001 (8 decimals)
- 2.000000002 - 1.000000001 = 1.000000001 (9 decimals)
- 2.0000000002 - 1.0000000001 = 1.0000000001 (10 decimals)
- 2.00000000002 - 1.00000000001 = 1.00000000001 (11 decimals)
- 2.000000000002 - 1.000000000001 = 1.000000000001 (12 decimals)
- 2.0000000000002 - 1.0000000000001 = 1.0000000000001 (13 decimals)
- 2.00000000000002 - 1.00000000000001 = 1.00000000000001 (14 decimals)
- 2.000000000000002 - 1.000000000000001 = 1.000000000000001 (15 decimals)
- 2.0000000000000002 - 1.0000000000000001 = 1.0000000000000001 (16 decimals)
- 2.00000000000000002 - 1.00000000000000001 = 1 (17 decimals)

### MULTIPLICATION Precision Tests (2 × 1.X = 2.X)
- 2 × 1 = 2 (0 decimals)
- 2 × 1.1 = 2.2 (1 decimal)
- 2 × 1.01 = 2.02 (2 decimals)
- 2 × 1.001 = 2.002 (3 decimals)
- 2 × 1.0001 = 2.0002 (4 decimals)
- 2 × 1.00001 = 2.00002 (5 decimals)
- 2 × 1.000001 = 2.000002 (6 decimals)
- 2 × 1.0000001 = 2.0000002 (7 decimals)
- 2 × 1.00000001 = 2.00000002 (8 decimals)
- 2 × 1.000000001 = 2.000000002 (9 decimals)
- 2 × 1.0000000001 = 2.0000000002 (10 decimals)
- 2 × 1.00000000001 = 2.00000000002 (11 decimals)
- 2 × 1.000000000001 = 2.000000000002 (12 decimals)
- 2 × 1.0000000000001 = 2.0000000000002 (13 decimals)
- 2 × 1.00000000000001 = 2.00000000000002 (14 decimals)
- 2 × 1.000000000000001 = 2.000000000000002 (15 decimals)
- 2 × 1.0000000000000001 = 2.0000000000000002 (16 decimals)
- 2 × 1.00000000000000001 = 2 (17 decimals)

### DIVISION Precision Tests (2.X ÷ 2 = 1.X)
- 2 ÷ 2 = 1 (0 decimals)
- 2.2 ÷ 2 = 1.1 (1 decimal)
- 2.02 ÷ 2 = 1.01 (2 decimals)
- 2.002 ÷ 2 = 1.001 (3 decimals)
- 2.0002 ÷ 2 = 1.0001 (4 decimals)
- 2.00002 ÷ 2 = 1.00001 (5 decimals)
- 2.000002 ÷ 2 = 1.000001 (6 decimals)
- 2.0000002 ÷ 2 = 1.0000001 (7 decimals)
- 2.00000002 ÷ 2 = 1.00000001 (8 decimals)
- 2.000000002 ÷ 2 = 1.000000001 (9 decimals)
- 2.0000000002 ÷ 2 = 1.0000000001 (10 decimals)
- 2.00000000002 ÷ 2 = 1.00000000001 (11 decimals)
- 2.000000000002 ÷ 2 = 1.000000000001 (12 decimals)
- 2.0000000000002 ÷ 2 = 1.0000000000001 (13 decimals)
- 2.00000000000002 ÷ 2 = 1.00000000000001 (14 decimals)
- 2.000000000000002 ÷ 2 = 1.000000000000001 (15 decimals)
- 2.0000000000000002 ÷ 2 = 1.0000000000000001 (16 decimals)
- 2.00000000000000002 ÷ 2 = 1 (17 decimals)

## Very Large Numbers
- 9999999999999999 + 1 = 10000000000000000 (16-digit boundary add)
- 999999999999 × 1000000 = 999999999999000000 (Large multiply)
- 999999999999999999 ÷ 999999999999999999 = 1 (Large divide equals)

## Very Small Numbers
- 1e-15 + 1e-15 = 0 (Very small add)
- 1e-8 × 1e-8 = 0 (Very small multiply)
- 1e-10 - 5e-11 = 0 (Very small subtract)
