#  Automated setup of multi tire web application, locally

This document outlines the steps to set up, build, and run the VProfile application, which is a multi-tier web application.

## 1. Prerequisites

Before you begin, ensure you have the following installed:

*   **Git**: For cloning the repository.
*   **JDK 17 or 21**: Java Development Kit.
*   **Maven 3.9**: Build automation tool.
*   **MySQL 8**: Database server.

## 2. Technologies Used

*   Spring MVC
*   Spring Security
*   Spring Data JPA
*   Maven
*   JSP
*   Tomcat
*   MySQL
*   Memcached
*   RabbitMQ
*   ElasticSearch

## 3. Multi-Tier Architecture

The VProfile application is designed with a multi-tier architecture to ensure scalability, maintainability, and separation of concerns.

*   **Presentation Layer**: Handles user interaction and displays information. This typically involves JSP pages, HTML, CSS, and JavaScript served by Tomcat.
*   **Application Layer**: Contains the core business logic and acts as an intermediary between the presentation and data layers. Built with Spring MVC, Spring Security, and Spring Data JPA, running on Apache Tomcat.
*   **Data Layer**: Responsible for data storage and retrieval. This includes:
    *   **MySQL**: The primary relational database for persistent data.
    *   **Memcached**: Used for caching frequently accessed data to improve performance.
    *   **RabbitMQ**: A message broker for asynchronous communication between different parts of the application or other services.
    *   **Elasticsearch**: A search engine for full-text search capabilities.
*   **Infrastructure/Proxy Layer**: Nginx acts as a reverse proxy, distributing incoming requests to the application servers and handling static content.

## 4. Workflow Diagram

Here's a simplified diagram illustrating the flow of requests and interactions between the different components:

```
User
  |
  v
Nginx (Reverse Proxy)
  |
  v
Tomcat (Application Server)
  |
  +---> MySQL (Database)
  |
  +---> Memcached (Caching)
  |
  +---> RabbitMQ (Messaging)
  |
  +---> Elasticsearch (Search)
```

## 5. Database Setup

This project uses MySQL.

*   **SQL Dump File**: `/src/main/resources/db_backup.sql`
*   **Import**: Import this dump file into your MySQL database server.
    ```bash
    mysql -u <user_name> -p accounts < db_backup.sql
    ```

## 6. Automated Provisioning (Vagrant Scripts)

The scripts in `vagrant/Automated_provisioning_WinMacIntel` are designed to be run within a virtual machine (VM) provisioned by Vagrant. Running them directly on your host machine (Windows, Mac, or Linux) without a VM is generally not recommended and can be complex due to:

1.  **Dependency Management**: These scripts are likely installing and configuring software (like Java, Maven, MySQL, Tomcat, Nginx, etc.) that would need to be manually installed on your host machine first.
2.  **Operating System Compatibility**: The scripts are probably written for a Linux environment (e.g., using `yum` for package management). Running them on Windows or macOS would require significant modifications or a compatibility layer like WSL on Windows.
3.  **Idempotency and Error Handling**: These scripts might not be designed to be run multiple times on the same system, and their error handling might not be robust enough for diverse host environments.
