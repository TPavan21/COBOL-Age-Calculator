# COBOL-Age-Calculator
A structured IBM Mainframe-compatible COBOL program that accepts a date of birth and calculates exact age in years, months, and days using system date processing and borrow logic.
# IBM Mainframe COBOL: Exact Age Calculator

A robust, enterprise-ready COBOL batch processing program designed to calculate an individual's exact age in **Years, Months, and Days** by processing a user-provided Date of Birth (DOB) against the current system date. 

The application implements standard IBM Mainframe programming principles, including comprehensive date validation rules and logical date-arithmetic handling for calendar boundary conditions.

---

## ⚙️ Core Logic & Architecture
Calculating chronological age requires processing calendar dates from right to left: **Days ➔ Months ➔ Years**. The program accurately addresses boundary conditions where the current day or month components are numerically smaller than the birth day or month components.

### 1. Day Math & Borrow Logic
If the current calendar day is less than the birth day, a direct subtraction would yield a negative value. The application resolves this by borrowing from the previous month:
* Decrements the current month counter by `1`.
* Dynamically adds the appropriate number of days (based on the specific month configuration) to the current day counter before executing the subtraction.

$$\text{Calculated Days} = (\text{Current Day} + \text{Borrowed Days}) - \text{Birth Day}$$

### 2. Month Math & Borrow Logic
Similarly, if the adjusted current month is numerically less than the birth month (indicating the individual has not yet reached their birthday in the current calendar year), the program borrows from the year:
* Decrements the current year counter by `1`.
* Adds `12` months to the current month counter.

$$\text{Calculated Months} = (\text{Current Month} + 12) - \text{Birth Month}$$

### 3. Year Math Logic
The final age in years is determined by subtracting the birth year from the adjusted current year component.

$$\text{Calculated Years} = \text{Adjusted Current Year} - \text{Birth Year}$$

---

## 🛠️ Technical Specifications & Structure

### Division Breakdown
* **IDENTIFICATION DIVISION:** Establishes program metadata, author tracking, and compilation details.
* **ENVIRONMENT DIVISION:** Configures standard configuration handles for standard input/output streaming.
* **DATA DIVISION:** * `WORKING-STORAGE SECTION`: Manages data definitions using strict formatting.
  * Implements structured group items for Date processing (`YYYYMMDD` formats).
  * Uses binary/numeric picture clauses (`PIC 9`) to ensure optimal storage allocation during mathematical processing.
* **PROCEDURE DIVISION:** Governs execution flow, containing modular paragraphs for data acceptance, validation, calculation, and output display.

### Key Mainframe Commands Utilized
* `ACCEPT ... FROM DATE YYYYMMDD`: Dynamically queries the operating system terminal to fetch the real-time calendar date, ensuring calculations are always relative to the execution day.
* `EVALUATE`: Used instead of nested `IF` statements to handle date validation rules and condition paths cleanly.
* `DISPLAY`: Outputs the structured final payload to the standard output console.

---

## 🚀 Compilation & Local Execution

While designed for IBM Mainframe compiler compatibility, this program can be compiled and executed locally using open-source utilities like **GnuCOBOL**.



### Prerequisites
Ensure a COBOL compiler is active in your environment path:
```bash
# Check compiler version
cobc --version
