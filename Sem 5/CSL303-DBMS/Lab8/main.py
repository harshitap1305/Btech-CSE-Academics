import psycopg2

# ---------- Database Connection ----------
def connect_db():
    try:
        conn = psycopg2.connect(
            dbname="studentdb",
            user="postgres",
            password="admin123",
            host="localhost",
            port="5432"
        )
        return conn
    except Exception as e:
        print("Database connection error:", e)
        return None


def create_table(conn, table_name, columns):
    try:
        cur = conn.cursor()
        create_query = f"CREATE TABLE IF NOT EXISTS {table_name} ({columns});"
        cur.execute(create_query)
        conn.commit()
        print(f"Table '{table_name}' created successfully.")

        cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema='public';")
        print("Existing Tables:", [row[0] for row in cur.fetchall()])
        cur.close()
    except Exception as e:
        print("Error creating table:", e)


def insert_students(conn):
    try:
        cur = conn.cursor()
        n = int(input("Enter number of students to insert: "))
        for _ in range(n):
            name = input("Enter name: ")
            age = int(input("Enter age: "))
            dept = input("Enter department: ")
            cur.execute("INSERT INTO students (name, age, department) VALUES (%s, %s, %s);", (name, age, dept))
        conn.commit()
        print("Student(s) inserted successfully.")
        cur.close()
    except Exception as e:
        print("Error inserting students:", e)


def update_student(conn):
    try:
        cur = conn.cursor()
        name = input("Enter student name to update department: ")
        new_dept = input("Enter new department: ")
        cur.execute("UPDATE students SET department = %s WHERE name = %s;", (new_dept, name))
        conn.commit()
        print("Student department updated successfully.")
        cur.close()
    except Exception as e:
        print("Error updating student:", e)


def delete_student(conn):
    try:
        cur = conn.cursor()
        sid = int(input("Enter student ID to delete: "))
        cur.execute("DELETE FROM students WHERE id = %s;", (sid,))
        conn.commit()
        print("Student deleted successfully.")
        cur.close()
    except Exception as e:
        print("Error deleting student:", e)


def query_data(conn):
    try:
        cur = conn.cursor()
        print("\n1. Display all students")
        print("2. Display students by department")
        print("3. Display average age by department")
        print("4. Display students whose names start with a letter")
        choice = input("Enter your query choice: ")

        if choice == '1':
            cur.execute("SELECT * FROM students;")
            rows = cur.fetchall()
            for row in rows:
                print(row)

        elif choice == '2':
            dept = input("Enter department: ")
            cur.execute("SELECT * FROM students WHERE department = %s;", (dept,))
            for row in cur.fetchall():
                print(row)

        elif choice == '3':
            cur.execute("SELECT department, AVG(age) FROM students GROUP BY department;")
            for row in cur.fetchall():
                print(f"{row[0]} - Average Age: {row[1]:.2f}")

        elif choice == '4':
            letter = input("Enter starting letter: ")
            cur.execute("SELECT * FROM students WHERE name ILIKE %s;", (letter + '%',))
            for row in cur.fetchall():
                print(row)

        else:
            print("Invalid query choice.")

        cur.close()
    except Exception as e:
        print("Error performing query:", e)


def menu():
    conn = connect_db()
    if not conn:
        return

    while True:
        print("\n====== Student Database Menu ======")
        print("1. Create Table")
        print("2. Insert Student")
        print("3. Update Student")
        print("4. Delete Student")
        print("5. Query Data")
        print("6. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            table_name = input("Enter table name (e.g., students): ")
            columns = "id SERIAL PRIMARY KEY, name VARCHAR(50), age INT, department VARCHAR(50)"
            create_table(conn, table_name, columns)
        elif choice == '2':
            insert_students(conn)
        elif choice == '3':
            update_student(conn)
        elif choice == '4':
            delete_student(conn)
        elif choice == '5':
            query_data(conn)
        elif choice == '6':
            print("Exiting program. Closing connection...")
            conn.close()
            break
        else:
            print("Invalid choice, please try again.")


if __name__ == "__main__":
    menu()

