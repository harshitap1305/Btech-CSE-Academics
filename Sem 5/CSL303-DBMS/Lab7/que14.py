import sqlite3
import random
import time

DB_FILE = "university.db"
con = sqlite3.connect(DB_FILE)
cur = con.cursor()

# Ensure indexes exist
cur.execute("CREATE INDEX IF NOT EXISTS idx_enrollments_student_id ON Enrollments(student_id)")
cur.execute("CREATE INDEX IF NOT EXISTS idx_enrollments_course_id ON Enrollments(course_id)")
print("Indexes ensured.")

start_time = time.time()

for _ in range(500):
    student_id = random.randint(1, 2000)
    course_id = random.randint(1, 100)
    grade = round(random.uniform(2.0, 4.0), 2)
    cur.execute("INSERT INTO Enrollments (student_id, course_id, grade) VALUES (?, ?, ?)",
                (student_id, course_id, grade))

con.commit()
end_time = time.time()

print(f"Time to insert 500 records (with indexes): {end_time - start_time:.6f} seconds")
con.close()

