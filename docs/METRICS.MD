[Google Slides HEART Framework] https://docs.google.com/presentation/d/1jVMeOnFYl8CtAu563yHkVjn_ouRaAmIuPjFWImEfNnc/edit?usp=sharing

Metrics 1 - **NPS (Net Promoter Score)** – After users complete the Golden Path (uploading their syllabus or schedule), the app asks “How likely are you to recommend Study Sprint to a friend?” on a 0–10 scale. The response is stored in Firebase Firestore under an `npsResponses` collection and optionally logged as a Firebase Analytics event called `nps_submitted`.
