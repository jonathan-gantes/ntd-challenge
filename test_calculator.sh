#!/bin/bash

# SDET Calculator Test Suite
# This script tests all operations of the LoanPro calculator CLI
# Usage: ./test_calculator.sh

DOCKER_IMAGE="public.ecr.aws/l4q9w4c5/loanpro-calculator-cli:latest"
RESULTS_FILE="test_results_$(date +%Y%m%d_%H%M%S).txt"
FAILED_FILE="failed_tests_$(date +%Y%m%d_%H%M%S).txt"
PASS_COUNT=0
FAIL_COUNT=0
ERROR_COUNT=0

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color



# Print to both terminal (with color) and file (no color)
log() {
    # $1: message (may contain color codes)
    # $2: message for file (plain, no color)
    echo -e "$1"
    echo -e "$2" >> "$RESULTS_FILE"
}

# Log a failed test to the failed tests file
log_failed() {
    # $1: message for file (plain, no color)
    echo -e "$1" >> "$FAILED_FILE"
}

log "========================================" "========================================"
log "Calculator Test Suite - Started at $(date)" "Calculator Test Suite - Started at $(date)"
log "========================================" "========================================"
log "" ""

# Function to run a test
run_test() {
    local operation=$1
    local num1=$2
    local num2=$3
    local expected=$4
    local test_name=$5
    

    # Print to terminal (with color), file (plain)
    echo -ne "Testing: $test_name || "
    echo -ne "Testing: $test_name || " >> "$RESULTS_FILE"
    
    # Run the calculator
    result=$(docker run --rm "$DOCKER_IMAGE" "$operation" "$num1" "$num2" 2>&1)
    exit_code=$?
    

    # Check if command failed
    if [ $exit_code -ne 0 ]; then
        if [[ "$expected" == "ERROR" ]] || [[ "$expected" == "EXCEPTION" ]]; then
            echo -e "${GREEN}PASS${NC} (Expected error occurred)"
            echo "PASS (Expected error occurred)" >> "$RESULTS_FILE"
            echo "  Expected: $expected" | tee -a "$RESULTS_FILE"
            echo "  Got:      $result" | tee -a "$RESULTS_FILE"
            ((PASS_COUNT++))
        else
            echo -e "${RED}ERROR${NC}"
            echo "ERROR" >> "$RESULTS_FILE"
            echo "  Command failed with exit code: $exit_code" >> "$RESULTS_FILE"
            echo "  Output: $result" >> "$RESULTS_FILE"
            # Log to failed file
            log_failed "Testing: $test_name... ERROR"
            log_failed "  Command failed with exit code: $exit_code"
            log_failed "  Output: $result"
            ((ERROR_COUNT++))
        fi
        return
    fi
    
    # Extract the actual result value (remove "Result: " prefix if present)
    result=$(echo "$result" | sed 's/^Result: //' | xargs)
    
    # Compare results
    if [[ "$expected" == "ERROR" ]] || [[ "$expected" == "EXCEPTION" ]]; then
        echo -e "${RED}FAIL${NC} (Expected error but got: $result)"
        echo "FAIL (Expected error but got: $result)" >> "$RESULTS_FILE"
        echo "  Expected: $expected" | tee -a "$RESULTS_FILE"
        echo "  Got:      $result" | tee -a "$RESULTS_FILE"
        # Log to failed file
        log_failed "Testing: $test_name... FAIL"
        log_failed "  Expected: $expected"
        log_failed "  Got:      $result"
        ((FAIL_COUNT++))
    elif [ "$result" = "$expected" ]; then
        echo -e "${GREEN}PASS${NC}"
        echo "PASS" >> "$RESULTS_FILE"
        echo "  Expected: $expected" | tee -a "$RESULTS_FILE"
        echo "  Got:      $result" | tee -a "$RESULTS_FILE"
        ((PASS_COUNT++))
    else
        echo -e "${RED}FAIL${NC}"
        echo "FAIL" >> "$RESULTS_FILE"
        echo "  Expected: $expected" | tee -a "$RESULTS_FILE"
        echo "  Got:      $result" | tee -a "$RESULTS_FILE"
        # Log to failed file
        log_failed "Testing: $test_name... FAIL"
        log_failed "  Expected: $expected"
        log_failed "  Got:      $result"
        ((FAIL_COUNT++))
    fi
}

