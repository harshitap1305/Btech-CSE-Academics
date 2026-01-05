import sqlite3
import time

DB_FILE = "university.db"
QUERY = "SELECT * FROM Students WHERE major = 'Engineering';"
ITERATIONS = 100

con = sqlite3.connect(DB_FILE)
cur = con.cursor()

# Create index
cur.execute("CREATE INDEX IF NOT EXISTS idx_students_major ON Students(major)")
print("Index created.")

total_time = 0
for _ in range(ITERATIONS):
    start_time = time.time()
    cur.execute(QUERY).fetchall()
    end_time = time.time()
    total_time += (end_time - start_time)

print(f"Avg. time with index: {total_time / ITERATIONS:.6f} seconds")

con.close()

