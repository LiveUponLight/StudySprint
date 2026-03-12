* AB Test 1:
  * Test Name: Daily Login Progress Bar
  * User Story Number: US 4
  * Metrics: Retention
  * Hypothesis: I hypothesize that without having a reason to return to the app, motivation to use the app may decrease which would lead to a decrease in retention. By including a daily login progress bar, users may be motivated to atleast sign in to the app every day even if they do not do anything productive while using it.
  * Experiment: Audience - 50% of random users. I want it to be completely random so we can gather data from which user group is more likely to login multiple times over the course of a week. If one of the two groups has a significantly higher retention rate, we will go with that design.
  * Variations: One variation will include a daily login progress bar as a pop-up upon login, maybe with a point-system and the inclusion of a leaderboard. The other variation will not include a daily login progress bar.
* AB Test 2:
  * Test Name:
  * User Story Number:
  * Metrics:
  * Hypothesis:
  * Experiment:
  * Variations:
* AB Test 3: 
  * Test Name: Syllabus Upload Prompt Placement Test
  * User Story Number: US1 Account Creation
  * Metrics: % of users who upload a syllabus within 24 hours of signup; % of users who generate their first study plan
  * Hypothesis:  New users often drop off after account creation because the syllabus upload prompt appears too early or is overlooked. By moving the prompt to appear          after a brief onboarding tutorial, we hypothesize that more users will understand its value and complete the upload, increasing first-study-plan generation by 10%.
  * Experiment: Using Firebase Remote Config, we will roll out the experiment to 50% of new Android and iOS users (control sees prompt immediately; variation sees prompt       after tutorial) to balance statistical significance with risk mitigation. Firebase Analytics will track custom events:                                                      syllabus_upload_started,syllabus_upload_completed, and first_study_plan_generated, segmented by variant.
  * Variations: Control A: Syllabus upload prompt appears immediately after account creation. Variation B: Syllabus upload prompt appears after a 3-screen onboarding          tutorial highlighting key features.
* AB Test 4:
  * Test Name:
  * User Story Number:
  * Metrics:
  * Hypothesis:
  * Experiment:
  * Variations:
