# Student Management System

A web-based **Student Management System** developed using Java Servlets, JSP, HTML, CSS, and JavaScript. The application provides student record management, user authentication, dashboard analytics, and search functionality with local CSV file storage.

## 🚀 Features

### 1. User Authentication
- User registration and login.
- Password hashing using PBKDF2.
- Session-based authentication.
- Secure logout with session invalidation.
- Browser cache prevention for protected pages.

### 2. Admin Dashboard
- View total number of students.
- View male and female student statistics.
- Interactive gender distribution chart.
- Department-wise student distribution.
- Dashboard statistics calculated dynamically.

### 3. Student Management
- Add new student records.
- View student details.
- Update existing student information.
- Delete student records.
- Search students by ID, name, email, course, or department.

### 4. User Dashboard
- Separate dashboard for registered users.
- User account information.
- Access to student-related pages.

### 5. File-Based Data Storage
- Stores student records in `students.csv`.
- Stores user information in `users.csv`.
- No database configuration required.

## 🛠️ Technologies Used

| Category | Technologies |
|---|---|
| Programming Language | Java |
| Backend | Java Servlets |
| Frontend | JSP, HTML, CSS, JavaScript |
| Web Server | Apache Tomcat 9 |
| Data Storage | CSV File Storage |
| IDE | Eclipse IDE |
| API Testing | Postman |
| Version Control | Git and GitHub |

## 📂 Project Structure

```text
StudentManagementSystems/
│
├── src/main/java/
│   └── com/sms/
│       ├── dao/
│       ├── model/
│       ├── service/
│       ├── servlet/
│       └── util/
│
├── src/main/webapp/
│   ├── css/
│   ├── js/
│   ├── views/
│   │   ├── login.jsp
│   │   ├── signup.jsp
│   │   ├── dashboard.jsp
│   │   ├── user-dashboard.jsp
│   │   ├── students.jsp
│   │   ├── add-student.jsp
│   │   ├── edit-student.jsp
│   │   └── student-details.jsp
│   │
│   └── index.jsp
│
└── README.md
```

## ⚙️ Installation and Setup

### Prerequisites

- Java Development Kit (JDK 21)
- Eclipse IDE
- Apache Tomcat 9.0
- Git

### Steps to Run the Project

1. Clone the repository:

   ```bash
   git clone YOUR_GITHUB_REPOSITORY_URL
   ```

2. Open Eclipse IDE.

3. Import the project using **File → Import → Existing Projects into Workspace**.

4. Configure Apache Tomcat 9 in Eclipse.

5. Add the project to the Tomcat server.

6. Start the Tomcat server.

7. Open the application in your browser:

   ```text
   http://localhost:8091/StudentManagementSystems/login
   ```

   The port and context path may vary depending on your Eclipse configuration.

## 🔐 Security

- Session-based user authentication.
- Passwords stored as PBKDF2 hashes rather than plaintext.
- Session invalidation during logout.
- Login verification on protected servlet requests.
- Cache-control headers to prevent browsers from storing protected pages.

## 🧪 Testing

The application can be tested using:

- Web browser for frontend functionality.
- Postman for testing HTTP requests, servlet responses, login sessions, and authentication behavior.

## 💾 Data Storage

The application uses CSV files instead of a relational database.

- `students.csv` – Stores student information.
- `users.csv` – Stores registered user information and password hashes.

These files are maintained locally and should not be committed if they contain personal or sensitive data.

## 🎯 Project Objective

The objective of this project is to develop a simple and efficient student management application that demonstrates Java web development concepts, servlet-based request handling, JSP integration, session management, CRUD operations, and file-based data persistence.

## 👨‍💻 Developer

**Potnuru Sai Kranthi Kumar**

- GitHub: [kranthi46](https://github.com/kranthi46)

---

⭐ If you find this project useful, feel free to explore the repository and provide feedback.
