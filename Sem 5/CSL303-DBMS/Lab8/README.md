# Lab 8

## Setup Instructions

### Start PostgreSQL using Docker
```bash
docker pull postgres
docker run --name pg_lab -e POSTGRES_PASSWORD=admin123 -p 5432:5432 -d postgres
docker exec -it pg_lab psql -U postgres
CREATE DATABASE studentdb;
\q
```
### Install Python dependencies
```
pip install -r requirements.txt
```

### Run the program
```
python main.py
```

#### You will see the main menu. Follow the on-screen prompts to use the application.
```
    ====== Student Database Menu ======
    1. Create Table
    2. Insert Student
    3. Update Student
    4. Delete Student
    5. Query Data
    6. Exit
    Enter your choice:
```
    
## Program Features

* **1. Create Table:** Creates the `students` table with `id`, `name`, `age`, and `department` columns.
* **2. Insert Student:** Prompts the user to add one or more students to the table.
* **3. Update Student:** Updates an existing student's department based on their name.
* **4. Delete Student:** Deletes a student from the table based on their `id`.
* **5. Query Data:** Opens a sub-menu with four different query options:
    * Display all students
    * Display students by department
    * Display average age by department
    * Display students whose names start with a specific letter
* **6. Exit:** Gracefully closes the database connection and terminates the program.
