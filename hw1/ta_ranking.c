/*
 * CSCI3180 Principles of Programming Languages
 *
 * --- Declaration ---
 *
 * I declare that the assignment here submitted is original except for source
 * material explicitly acknowledged. I also acknowledge that I am aware of
 * University policy and regulations on honesty in academic work, and of the
 * disciplinary guidelines and procedures applicable to breaches of such policy
 * and regulations, as contained in the website
 * http://www.cuhk.edu.hk/policy/academichonesty/
 *
 * Assignment 1
 * Name : Chao Yu
 * Student ID : 1155053722
 * Email Addr : ychao5@cse.cuhk.edu.hk
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define REQ_SKILLS 3
#define OPT_SKILLS 5
#define CAND_COURSE 3
#define CAND_SKILLS 8

float PreferenceScores[CAND_COURSE] = {1.5, 1.0, 0.5};

typedef struct _course {
    int courseID;
    char requiredSkills[3][16];
    char optionalSkills[5][16];
} Course;

typedef struct _candidate {
    int studentID;
    char skills[8][16];
    int courseIDs[3];
} Candidate;

// Convert the raw text line into a Course struct.
Course getCourseFromLine(char* line) {
    Course newCourse;

    // Course ID.
    char rawID[5];
    strncpy(rawID, line, 4);
    newCourse.courseID = atoi(rawID);

    line += 5;

    // Required Skills.
    int i;
    for (i = 0; i < REQ_SKILLS; i++) {
        strncpy(newCourse.requiredSkills[i], line, 15);
        newCourse.requiredSkills[i][15] = '\0';
        line += 15;
    }

    // Optional Skills.
    for (i = 0; i < OPT_SKILLS; i++) {
        strncpy(newCourse.optionalSkills[i], line, 15);
        newCourse.optionalSkills[i][15] = '\0';
        line += 15;
    }

    return newCourse;
}

// Convert the raw text line into a Candidate struct.
Candidate getCandidateFromLine(char* line) {
    Candidate newCand;

    // Student ID.
    char rawID[11];
    strncpy(rawID, line, 10);
    newCand.studentID = atoi(rawID);

    line += 11;

    // Skills.
    int i;
    for (i = 0; i < CAND_SKILLS; i++) {
        strncpy(newCand.skills[i], line, 15);
        newCand.skills[i][15] = '\0';
        line += 15;
    }

    // Courses.
    for (i = 0; i < CAND_COURSE; i++) {
        strncpy(rawID, line, 5);
        rawID[4] = '\0';
        line += 5;
        newCand.courseIDs[i] = atoi(rawID);
    }

    return newCand;
}

float calculateScore(Course* course, Candidate* candidate) {
    // check if all required skills are satisfied.
    int skillSatisfied = 0;
    int i, j;
    for (i = 0; i < REQ_SKILLS; i++) {
        for (j = 0; j < CAND_SKILLS; j++) {
            if (strcmp(course->requiredSkills[i], candidate->skills[j]) == 0) {
                skillSatisfied++;
                break;
            }
        }
    }

    // At least one of the required skills not satisfied.
    if (skillSatisfied < REQ_SKILLS) {
        return 0.0;
    }

    // Calculate the skill score.
    int skillScore = 0;
    for (i = 0; i < OPT_SKILLS; i++) {
        for (j = 0; j < CAND_SKILLS; j++) {
            if (strcmp(course->optionalSkills[i], candidate->skills[j]) == 0) {
                skillScore++;
                break;
            }
        }
    }

    // Calculate the preference score.
    float prefScore = 0.0;
    
    for (i = 0; i < CAND_COURSE; i++) {
        if (course->courseID == candidate->courseIDs[i]) {
            prefScore = PreferenceScores[i];
            break;
        }
    }

    return 1.0 + prefScore + (float) skillScore;
}

int main(void) {
    // Opening required files.
    FILE* instructorsFile = fopen("instructors.txt", "r");
    if (instructorsFile == NULL) {
        printf("non-existing file!\n");
        return 1;
    }

    FILE* candidatesFile = fopen("candidates.txt", "r");
    if (candidatesFile == NULL) {
        printf("non-existing file!\n");
        return 1;
    }

    FILE* outputFile = fopen("output.txt", "w");
    if (outputFile == NULL) {
        printf("error creating output file!\n");
        return 2;
    }

    char courseBuffer[128];
    char candidateBuffer[256];
    
    // Looping through the instructors list line by line.
    while (fgets(courseBuffer, sizeof(courseBuffer), instructorsFile) != NULL) {
        Course currCourse = getCourseFromLine(courseBuffer);
        
        // Start from the beginning of the candidate file.
        fseek(candidatesFile, 0, SEEK_SET);

        int topThreeCandidates[3] = {0};

        // The score should be greater than 0.5, meaning they satisfy the required skills.
        float topThreeScores[3] = {0.5};

        // Loop through each candidate to obtain the score for this course.
        while (fgets(candidateBuffer, sizeof(candidateBuffer), candidatesFile) != NULL) {
            Candidate currCand = getCandidateFromLine(candidateBuffer);
            float currScore = calculateScore(&currCourse, &currCand);

            // Loop through the top three scores and update them if the current candidate has higher score.
            int i, j;
            for (i = 0; i < 3; i++) {
                if (currScore > topThreeScores[i]) {
                    for (j = 1; j >= i; j--) {
                        topThreeCandidates[j+1] = topThreeCandidates[j];
                        topThreeScores[j+1] = topThreeScores[j];
                    }
                    topThreeCandidates[i] = currCand.studentID;
                    topThreeScores[i] = currScore;
                    break;
                }
            }
        }

        // Print out the top three candidates.
        fprintf(outputFile, "%d ", currCourse.courseID);
        int i;
        for (i = 0; i < 3; i++) {
            if (topThreeCandidates[i] == 0) {
                fprintf(outputFile, "0000000000 ");
            } else {
                fprintf(outputFile, "%d ", topThreeCandidates[i]);
            }
        }
        fprintf(outputFile, "\n");
    }

    fclose(instructorsFile);
    fclose(candidatesFile);
    fclose(outputFile);

    return 0;
}