# Function to run a test expecting an error/exception
run_error_test() {
    local operation=$1
    local num1=$2
    local num2=$3
    local test_name=$4
    
    run_test "$operation" "$num1" "$num2" "EXCEPTION" "$test_name"
}


log "${BLUE}=== ADDITION TESTS ===${NC}" "=== ADDITION TESTS ==="
log "" ""

log "Basic Functionality:" "Basic Functionality:"
run_test "add" "5" "3" "8" "Positive + Positive (5 + 3)"
run_test "add" "-5" "-3" "-8" "Negative + Negative (-5 + -3)"
run_test "add" "5" "-3" "2" "Positive + Negative (5 + -3)"
run_test "add" "-5" "3" "-2" "Negative + Positive (-5 + 3)"
run_test "add" "0" "5" "5" "Zero + Positive (0 + 5)"
run_test "add" "0" "-5" "-5" "Zero + Negative (0 + -5)"
run_test "add" "0" "0" "0" "Zero + Zero (0 + 0)"

log "" ""
log "Decimal/Floating Point:" "Decimal/Floating Point:"
run_test "add" "1.5" "2.5" "4" "Decimals (1.5 + 2.5)"
run_test "add" "0.1" "0.2" "0.3" "Small decimals (0.1 + 0.2)"
run_test "add" "5" "2.5" "7.5" "Integer + Decimal (5 + 2.5)"
run_test "add" "1.1" "2.2" "3.3" "Decimals (1.1 + 2.2)"

log "" ""
log "Boundary Values:" "Boundary Values:"
run_test "add" "999999999999999" "1" "1000000000000000" "Large numbers"
run_test "add" "0.0000000001" "0.0000000002" "0" "Very small numbers"
run_test "add" "-999999999999999" "-1" "-1000000000000000" "Large negative numbers"



log "" ""
log "${BLUE}=== SUBTRACTION TESTS ===${NC}" "=== SUBTRACTION TESTS ==="
log "" ""

log "Basic Functionality:" "Basic Functionality:"
run_test "subtract" "10" "3" "7" "Positive - Positive (10 - 3)"
run_test "subtract" "3" "10" "-7" "Positive - Positive negative result (3 - 10)"
run_test "subtract" "-5" "-3" "-2" "Negative - Negative (-5 - -3)"
run_test "subtract" "5" "-3" "8" "Positive - Negative (5 - -3)"
run_test "subtract" "-5" "3" "-8" "Negative - Positive (-5 - 3)"
run_test "subtract" "0" "5" "-5" "Zero - Positive (0 - 5)"
run_test "subtract" "5" "0" "5" "Positive - Zero (5 - 0)"
run_test "subtract" "0" "0" "0" "Zero - Zero (0 - 0)"

log "" ""
log "Decimal/Floating Point:" "Decimal/Floating Point:"
run_test "subtract" "5.5" "2.2" "3.3" "Decimals (5.5 - 2.2)"
run_test "subtract" "2.2" "5.5" "-3.3" "Decimals negative result (2.2 - 5.5)"
run_test "subtract" "10" "2.5" "7.5" "Integer - Decimal (10 - 2.5)"

log "" ""
log "Boundary Values:" "Boundary Values:"
run_test "subtract" "1000000000000000" "1" "999999999999999" "Large numbers"
run_test "subtract" "0.0000000002" "0.0000000001" "0" "Very small numbers"



log "" ""
log "${BLUE}=== MULTIPLICATION TESTS ===${NC}" "=== MULTIPLICATION TESTS ==="
log "" ""

log "Basic Functionality:" "Basic Functionality:"
run_test "multiply" "5" "3" "15" "Positive × Positive (5 × 3)"
run_test "multiply" "-5" "-3" "15" "Negative × Negative (-5 × -3)"
run_test "multiply" "5" "-3" "-15" "Positive × Negative (5 × -3)"
run_test "multiply" "-5" "3" "-15" "Negative × Positive (-5 × 3)"
run_test "multiply" "5" "0" "0" "Number × Zero (5 × 0)"
run_test "multiply" "0" "5" "0" "Zero × Number (0 × 5)"
run_test "multiply" "0" "0" "0" "Zero × Zero (0 × 0)"
run_test "multiply" "5" "1" "5" "Number × One (5 × 1)"
run_test "multiply" "5" "-1" "-5" "Number × Negative One (5 × -1)"
run_test "multiply" "-7" "1" "-7" "Negative × One (-7 × 1)"

