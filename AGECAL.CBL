       IDENTIFICATION DIVISION.
       PROGRAM-ID. AGECAL01.
       AUTHOR. PAVAN.
      *-----------------------------
       DATA DIVISION.
       WORKING-STORAGE SECTION.
         01 WS-ACCEPT-DATE.
           02 WS-A-YEAR PIC 9(4).
              88 Y1 VALUE 1950 THRU 2024.
           02 WS-A-MONTH PIC 9(2).
              88 M1 VALUES ARE 1, 3, 5, 7, 8, 10, 12.
              88 M2 VALUES ARE 4, 6, 9, 11.
              88 M3 VALUE 2.
           02 WS-A-DAY PIC 9(2).
               88 D1 VALUE 1 THRU 31.
               88 D2 VALUE 1 THRU 30.
               88 D3 VALUE 1 THRU 28.
               88 D4 VALUE 29.
         01 WS-CURRENT-DATE.
           02 WS-C-YEAR PIC 9(4).
           02 WS-C-MONTH PIC 9(2).
           02 WS-C-DAY PIC 9(2).
         01 WS-RESULT.
           02 WS-R-YEAR PIC 9(4).
           02 WS-R-MONTH PIC 9(2).
           02 WS-R-DAY PIC 9(2).
      *-----------------------------
       PROCEDURE DIVISION.
           ACCEPT WS-CURRENT-DATE FROM DATE YYYYMMDD.
           ACCEPT WS-ACCEPT-DATE.
           DISPLAY '-------------------------------------'
           DISPLAY "           AGE CALCULATOR            "
           DISPLAY '-------------------------------------'
           
           DISPLAY "CURRENT DATE: " WS-C-YEAR "/" WS-C-MONTH "/" 
                          WS-C-DAY.
           DISPLAY "ACCEPTED DATE: " WS-A-YEAR "/" WS-A-MONTH "/" 
                          WS-A-DAY.
          
             IF Y1
               IF M1
                 IF D1
                    DISPLAY "VALID DATE"
                    PERFORM CALCULATE-AGE
                 ELSE
                    DISPLAY "INVALID DATE"
                    DISPLAY "DATES ARE NOT IN RANGE(1-31)"
                 END-IF
               ELSE IF M2
                 IF D2
                    DISPLAY "VALID DATE"
                    PERFORM CALCULATE-AGE
                 ELSE
                    DISPLAY "INVALID DATE"
                    DISPLAY "DATES ARE NOT IN RANGE(1-30)"
                  END-IF
               ELSE IF M3
                 IF D3
                    DISPLAY "VALID DATE"
                    PERFORM CALCULATE-AGE
                 ELSE IF D4
                   IF WS-A-YEAR / 4 = 0 AND WS-A-YEAR / 100 NOT = 0
                                         OR  WS-A-YEAR / 400 = 0
                       DISPLAY "VALID DATE"

                       PERFORM CALCULATE-AGE
                    ELSE
                       DISPLAY "INVALID DATE"
                       DISPLAY "DATES ARE NOT IN RANGE(1-28)/(1-29)"
                   END-IF
                 END-IF
                 END-IF
                ELSE
                 DISPLAY "INVALID MONTH"
                 DISPLAY "MONTHS ARE NOT IN RANGE(1-12)"
               END-IF
              END-IF
              END-IF
           ELSE
              DISPLAY "INVALID YEAR"
              DISPLAY "YEAR IS NOT IN RANGE(1950-2026)"
           END-IF.
           STOP RUN.
       CALCULATE-AGE.
           IF  WS-C-DAY >= WS-A-DAY
               COMPUTE WS-R-DAY = WS-C-DAY - WS-A-DAY
           ELSE
               COMPUTE WS-R-DAY = WS-C-DAY + 30 - WS-A-DAY
               SUBTRACT 1 FROM WS-C-MONTH
           END-IF.
             IF WS-C-MONTH >= WS-A-MONTH
                COMPUTE WS-R-MONTH = WS-C-MONTH - WS-A-MONTH
             ELSE
                COMPUTE WS-R-MONTH = WS-C-MONTH + 12 - WS-A-MONTH
                SUBTRACT 1 FROM WS-C-YEAR
             END-IF.

           COMPUTE WS-R-YEAR = WS-C-YEAR - WS-A-YEAR.
      * DIFFERENCE IN YEARS, MONTHS AND DAYS
           DISPLAY '-------------------------------------'.
           DISPLAY "AGE: "
           DISPLAY  WS-R-YEAR " YEARS ".
           DISPLAY  WS-R-MONTH " MONTHS ".
           DISPLAY  WS-R-DAY " DAYS".
           DISPLAY '-------------------------------------'.
