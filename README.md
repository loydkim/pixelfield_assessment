# Pixelfield Project by YOUNGSIC (LOYD) KIM

 The project is a meticulously engineered Flutter application that adopts a feature-first structure to enhance modularity and maintainability. It utilizes the Bloc pattern for robust state management, ensuring a predictable and scalable state flow throughout the application. For efficient local data storage and retrieval, the project leverages Hive, a lightweight yet powerful database solution. The application’s visual design has been thoughtfully crafted in Figma, and the complete design resource can be viewed at the provided link. Together, these technologies form a cohesive framework that underpins the project's commitment to delivering a high-quality user experience. 
 
### Figma Design: https://www.figma.com/design/gX69tW4YfXMvlGrYVu2l7Q/Pixelfield-Flutter?node-id=0-1&p=f&t=ieoQB825TZZN5Y1H-0

## Project Development Environment 

[✓] Flutter (Channel stable, 3.29.3, on macOS 15.3.1 24D70 darwin-arm64, locale
    en-CA)

[✓] Android toolchain - develop for Android devices (Android SDK version 35.0.0)

[✓] Xcode - develop for iOS and macOS (Xcode 16.2)

[✓] Android Studio (version 2024.2)

[✓] VS Code (version 1.99.2)

## Requirements  

### This connection should be available only when internet connection is available 

1. Understanding Connectivity_plus

Connectivity Status:

The connectivity_plus plugin in Flutter is used to determine the type of network connection that the device is currently using, such as WiFi, mobile, or none. It provides a quick way to check if there is a network interface available.

Limitation on Actual Internet Access:

One important nuance is that connectivity_plus can tell you if the device is connected to a network (e.g., WiFi), but it does not guarantee that there is actual internet access. For example, a device may be connected to a WiFi network that has no internet connectivity (perhaps due to a captive portal, network misconfiguration, or other issues).

2. Meeting the Requirement 

Check for a Valid Internet Connection:

When the requirement states that a connection (or a feature that relies on a network) should only be available when an internet connection is present, you have to perform an extra verification step. This typically involves:

Step 1: Use connectivity_plus to check the current network status.

Step 2: If a network is detected (WiFi or mobile), proceed to verify that the internet is reachable. This can be done by making a simple HTTP request or performing a DNS lookup to a known reliable endpoint (for example, querying "google.com").  

### Data should be stored in the app and “refresh” after fetching if exists 

1. Hive as a Local Database

Lightweight and Fast:
Hive is a fast and lightweight key-value store designed for Flutter applications. It enables you to store data in a structured format and is perfect for caching purposes.

Ease of Use:
Hive’s API is straightforward, making it simple to read and write data. This is ideal for implementing a cache-refresh system where data is read on app start and then updated when new data is fetched.

2. Implementation Strategy 

Step 1: Display Cached Data

When the app starts or when a specific view is loaded, check the Hive box to see if local data exists. If it does, populate the UI immediately with this cached data.

Step 2: Fetch Remote Data

Concurrently or subsequently, initiate a background network request to fetch the latest data from your remote source. This can be done regardless of whether local data exists, ensuring that you always work towards the most up-to-date content.

Step 3: Update Cache & UI

Once new data is successfully fetched:

Update the Hive storage by replacing the stale data with the new data.
Notify the UI to refresh so that the user sees the updated content.

## Another information

### Use any packages from pub.dev, but explain, why you used it 

1. State Management Packages

flutter_bloc 

This package implements the BLoC (Business Logic Component) pattern. It is used for separating business logic from the presentation layer, which greatly enhances code modularity, testability, and maintainability. By encapsulating state changes and events, it allows your app to scale more robustly over time, ensuring that UI components remain focused solely on rendering.

equatable

In Dart, comparing objects (especially when dealing with immutable state) often requires overriding equality operators. The equatable package streamlines this process by providing a simple API to make objects easily comparable, which is particularly useful in conjunction with flutter_bloc where state and event comparisons are frequent. This reduces boilerplate code and potential errors in equality checks.

2. Database Packages

hive

 Hive is a lightweight, NoSQL key-value database written in pure Dart. It is known for its speed and simplicity. The choice of Hive is due to its ability to handle local storage needs efficiently, providing robust support for offline operations. Its performance, simplicity, and flexibility make it an excellent choice for apps that require a fast and easy-to-use database.
 
hive_flutter

This package provides the necessary integrations to use Hive in Flutter applications. It simplifies tasks such as initialization and ensures that Hive can seamlessly work within the Flutter ecosystem, offering widgets and utilities that are designed specifically to enhance the Flutter experience with Hive.

hive_generator 

When working with custom data models in Hive, you need type adapters to serialize and deserialize objects. hive_generator works alongside build_runner to automatically generate these adapters, thus reducing manual coding and helping avoid common errors related to data serialization. It boosts productivity by automating what would otherwise be a tedious and error-prone task.

3. Utility Packages

connectivity_plus

This package is used to monitor network connectivity status within the app. By handling connectivity changes, it allows the app to adapt its behavior based on the current network conditions—whether it should load remote content or rely on cached data, for instance. This makes the user experience more resilient, especially in scenarios where network connectivity is unstable or unavailable.

build_runner 

build_runner is a development tool that automates code generation tasks. In your case, it is primarily used to run the code generators (like hive_generator) that create boilerplate code, such as type adapters. This tool is essential for maintaining a clean and efficient codebase, significantly reducing manual errors and repetitive coding tasks.

### Track your time on test task and send this info to us

4.14(Mon) 

3:25pm : Retrieve the assessment message from Pixelfield Ltd.

5:00pm ~ 6:00pm : Review the assessment description and deliberate on the project structure.

6:00pm ~ 8:00pm : Initiate the project by saving application source files and generating mock data.

8:00pm : 10:00pm : Develop pages, create widgets, and establish the overall structure.

4.15(Tue)  

9:00am ~ 11:am: Finalize all pages and complete the mock data creation.

2:00pm ~ 4:00pm: Perform code refactoring using the Bloc pattern.

4:00pm ~ 6:00pm : Conduct code testing and optimization.

4.16(Wed)  

6:00am ~8:00am: Make Documentation and final testing.