log "" ""
log "Decimal/Floating Point:" "Decimal/Floating Point:"
run_test "multiply" "2.5" "4" "10" "Decimals (2.5 × 4)"
run_test "multiply" "0.1" "0.1" "0.01" "Small decimals (0.1 × 0.1)"
run_test "multiply" "3" "2.5" "7.5" "Integer × Decimal (3 × 2.5)"
run_test "multiply" "1.5" "2.5" "3.75" "Decimals (1.5 × 2.5)"

log "" ""
log "Boundary Values:" "Boundary Values:"
run_test "multiply" "1000000" "1000000" "1000000000000" "Large numbers"
run_test "multiply" "0.00001" "0.00001" "0" "Very small numbers"



log "" ""
log "${BLUE}=== DIVISION TESTS ===${NC}" "=== DIVISION TESTS ==="
log "" ""

log "Basic Functionality:" "Basic Functionality:"
run_test "divide" "10" "2" "5" "Positive ÷ Positive (10 ÷ 2)"
run_test "divide" "-10" "-2" "5" "Negative ÷ Negative (-10 ÷ -2)"
run_test "divide" "10" "-2" "-5" "Positive ÷ Negative (10 ÷ -2)"
run_test "divide" "-10" "2" "-5" "Negative ÷ Positive (-10 ÷ 2)"
run_test "divide" "0" "5" "0" "Zero ÷ Positive (0 ÷ 5)"
run_test "divide" "0" "-5" "0" "Zero ÷ Negative (0 ÷ -5)"
run_test "divide" "5" "0" "Error: Cannot divide by zero" "Division by zero (5 ÷ 0) - Error Message Check"
run_test "divide" "0" "0" "Error: Cannot divide by zero" "Zero ÷ Zero (0 ÷ 0) - Error Message Check"
run_test "divide" "5" "1" "5" "Number ÷ One (5 ÷ 1)"
run_test "divide" "5" "-1" "-5" "Number ÷ Negative One (5 ÷ -1)"

log "" ""
log "Decimal/Floating Point:" "Decimal/Floating Point:"
run_test "divide" "7.5" "2.5" "3" "Decimals (7.5 ÷ 2.5)"
run_test "divide" "10" "3" "3.3333333333333335" "Repeating decimals (10 ÷ 3)"
run_test "divide" "1" "3" "0.3333333333333333" "Repeating decimals (1 ÷ 3)"
run_test "divide" "15" "2.5" "6" "Integer ÷ Decimal (15 ÷ 2.5)"
run_test "divide" "5.5" "2" "2.75" "Decimal ÷ Integer (5.5 ÷ 2)"

log "" ""
log "Boundary Values:" "Boundary Values:"
run_test "divide" "1000000000000" "1000000" "1000000" "Large ÷ Large"
run_test "divide" "1" "1000000000000" "0" "Small result (1 ÷ large)"
run_test "divide" "0.000001" "1000000" "0" "Very small result"



log "" ""
log "${BLUE}=== EDGE CASES & SPECIAL SCENARIOS ===${NC}" "=== EDGE CASES & SPECIAL SCENARIOS ==="
log "" ""

log "Commutative Property Tests:" "Commutative Property Tests:"
run_test "add" "7" "13" "20" "Addition commutative (7 + 13)"
run_test "add" "13" "7" "20" "Addition commutative (13 + 7)"
run_test "multiply" "6" "9" "54" "Multiplication commutative (6 × 9)"
run_test "multiply" "9" "6" "54" "Multiplication commutative (9 × 6)"

log "" ""
log "Non-Commutative Verification:" "Non-Commutative Verification:"
run_test "subtract" "10" "3" "7" "Subtraction order matters (10 - 3)"
run_test "subtract" "3" "10" "-7" "Subtraction order matters (3 - 10)"
run_test "divide" "12" "3" "4" "Division order matters (12 ÷ 3)"
run_test "divide" "3" "12" "0.25" "Division order matters (3 ÷ 12)"

log "" ""
log "Scientific Notation:" "Scientific Notation:"
run_test "add" "1e10" "1e10" "20000000000" "Scientific notation (1e10 + 1e10)"
run_test "multiply" "1e5" "1e5" "10000000000" "Scientific notation (1e5 × 1e5)"
run_test "add" "1.5e2" "2.5e2" "400" "Scientific notation decimals"

