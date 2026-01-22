# LoanPro Calculator CLI Test Suite

**Recruiter Note:**
To review my responses and a summary of the test results, please see the [failing_tests_summary.md](failing_tests_summary.md) file in this repository.

This project provides a comprehensive test suite for the LoanPro calculator CLI, executed via Docker.

## Requirements
- Docker installed and running
- Internet access to pull the Docker image

## Setup
1. **Install Docker**
   - **Ubuntu/Linux:**
     ```sh
     sudo apt-get update
     sudo apt-get install docker.io
     ```
   - **Mac (Homebrew):**
     ```sh
     brew install --cask docker
     ```
   - For other platforms, see: [Docker Install Guide](https://docs.docker.com/get-docker/)

2. **Pull the LoanPro Calculator CLI Docker image:**
   ```sh
   docker pull public.ecr.aws/l4q9w4c5/loanpro-calculator-cli:latest
   ```

## Running the Tests
1. **Make the test script executable (if needed):**
   ```sh
   chmod +x test_calculator.sh
   ```
2. **Run the test suite:**
   ```sh
   ./test_calculator.sh
   ```
   - Results are saved as `test_results_<timestamp>.txt`.
   - Failed tests are logged in `failed_tests_<timestamp>.txt`.

## Interpreting Results
- The script prints a summary of passed, failed, and error tests.
- See the generated results files for detailed output.

## Troubleshooting
- Ensure Docker is running: `sudo systemctl start docker` (Linux)
- For permission issues, try running with `sudo` or add your user to the `docker` group.
- If the image fails to pull, check your internet connection or Docker configuration.

---
For questions or issues, contact the project maintainer.
