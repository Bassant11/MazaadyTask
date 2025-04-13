#  Mazaady iOS Task

This is an iOS application developed for an interview task. The app showcases a user's profile including personal information, tags, a product list, and advertisements.

---

## Architecture Decisions

The project is built using **MVVM (Model-View-ViewModel)** architecture with **Protocol-Oriented Programming (POP)** principles. This promotes a clean separation of concerns, testability, and modular design.

## Key Choices:

| Layer         | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| **View**      | UIKit-based screens (Storyboard + programmatic components).                 |
| **ViewModel** | Handles business logic and state transformation using `RxSwift`.            |
| **Model**     | Codable models to match API responses (User, Product, Tag, Advertisement).  |
| **Networking**| Abstracted API layer using `URLSession` and a service protocol.             |
| **Dependency Injection** | Using **Swinject** to inject services and dependencies.         |

 `RxSwift` is used to bind UI and business logic reactively, and observe user interactions like search and refresh.

---

## ▶️ How to Run the Project

### Requirements

- macOS with Xcode 15 or higher
- Swift 5.8+
- CocoaPods installed (`sudo gem install cocoapods`)

### Steps

1. **Clone the repo**

```bash
git clone https://github.com/Bassant11/MazaadyTask.git
cd MazaadyIOSTask