log "" ""
log "Negative Scientific Notation:" "Negative Scientific Notation:"
run_test "add" "1e-5" "2e-5" "0.00003" "Negative exponent (1e-5 + 2e-5)"
run_test "multiply" "1e-3" "1e-3" "0.000001" "Negative exponent multiply"

log "" ""
log "Special Number Formats:" "Special Number Formats:"
run_test "add" "+5" "3" "8" "Leading plus sign (+5 + 3)"
run_test "add" "5.0" "3.0" "8" "Trailing zeros (5.0 + 3.0)"
run_test "add" "005" "003" "8" "Leading zeros (005 + 003)"

log "" ""
log "Mixed Sign Operations:" "Mixed Sign Operations:"
run_test "multiply" "-2.5" "-4.5" "11.25" "Negative decimals multiply"
run_test "divide" "-15.5" "3.1" "-5" "Negative decimal divide"
run_test "subtract" "-8.8" "-3.3" "-5.5" "Negative decimals subtract"

log "" ""
log "Precision Edge Cases:" "Precision Edge Cases:"
run_test "add" "0.9999999999999999" "0.0000000000000001" "1" "Precision boundary add (0.9999999999999999 + 0.0000000000000001)"
run_test "multiply" "0.3333333333333333" "3" "0.9999999999999999" "Precision boundary multiply (0.3333333333333333 × 3)"
run_test "divide" "1" "7" "0.14285714285714285" "Repeating decimal (1 ÷ 7)"
run_test "divide" "2" "7" "0.2857142857142857" "Repeating decimal (2 ÷ 7)"


log "" ""
log "${BLUE}=== DECIMAL PRECISION LIMIT TESTS ===${NC}" "=== DECIMAL PRECISION LIMIT TESTS ==="
log "Testing precision from 0 to 20 decimal places for each operation" "Testing precision from 0 to 20 decimal places for each operation"
log "" ""

log "ADDITION Precision Tests (1.X + 1.X = 2.X):" "ADDITION Precision Tests (1.X + 1.X = 2.X):"
run_test "add" "1" "1" "2" "0 decimals: 1 + 1"
run_test "add" "1.1" "1.1" "2.2" "1 decimal: 1.1 + 1.1"
run_test "add" "1.01" "1.01" "2.02" "2 decimals: 1.01 + 1.01"
run_test "add" "1.001" "1.001" "2.002" "3 decimals: 1.001 + 1.001"
run_test "add" "1.0001" "1.0001" "2.0002" "4 decimals: 1.0001 + 1.0001"
run_test "add" "1.00001" "1.00001" "2.00002" "5 decimals: 1.00001 + 1.00001"
run_test "add" "1.000001" "1.000001" "2.000002" "6 decimals: 1.000001 + 1.000001"
run_test "add" "1.0000001" "1.0000001" "2.0000002" "7 decimals: 1.0000001 + 1.0000001"
run_test "add" "1.00000001" "1.00000001" "2.00000002" "8 decimals: 1.00000001 + 1.00000001"
run_test "add" "1.000000001" "1.000000001" "2.000000002" "9 decimals: 1.000000001 + 1.000000001"
run_test "add" "1.0000000001" "1.0000000001" "2.0000000002" "10 decimals: 1.0000000001 + 1.0000000001"
run_test "add" "1.00000000001" "1.00000000001" "2.00000000002" "11 decimals: 1.00000000001 + 1.00000000001"
run_test "add" "1.000000000001" "1.000000000001" "2.000000000002" "12 decimals: 1.000000000001 + 1.000000000001"
run_test "add" "1.0000000000001" "1.0000000000001" "2.0000000000002" "13 decimals: 1.0000000000001 + 1.0000000000001"
run_test "add" "1.00000000000001" "1.00000000000001" "2.00000000000002" "14 decimals: 1.00000000000001 + 1.00000000000001"
run_test "add" "1.000000000000001" "1.000000000000001" "2.000000000000002" "15 decimals: 1.000000000000001 + 1.000000000000001"
run_test "add" "1.0000000000000001" "1.0000000000000001" "2.0000000000000002" "16 decimals: 1.0000000000000001 + 1.0000000000000001"
run_test "add" "1.00000000000000001" "1.00000000000000001" "2" "17 decimals: 1.00000000000000001 + 1.00000000000000001"

