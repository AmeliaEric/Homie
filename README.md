<div align="center">

# Homie

### Full-stack roommate and household management platform for iOS

[![Swift](https://img.shields.io/badge/Swift-5.0-orange?style=flat-square&logo=swift)](https://swift.org)
[![Firebase](https://img.shields.io/badge/Firebase-Realtime%20DB-FFCA28?style=flat-square&logo=firebase)](https://firebase.google.com)
[![Ruby](https://img.shields.io/badge/Ruby-Backend-CC342D?style=flat-square&logo=ruby)](https://www.ruby-lang.org)
[![Xcode](https://img.shields.io/badge/Xcode-IDE-1575F9?style=flat-square&logo=xcode)](https://developer.apple.com/xcode/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey?style=flat-square&logo=apple)](https://developer.apple.com/ios/)

[Demo Video](#demo) · [Features](#features) · [Getting Started](#getting-started) · [Tech Stack](#tech-stack) · [Project Structure](#project-structure)

</div>

---

## Overview

**Homie** is an iOS mobile application designed to simplify shared living. Whether you're splitting chores, managing shared tasks, or keeping your household organized, Homie gives roommates a single collaborative space to stay on the same page.

Built as a capstone project, Homie is a full-stack application with a native Swift frontend, a Ruby-powered backend, and Firebase for real-time data persistence and user authentication.

---

## Demo

📺 Watch the full demo on YouTube: **[https://youtu.be/uvxYLSialgE](https://youtu.be/uvxYLSialgE)**

---

## Features

- **User Authentication** — Secure sign-up and login powered by Firebase Authentication
- **Shared Task Management** — Create, assign, and complete household to-do items visible to all roommates in real time
- **Household Management** — Organize your living group and manage who belongs to your shared home
- **Real-Time Sync** — All updates reflect instantly across every roommate's device via Firebase Realtime Database
- **User Profiles** — Personalized accounts so each roommate has their own identity within the household
- **Clean Native UI** — Intuitive SwiftUI-based interface built to feel right at home on iOS

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Swift / SwiftUI |
| IDE | Xcode |
| Backend | Ruby |
| Database | Firebase Realtime Database |
| Authentication | Firebase Authentication |
| Dependency Management | CocoaPods |

---

## Project Structure

```
Homie/
├── Models/                  # Data models (User, Task, Household, etc.)
├── Views/                   # SwiftUI views and UI components
├── Other/                   # App configuration and helper files
├── Pods/                    # CocoaPods dependencies
├── Preview Content/         # Xcode preview assets
├── ToDoList.xcodeproj       # Xcode project file
├── ToDoList.xcworkspace     # Xcode workspace (use this to open the project)
├── ToDoListTests/           # Unit tests
├── ToDoListUITests/         # UI tests
├── Podfile                  # CocoaPods dependency definitions
├── Podfile.lock             # Locked dependency versions
├── ToDoList.entitlements    # App entitlements and capabilities
└── README.md
```

---

## Getting Started

### Prerequisites

Before you begin, make sure you have the following installed:

- [Xcode](https://developer.apple.com/xcode/) (latest stable version)
- [CocoaPods](https://cocoapods.org/) — install via:
  ```bash
  sudo gem install cocoapods
  ```
- A [Firebase](https://firebase.google.com) project with Realtime Database and Authentication enabled
- Ruby (used for backend scripts)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AmeliaEric/Homie.git
   cd Homie
   ```

2. **Install CocoaPods dependencies:**
   ```bash
   pod install
   ```

3. **Configure Firebase:**
   - Go to the [Firebase Console](https://console.firebase.google.com) and create a new project (or use an existing one)
   - Enable **Authentication** (Email/Password) and **Realtime Database**
   - Download your `GoogleService-Info.plist` file
   - Add it to the root of the Xcode project (drag it into Xcode under the `ToDoList` target)

4. **Open the workspace in Xcode:**
   ```bash
   open ToDoList.xcworkspace
   ```
   > ⚠️ Be sure to open the `.xcworkspace` file, **not** the `.xcodeproj`, so CocoaPods dependencies are included.

5. **Build and run:**
   - Select your target simulator or a connected iOS device
   - Press `Cmd + R` or click the ▶ Run button in Xcode

---

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  <sub>Made with Swift, Ruby, and Firebase · <a href="https://youtu.be/uvxYLSialgE">Watch the Demo</a></sub>
</div>
