      * CSCI3180 Principles of Programming Languages
      *
      * --- Declaration ---
      *
      * I declare that the assignment here submitted is original except
      * for source material explicitly acknowledged. I also acknowledge
      * that I am aware of University policy and regulations on honesty
      * in academic work, and of the disciplinary guidelines and
      * procedures applicable to breaches of such policy and 
      * regulations, as contained in the website
      * http://www.cuhk.edu.hk/policy/academichonesty/
      *
      * Assignment 1
      * Name : Chao Yu
      * Student ID : 1155053722
      * Email Addr : ychao5@cse.cuhk.edu.hk

       IDENTIFICATION DIVISION. 
       PROGRAM-ID. TA-RANKING.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INST-FILE ASSIGN TO DISK
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS INST-STATUS.
           SELECT CAND-FILE ASSIGN TO DISK
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS CAND-STATUS.
           SELECT OUTPUT-FILE ASSIGN TO DISK
               ORGANIZATION IS BINARY SEQUENTIAL
               FILE STATUS IS OUTPUT-STATUS.
       
       DATA DIVISION.
       FILE SECTION.
       FD INST-FILE
           LABEL RECORD IS STANDARD
           DATA RECORD IS INST-TABLE
           VALUE OF FILE-ID IS "instructors.txt".
       01 INST-TABLE.
           05 CRS-ID PIC 9(4).
           05 SPACER PIC A(1).
           05 REQ-SKILLS PIC A(15) OCCURS 3 TIMES.
           05 OPT-SKILLS PIC A(15) OCCURS 5 TIMES.

       FD CAND-FILE
           LABEL RECORD IS STANDARD
           DATA RECORD IS CAND-TABLE
           VALUE OF FILE-ID IS "candidates.txt".
       01 CAND-TABLE.
           05 STD-ID PIC 9(10).
           05 SPACER1 PIC A(1).
           05 SKILLS PIC A(15) OCCURS 8 TIMES.
           05 COURSE1 PIC 9(4).
           05 SPACER2 PIC A(1).
           05 COURSE2 PIC 9(4).
           05 SPACER3 PIC A(1).
           05 COURSE3 PIC 9(4).
           05 SPACER4 PIC A(1).

       FD OUTPUT-FILE
           LABEL RECORD IS STANDARD
           DATA RECORD IS OUTPUT-TABLE
           VALUE OF FILE-ID IS "output.txt".
       01 OUTPUT-TABLE.
           05 O-CRS-ID PIC 9(4).
           05 O-SPACE1 PIC A.
           05 O-CAND1 PIC 9(10).
           05 O-SPACE2 PIC A.
           05 O-CAND2 PIC 9(10).
           05 O-SPACE3 PIC A.
           05 O-CAND3 PIC 9(10).
           05 O-SPACE4 PIC A.
           05 O-RETURN PIC X.

       WORKING-STORAGE SECTION.
       01 INST-STATUS PIC XX.
       01 CAND-STATUS PIC XX.
       01 OUTPUT-STATUS PIC XX.
       01 I PIC 9.
       01 END-I PIC 9.
       01 J PIC 9.
       01 END-J PIC 9.
       01 TOP-THREE-RECORD.
           05 TOP-THREE-CAND PIC 9(10) VALUE 0000000000 OCCURS 3 TIMES.
           05 TOP-THREE-SCORES PIC 9V9 VALUE 0.5 OCCURS 3 TIMES.
       01 CURR-SCORE PIC 9V9.
       01 EOF-INST PIC 9 VALUE 0.
       01 EOF-CAND PIC 9.
       01 SKILL-SATISFIED PIC 9.
       01 SKILL-SCORE PIC 9V9.
       01 PREF-SCORE PIC 9V9.
       01 TOP-THREE-UPDATED PIC 9.
       01 TMP PIC 9.
       
       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
           PERFORM OPEN-FILES.
           PERFORM COURSE-LOOP.
           PERFORM CLOSE-FILES.
           STOP RUN.

       OPEN-FILES.
           OPEN INPUT INST-FILE.
           IF (INST-STATUS NOT EQUAL 00)
               GO TO FILE-ERROR.

           OPEN OUTPUT OUTPUT-FILE.
           IF (OUTPUT-STATUS NOT EQUAL 00)
               GO TO FILE-ERROR.
       
       OPEN-CAND-FILE.
           OPEN INPUT CAND-FILE.
           IF (CAND-STATUS NOT EQUAL 00)
               GO TO FILE-ERROR.

       CLOSE-FILES.
           CLOSE INST-FILE.
           CLOSE OUTPUT-FILE.
       
       FILE-ERROR.
           DISPLAY "non-existing file!".
           STOP RUN.

      * Looping through the instructors list line by line.   
       COURSE-LOOP.
           READ INST-FILE AT END MOVE 1 TO EOF-INST.
           IF (EOF-INST EQUAL 0)
               PERFORM OPEN-CAND-FILE
               PERFORM RESET-TOP-THREE
               MOVE 0 TO EOF-CAND
               PERFORM CANDIDATE-LOOP
               PERFORM PRINT-TOP-THREE
               CLOSE CAND-FILE
               GO TO COURSE-LOOP.

      * Loop through each candidate to obtain the score for the course.
       CANDIDATE-LOOP.
           READ CAND-FILE AT END MOVE 1 TO EOF-CAND.
           IF (EOF-CAND EQUAL 0)
               PERFORM CALC-SCORE
               PERFORM UPDATE-TOP-THREE
               GO TO CANDIDATE-LOOP.    

      * Reset the top three arrays to their initial values. 
       RESET-TOP-THREE.
           MOVE 4 TO END-I.
           MOVE 1 TO I.
           PERFORM RESET-TOP-THREE-LOOP.

       RESET-TOP-THREE-LOOP.
           MOVE 0000000000 TO TOP-THREE-CAND(I).
           MOVE 0.5 TO TOP-THREE-SCORES(I).
           ADD 1 TO I.
           IF (I < END-I)
           GO TO RESET-TOP-THREE-LOOP.

      * Calculate the score for the current candidate and course.
       CALC-SCORE.
           MOVE 0.0 TO CURR-SCORE.
           MOVE 0 TO SKILL-SATISFIED.
           MOVE 1 TO I.
           MOVE 4 TO END-I.
           PERFORM COUNT-SAT-LOOP1.

      *    All three requied skills are satisfied.
           IF (SKILL-SATISFIED EQUAL 3)
               MOVE 0.0 TO SKILL-SCORE
               MOVE 0.0 TO PREF-SCORE
               PERFORM CALC-SKILL-SCORE
               PERFORM CALC-PREF-SCORE
               ADD SKILL-SCORE PREF-SCORE TO CURR-SCORE
               ADD 1.0 TO CURR-SCORE.

      * Nested loop to compare the skills btwn candidate and the course
      * to count the satisfied required skills.
       COUNT-SAT-LOOP1.
           MOVE 1 TO J.
           MOVE 9 TO END-J.
           PERFORM COUNT-SAT-LOOP2.
           ADD 1 TO I.
           IF (I < END-I)
           GO TO COUNT-SAT-LOOP1.

       COUNT-SAT-LOOP2.
           IF (REQ-SKILLS(I) EQUAL SKILLS(J))
               ADD 1 TO SKILL-SATISFIED.
           ADD 1 TO J.
           IF (J < END-J)
           GO TO COUNT-SAT-LOOP2.

       CALC-SKILL-SCORE.
           MOVE 1 TO I.
           MOVE 6 TO END-I.
           PERFORM CALC-SKILL-SCORE-LOOP1.

       CALC-SKILL-SCORE-LOOP1.
           MOVE 1 TO J.
           MOVE 9 TO END-J.
           PERFORM CALC-SKILL-SCORE-LOOP2.
           ADD 1 TO I.
           IF (I < END-I)
           GO TO CALC-SKILL-SCORE-LOOP1.

       CALC-SKILL-SCORE-LOOP2.
           IF (OPT-SKILLS(I) EQUAL SKILLS(J))
               ADD 1.0 TO SKILL-SCORE.
           ADD 1 TO J.
           IF (J < END-J)
           GO TO CALC-SKILL-SCORE-LOOP2.

       CALC-PREF-SCORE.
           IF (CRS-ID EQUAL COURSE1)
               MOVE 1.5 TO PREF-SCORE.
           IF (CRS-ID EQUAL COURSE2)
               MOVE 1.0 TO PREF-SCORE.
           IF (CRS-ID EQUAL COURSE3)
               MOVE 0.5 TO PREF-SCORE.

      * Loop through the top three scores and update them if the current
      * candidate has the higher score.
       UPDATE-TOP-THREE.
           MOVE 1 TO I.
           MOVE 4 TO END-I.
           MOVE 0 TO TOP-THREE-UPDATED.
           PERFORM UPDATE-TOP-THREE-LOOP1.

       UPDATE-TOP-THREE-LOOP1.
           IF (CURR-SCORE > TOP-THREE-SCORES(I))
               MOVE 2 TO J
               MOVE I TO END-J
               SUBTRACT 1 FROM END-J
               PERFORM UPDATE-TOP-THREE-LOOP2
               MOVE STD-ID TO TOP-THREE-CAND(I)
               MOVE CURR-SCORE TO TOP-THREE-SCORES(I)
               MOVE 1 TO TOP-THREE-UPDATED.
           ADD 1 TO I.
           IF (I < END-I AND TOP-THREE-UPDATED EQUAL 0)
               GO TO UPDATE-TOP-THREE-LOOP1.

       UPDATE-TOP-THREE-LOOP2.
           MOVE J TO TMP.
           ADD 1 TO TMP.
           MOVE TOP-THREE-CAND(J) TO TOP-THREE-CAND(TMP).
           MOVE TOP-THREE-SCORES(J) TO TOP-THREE-SCORES(TMP).
           SUBTRACT 1 FROM J.
           IF (J > END-J)
               GO TO UPDATE-TOP-THREE-LOOP2.

      * Print the course ID and the top three candidates to the file.
       PRINT-TOP-THREE.
           MOVE CRS-ID TO O-CRS-ID.
           MOVE TOP-THREE-CAND(1) TO O-CAND1.
           MOVE TOP-THREE-CAND(2) TO O-CAND2.
           MOVE TOP-THREE-CAND(3) TO O-CAND3.
           MOVE " " TO O-SPACE1.
           MOVE " " TO O-SPACE2.
           MOVE " " TO O-SPACE3.
           MOVE " " TO O-SPACE4.
           MOVE X'0A' TO O-RETURN.
           WRITE OUTPUT-TABLE.