log "" ""
log "SUBTRACTION Precision Tests (2.X - 1.X = 1.X):" "SUBTRACTION Precision Tests (2.X - 1.X = 1.X):"
run_test "subtract" "2" "1" "1" "0 decimals: 2 - 1"
run_test "subtract" "2.2" "1.1" "1.1" "1 decimal: 2.2 - 1.1"
run_test "subtract" "2.02" "1.01" "1.01" "2 decimals: 2.02 - 1.01"
run_test "subtract" "2.002" "1.001" "1.001" "3 decimals: 2.002 - 1.001"
run_test "subtract" "2.0002" "1.0001" "1.0001" "4 decimals: 2.0002 - 1.0001"
run_test "subtract" "2.00002" "1.00001" "1.00001" "5 decimals: 2.00002 - 1.00001"
run_test "subtract" "2.000002" "1.000001" "1.000001" "6 decimals: 2.000002 - 1.000001"
run_test "subtract" "2.0000002" "1.0000001" "1.0000001" "7 decimals: 2.0000002 - 1.0000001"
run_test "subtract" "2.00000002" "1.00000001" "1.00000001" "8 decimals: 2.00000002 - 1.00000001"
run_test "subtract" "2.000000002" "1.000000001" "1.000000001" "9 decimals: 2.000000002 - 1.000000001"
run_test "subtract" "2.0000000002" "1.0000000001" "1.0000000001" "10 decimals: 2.0000000002 - 1.0000000001"
run_test "subtract" "2.00000000002" "1.00000000001" "1.00000000001" "11 decimals: 2.00000000002 - 1.00000000001"
run_test "subtract" "2.000000000002" "1.000000000001" "1.000000000001" "12 decimals: 2.000000000002 - 1.000000000001"
run_test "subtract" "2.0000000000002" "1.0000000000001" "1.0000000000001" "13 decimals: 2.0000000000002 - 1.0000000000001"
run_test "subtract" "2.00000000000002" "1.00000000000001" "1.00000000000001" "14 decimals: 2.00000000000002 - 1.00000000000001"
run_test "subtract" "2.000000000000002" "1.000000000000001" "1.000000000000001" "15 decimals: 2.000000000000002 - 1.000000000000001"
run_test "subtract" "2.0000000000000002" "1.0000000000000001" "1.0000000000000001" "16 decimals: 2.0000000000000002 - 1.0000000000000001"
run_test "subtract" "2.00000000000000002" "1.00000000000000001" "1" "17 decimals: 2.00000000000000002 - 1.00000000000000001"

log "" ""
log "MULTIPLICATION Precision Tests (2 × 1.X = 2.X):" "MULTIPLICATION Precision Tests (2 × 1.X = 2.X):"
run_test "multiply" "2" "1" "2" "0 decimals: 2 × 1"
run_test "multiply" "2" "1.1" "2.2" "1 decimal: 2 × 1.1"
run_test "multiply" "2" "1.01" "2.02" "2 decimals: 2 × 1.01"
run_test "multiply" "2" "1.001" "2.002" "3 decimals: 2 × 1.001"
run_test "multiply" "2" "1.0001" "2.0002" "4 decimals: 2 × 1.0001"
run_test "multiply" "2" "1.00001" "2.00002" "5 decimals: 2 × 1.00001"
run_test "multiply" "2" "1.000001" "2.000002" "6 decimals: 2 × 1.000001"
run_test "multiply" "2" "1.0000001" "2.0000002" "7 decimals: 2 × 1.0000001"
run_test "multiply" "2" "1.00000001" "2.00000002" "8 decimals: 2 × 1.00000001"
run_test "multiply" "2" "1.000000001" "2.000000002" "9 decimals: 2 × 1.000000001"
run_test "multiply" "2" "1.0000000001" "2.0000000002" "10 decimals: 2 × 1.0000000001"
run_test "multiply" "2" "1.00000000001" "2.00000000002" "11 decimals: 2 × 1.00000000001"
run_test "multiply" "2" "1.000000000001" "2.000000000002" "12 decimals: 2 × 1.000000000001"
run_test "multiply" "2" "1.0000000000001" "2.0000000000002" "13 decimals: 2 × 1.0000000000001"
run_test "multiply" "2" "1.00000000000001" "2.00000000000002" "14 decimals: 2 × 1.00000000000001"
run_test "multiply" "2" "1.000000000000001" "2.000000000000002" "15 decimals: 2 × 1.000000000000001"
run_test "multiply" "2" "1.0000000000000001" "2.0000000000000002" "16 decimals: 2 × 1.0000000000000001"
run_test "multiply" "2" "1.00000000000000001" "2" "17 decimals: 2 × 1.00000000000000001"


