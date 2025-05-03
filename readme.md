
# Final‑Project Notes – *User Management*
**Implemented Feature • User Profile Management**

---

## 1  Key Takeaways and Personal Growth
During this project I progressed from Docker basics to a full Dev Ops workflow:

* **Containerisation** – multi‑stage Dockerfiles that keep build tools out of the runtime layer.  
* **Orchestration** – Docker Compose stack (FastAPI + Postgres + MinIO + Nginx) reproducible with one command.  
* **Automation** – GitHub Actions CI/CD, Buildx multi‑arch builds, Trivy scans on every push.  
* **Security mindset** – tracking CVEs, upgrading vulnerable libs, hard‑failing on CRITICAL/HIGH issues.  
* **Object‑storage integration** – MinIO + FastAPI for S3‑compatible PFP uploads.


Process‑wise, I adopted a professional Git workflow—feature branches, descriptive commits (25 +), detailed Issues, PR reviews—so every change is traceable from ticket → code → tests → CI run.

---

## 2  Closed QA Issues (5)

| # | Description | URL |
|---|-------------|-----|
| 2 | Docker package downgrade blocked build | <https://github.com/Darshuu25/user_management/issues/2> |
| 3 | Create docker repo “user_api” for Buildx cache | <https://github.com/Darshuu25/user_management/issues/3> |
| 4 | `ModuleNotFoundError: tenacity` fixed by requirements update | <https://github.com/Darshuu25/user_management/issues/4> |
| 6 | Docker & MinIO port clash (host 9000 already in use) | <https://github.com/Darshuu25/user_management/issues/6> |
| 7 | Fixed schema for upload profile pictures | <https://github.com/Darshuu25/user_management/issues/7> |

**Open QA Issue**

* Trivy discovered vulnerabilities – <https://github.com/Darshuu25/user_management/issues/5>

---

## 3  New Test Suite (10 tests)

* Location: `tests/test_storage/`, `tests/test_users/`  
* Coverage: successful PFP uploads, MIME‑type rejection, oversized files, non‑existent users, MinIO path validation, schema integrity.  
* CI automatically runs all tests; please the see commits on branch **`minio_feature`**.

---

## 4  New Features Delivered

| Feature | Description |
|---------|-------------|
| **PFP Upload Endpoint** | `POST /users/{id}/profile_picture` streams an image to MinIO, stores it under `<user‑id>/<uuid>`, returns a public URL. Enforces JWT auth, MIME whitelist, 5 MB cap. |
| **PFP URL in User Profile** | Added `profile_picture_url` column via Alembic; every `GET /users/{id}` now returns the stored URL so front‑ends can display PFP without extra calls. |

---

## 5  Docker Hub Image

The image is built and pushed automatically by GitHub Actions:

<https://hub.docker.com/repository/docker/darshuu25/user_api>


# Pull & run locally
```
docker pull darshuu25/user_api:latest
docker run --rm -p 8000:8000 darshuu25/user_api:latest
```
# The User Management System Final Project: Your Epic Coding Adventure Awaits! 🎉✨🔥

## Introduction: Buckle Up for the Ride of a Lifetime 🚀🎬

Welcome to the User Management System project - an epic open-source adventure crafted by the legendary Professor Keith Williams for his rockstar students at NJIT! 🏫👨‍🏫⭐ This project is your gateway to coding glory, providing a bulletproof foundation for a user management system that will blow your mind! 🤯 You'll bridge the gap between the realms of seasoned software pros and aspiring student developers like yourselves. 

### [Instructor Video - Project Overview and Tips](https://youtu.be/gairLNAp6mA) 🎥

- [Introduction to the system features and overview of the project - please read](system_documentation.md) 📚
- [Project Setup Instructions](setup.md) ⚒️
- [Features to Select From](features.md) 🛠️
- [About the Project](about.md)🔥🌟

## Goals and Objectives: Unlock Your Coding Superpowers 🎯🏆🌟

Get ready to ascend to new heights with this legendary project:

