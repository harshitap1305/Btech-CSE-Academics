import sqlite3
import time

DB_FILE = "university.db"
QUERY = "SELECT * FROM Students WHERE major = 'Engineering';"
ITERATIONS = 100

con = sqlite3.connect(DB_FILE)
cur = con.cursor()

# Drop index if it exists
try:
    cur.execute("DROP INDEX idx_students_major")
    print("Index dropped.")
except sqlite3.OperationalError:
    print("Index did not exist.")

total_time = 0
for _ in range(ITERATIONS):
    start_time = time.time()
    cur.execute(QUERY).fetchall()
    end_time = time.time()
    total_time += (end_time - start_time)

print(f"Avg. time without index: {total_time / ITERATIONS:.6f} seconds")
con.close()