log "" ""
log "DIVISION Precision Tests (2.X ÷ 2 = 1.X):" "DIVISION Precision Tests (2.X ÷ 2 = 1.X):"
run_test "divide" "2" "2" "1" "0 decimals: 2 ÷ 2"
run_test "divide" "2.2" "2" "1.1" "1 decimal: 2.2 ÷ 2"
run_test "divide" "2.02" "2" "1.01" "2 decimals: 2.02 ÷ 2"
run_test "divide" "2.002" "2" "1.001" "3 decimals: 2.002 ÷ 2"
run_test "divide" "2.0002" "2" "1.0001" "4 decimals: 2.0002 ÷ 2"
run_test "divide" "2.00002" "2" "1.00001" "5 decimals: 2.00002 ÷ 2"
run_test "divide" "2.000002" "2" "1.000001" "6 decimals: 2.000002 ÷ 2"
run_test "divide" "2.0000002" "2" "1.0000001" "7 decimals: 2.0000002 ÷ 2"
run_test "divide" "2.00000002" "2" "1.00000001" "8 decimals: 2.00000002 ÷ 2"
run_test "divide" "2.000000002" "2" "1.000000001" "9 decimals: 2.000000002 ÷ 2"
run_test "divide" "2.0000000002" "2" "1.0000000001" "10 decimals: 2.0000000002 ÷ 2"
run_test "divide" "2.00000000002" "2" "1.00000000001" "11 decimals: 2.00000000002 ÷ 2"
run_test "divide" "2.000000000002" "2" "1.000000000001" "12 decimals: 2.000000000002 ÷ 2"
run_test "divide" "2.0000000000002" "2" "1.0000000000001" "13 decimals: 2.0000000000002 ÷ 2"
run_test "divide" "2.00000000000002" "2" "1.00000000000001" "14 decimals: 2.00000000000002 ÷ 2"
run_test "divide" "2.000000000000002" "2" "1.000000000000001" "15 decimals: 2.000000000000002 ÷ 2"
run_test "divide" "2.0000000000000002" "2" "1.0000000000000001" "16 decimals: 2.0000000000000002 ÷ 2"
run_test "divide" "2.00000000000000002" "2" "1" "17 decimals: 2.00000000000000002 ÷ 2"

log "" ""
log "Very Large Numbers:" "Very Large Numbers:"
run_test "add" "9999999999999999" "1" "10000000000000000" "16-digit boundary add"
run_test "multiply" "999999999999" "1000000" "999999999999000000" "Large multiply"
run_test "divide" "999999999999999999" "999999999999999999" "1" "Large divide equals"

log "" ""
log "Very Small Numbers:" "Very Small Numbers:"
run_test "add" "1e-15" "1e-15" "0" "Very small add"
run_test "multiply" "1e-8" "1e-8" "0" "Very small multiply"
run_test "subtract" "1e-10" "5e-11" "0" "Very small subtract"


log "" ""
log "${BLUE}=== SUMMARY ===${NC}" "=== SUMMARY ==="
log "========================================" "========================================"
log "${GREEN}Passed: $PASS_COUNT${NC}" "Passed: $PASS_COUNT"
log "${RED}Failed: $FAIL_COUNT${NC}" "Failed: $FAIL_COUNT"
log "${YELLOW}Errors: $ERROR_COUNT${NC}" "Errors: $ERROR_COUNT"
log "Total:  $((PASS_COUNT + FAIL_COUNT + ERROR_COUNT))" "Total:  $((PASS_COUNT + FAIL_COUNT + ERROR_COUNT))"
log "========================================" "========================================"
log "" ""
log "Test completed at $(date)" "Test completed at $(date)"
log "Results saved to: $RESULTS_FILE" "Results saved to: $RESULTS_FILE"

# Exit with failure if any tests failed
if [ $FAIL_COUNT -gt 0 ] || [ $ERROR_COUNT -gt 0 ]; then
    exit 1
else
    exit 0
fi