1. **Practical Experience**: Dive headfirst into a real-world codebase, collaborate with your teammates, and contribute to an open-source project like a seasoned pro! 💻👩‍💻🔥
2. **Quality Assurance**: Develop ninja-level skills in identifying and resolving bugs, ensuring your code quality and reliability are out of this world. 🐞🔍⚡
3. **Test Coverage**: Write additional tests to cover edge cases, error scenarios, and important functionalities - leave no stone unturned and no bug left behind! ✅🧪🕵️‍♂️
4. **Feature Implementation**: Implement a brand new, mind-blowing feature and make your epic mark on the project, following best practices for coding, testing, and documentation like a true artisan. ✨🚀🎆
5. **Collaboration**: Foster teamwork and collaboration through code reviews, issue tracking, and adhering to contribution guidelines - teamwork makes the dream work, and together you'll conquer worlds! 🤝💪🌍
6. **Industry Readiness**: Prepare for the software industry by working on a project that simulates real-world development scenarios - level up your skills to super hero status  and become an unstoppable coding force! 🔝🚀🏆⚡

## Submission and Grading: Your Chance to Shine 📝✏️📈

1. **Reflection Document**: Submit a 1-2 page Word document reflecting on your learnings throughout the course and your experience working on this epic project. Include links to the closed issues for the **5 QA issues, 10 NEW tests, and 1 Feature** you'll be graded on. Make sure your project successfully deploys to DockerHub and include a link to your Docker repository in the document - let your work speak for itself! 📄🔗💥

2. **Commit History**: Show off your consistent hard work through your commit history like a true coding warrior. **Projects with less than 10 commits will get an automatic 0 - ouch!** 😬⚠️ A significant part of your project's evaluation will be based on your use of issues, commits, and following a professional development process like a boss - prove your coding prowess! 💻🔄🔥

3. **Deployability**: Broken projects that don't deploy to Dockerhub or pass all the automated tests on GitHub actions will face point deductions - nobody likes a buggy app! 🐞☠️ Show the world your flawless coding skills!

## Managing the Project Workload: Stay Focused, Stay Victorious ⏱️🧠⚡

This project requires effective time management and a well-planned strategy, but fear not - you've got this! Follow these steps to ensure a successful (and sane!) project outcome:

1. **Select a Feature**: [Choose a feature](features.md) from the provided list of additional improvements that sparks your interest and aligns with your goals like a laser beam. ✨⭐🎯 This is your chance to shine!

2. **Quality Assurance (QA)**: Thoroughly test the system's major functionalities related to your chosen feature and identify at least 5 issues or bugs like a true detective. Create GitHub issues for each identified problem, providing detailed descriptions and steps to reproduce - the more detail, the merrier! 🔍🐞🕵️‍♀️ Leave no stone unturned!

3. **Test Coverage Improvement**: Review the existing test suite and identify gaps in test coverage like a pro. Create 10 additional tests to cover edge cases, error scenarios, and important functionalities related to your chosen feature. Focus on areas such as user registration, login, authorization, and database interactions. Simulate the setup of the system as the admin user, then creating users, and updating user accounts - leave no stone unturned, no bug left behind! ✅🧪🔍🔬 Become the master of testing!

4. **New Feature Implementation**: Implement your chosen feature, following the project's coding practices and architecture like a coding ninja. Write appropriate tests to ensure your new feature is functional and reliable like a rock. Document the new feature, including its usage, configuration, and any necessary migrations - future you will thank you profusely! 🚀✨📝👩‍💻⚡ Make your mark on this project!

5. **Maintain a Working Main Branch**: Throughout the project, ensure you always have a working main branch deploying to Docker like a well-oiled machine. This will prevent any last-minute headaches and ensure a smooth submission process - no tears allowed, only triumphs! 😊🚢⚓ Stay focused, stay victorious!

Remember, it's more important to make something work reliably and be reasonably complete than to implement an overly complex feature. Focus on creating a feature that you can build upon or demonstrate in an interview setting - show off your skills like a rockstar! 💪🚀🎓

Don't forget to always have a working main branch deploying to Docker at all times. If you always have a working main branch, you will never be in jeopardy of receiving a very disappointing grade :-). Keep that main branch shining bright!

Let's embark on this epic coding adventure together and conquer the world of software engineering! You've got this, coding rockstars! 🚀🌟✨
