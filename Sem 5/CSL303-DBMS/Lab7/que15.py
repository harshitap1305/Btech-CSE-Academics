import sqlite3
import random
import time

DB_FILE = "university.db"
con = sqlite3.connect(DB_FILE)
cur = con.cursor()

# Drop indexes
try:
    cur.execute("DROP INDEX idx_enrollments_student_id")
    cur.execute("DROP INDEX idx_enrollments_course_id")
    print("Indexes dropped.")
except sqlite3.OperationalError:
    print("Indexes did not exist.")

start_time = time.time()

for _ in range(500):
    student_id = random.randint(1, 2000)
    course_id = random.randint(1, 100)
    grade = round(random.uniform(2.0, 4.0), 2)
    cur.execute("INSERT INTO Enrollments (student_id, course_id, grade) VALUES (?, ?, ?)",
                (student_id, course_id, grade))

con.commit()
end_time = time.time()

print(f"Time to insert 500 records (without indexes): {end_time - start_time:.6f} seconds")
con.close()

