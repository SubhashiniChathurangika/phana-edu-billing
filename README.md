# Pahana Edu Billing System

A comprehensive Java EE web application for managing educational billing operations. This system is designed for educational institutions to handle customer billing, inventory management, and financial reporting.

## 🎓 Project Overview

**Pahana Edu Billing System** is a modern web-based billing management solution built with Java EE technologies. It provides a complete solution for educational institutions to manage their billing operations efficiently.

### Features

- **User Authentication & Authorization** - Secure login system with role-based access (Admin/Staff)
- **Customer Management** - Add, edit, and manage customer information
- **Inventory Management** - Track educational items, books, equipment, and services
- **Bill Generation** - Create and manage bills with multiple items
- **Payment Tracking** - Monitor bill status (Paid, Pending, Cancelled)
- **Reporting** - Generate financial reports and analytics
- **Modern UI** - Responsive design with beautiful user interface

## 🛠️ Technology Stack

- **Backend**: Java EE (Servlets, JSP)
- **Database**: MySQL 8.0+
- **Frontend**: HTML5, CSS3, JavaScript, Font Awesome
- **Server**: Apache Tomcat 9.0+
- **Build Tool**: Maven (recommended)

## 📋 Prerequisites

Before running this application, ensure you have the following installed:

- **Java Development Kit (JDK)** 8 or higher
- **Apache Tomcat** 9.0 or higher
- **MySQL** 8.0 or higher
- **Maven** (optional, for dependency management)

## 🚀 Installation & Setup

### 1. Database Setup

1. **Start MySQL Server**
   ```bash
   # On Windows
   net start mysql
   
   # On Linux/Mac
   sudo systemctl start mysql
   ```

2. **Create Database**
   ```bash
   mysql -u root -p
   ```
   
   Then run the SQL script:
   ```sql
   source database/pahanaedu_billing.sql
   ```

3. **Verify Database Creation**
   ```sql
   USE pahanaedu;
   SHOW TABLES;
   ```

### 2. Project Configuration

1. **Update Database Connection**
   
   Edit `src/main/java/com/pahanaedu/pahanaedubilling/util/DBConnection.java`:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/pahanaedu";
   private static final String USER = "your_username";
   private static final String PASS = "your_password";
   ```

2. **Add MySQL JDBC Driver**
   
   Download MySQL Connector/J and add it to your project's `WEB-INF/lib/` directory.

### 3. Deploy to Tomcat

1. **Build the Project**
   ```bash
   # If using Maven
   mvn clean package
   
   # Or manually compile Java files
   javac -cp "path/to/servlet-api.jar:path/to/mysql-connector.jar" src/main/java/com/pahanaedu/pahanaedubilling/**/*.java
   ```

2. **Deploy to Tomcat**
   - Copy the entire project to `{TOMCAT_HOME}/webapps/pahanaedu-billing/`
   - Or create a WAR file and deploy it

3. **Start Tomcat**
   ```bash
   # On Windows
   {TOMCAT_HOME}/bin/startup.bat
   
   # On Linux/Mac
   {TOMCAT_HOME}/bin/startup.sh
   ```

## 🔐 Default Login Credentials

The system comes with pre-configured demo accounts:

| Username | Password | Role |
|----------|----------|------|
| admin | admin123 | Administrator |
| staff1 | staff123 | Staff |
| staff2 | staff456 | Staff |
| manager | manager123 | Administrator |

## 📊 Database Schema

### Tables

1. **users** - System users and authentication
2. **customers** - Customer information
3. **items** - Inventory items (books, equipment, services)
4. **bills** - Bill headers
5. **bill_items** - Bill line items

### Sample Data

The database includes sample data for:
- 4 system users
- 8 customers
- 15 educational items
- 8 sample bills with line items

## 🎨 User Interface

### Modern Design Features

- **Responsive Layout** - Works on desktop, tablet, and mobile
- **Gradient Backgrounds** - Beautiful visual appeal
- **Card-based Design** - Clean and organized layout
- **Interactive Elements** - Hover effects and animations
- **Font Awesome Icons** - Professional iconography
- **Color-coded Status** - Easy status identification

### Pages

1. **Login Page** (`login.jsp`) - Secure authentication
2. **Dashboard** (`dashboard.jsp`) - Overview and statistics
3. **Bills Management** (`bills.jsp`) - List and manage bills
4. **Customer Management** - Add and manage customers
5. **Inventory Management** - Manage items and services
6. **Reports** - Financial reporting and analytics

## 🔧 Configuration

### Database Configuration

Update the database connection settings in `DBConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/pahanaedu";
private static final String USER = "your_username";
private static final String PASS = "your_password";
```

### Web Application Configuration

The `web.xml` file contains servlet mappings and configurations. Ensure all servlets are properly mapped.

## 📱 Usage Guide

### For Administrators

1. **Login** with admin credentials
2. **Dashboard** - View system overview and statistics
3. **User Management** - Add/edit system users
4. **Reports** - Generate financial reports
5. **Settings** - Configure system parameters

### For Staff

1. **Login** with staff credentials
2. **Create Bills** - Generate new bills for customers
3. **Manage Customers** - Add and update customer information
4. **Inventory** - Check item availability and prices
5. **View Bills** - Track bill status and payments

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Verify MySQL is running
   - Check database credentials
   - Ensure MySQL JDBC driver is in classpath

2. **404 Errors**
   - Verify servlet mappings in web.xml
   - Check file paths and names
   - Ensure proper deployment structure

3. **Login Issues**
   - Verify database has user data
   - Check password encryption (if implemented)
   - Review session management

### Logs

Check Tomcat logs for detailed error information:
```
{TOMCAT_HOME}/logs/catalina.out
{TOMCAT_HOME}/logs/localhost.log
```

## 🔒 Security Considerations

- **Password Security** - Implement password hashing in production
- **SQL Injection** - Use prepared statements (already implemented)
- **Session Management** - Implement proper session handling
- **Input Validation** - Validate all user inputs
- **HTTPS** - Use SSL/TLS in production

## 📈 Future Enhancements

- **Email Notifications** - Send bill reminders via email
- **Payment Gateway Integration** - Online payment processing
- **Mobile App** - Native mobile application
- **Advanced Reporting** - Charts and analytics
- **Multi-language Support** - Internationalization
- **Backup & Recovery** - Automated database backups

## 📄 License

This project is created for educational purposes as part of the ICBT CIS6003 S3SRI WRIT1 course.

## 👥 Contributing

This is an educational project. For learning purposes, feel free to:
- Fork the repository
- Create feature branches
- Submit pull requests
- Report issues

## 📞 Support

For technical support or questions:
- Check the troubleshooting section
- Review the code comments
- Consult the Java EE documentation

---

**Pahana Edu Billing System** - Empowering Educational Institutions with Modern Billing Solutions
