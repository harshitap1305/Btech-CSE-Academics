import subprocess
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os

# --- CONFIGURATION ---
ROLL_LAST_TWO = 20 

NS3_EXECUTABLE = "./ns3"
SCRIPT_NAME = "ass6_partB"  

rng_runs = list(range(ROLL_LAST_TWO, ROLL_LAST_TWO + 10))
error_rates = [0.2, 0.4, 0.6, 0.8, 1.0]
error_units = ["ERROR_UNIT_PACKET", "ERROR_UNIT_BIT", "ERROR_UNIT_BYTE"]

# Make a directory to save the plots and tables
output_dir = "assignment6_results"
os.makedirs(output_dir, exist_ok=True)

def run_simulation(er, unit, seed):
    """Executes the ns-3 script and extracts the PDR value."""
    cmd = [
        NS3_EXECUTABLE, "run", 
        f"scratch/{SCRIPT_NAME} --errorRate={er} --errorUnit={unit} --RngRun={seed}"
    ]
    
    try:
        # Run command and capture standard output
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True, check=True)
        
        # script prints the PDR as the last line
        output_lines = result.stdout.strip().split('\n')
        pdr_str = output_lines[-1].strip()
        
        return float(pdr_str)
    
    except Exception as e:
        print(f"Error running simulation for ER={er}, Unit={unit}, Seed={seed}: {e}")
        return 0.0

# --- MAIN AUTOMATION LOOP ---
for unit in error_units:
    print(f"\n--- Running Simulations for {unit} ---")
    
    # Create a 2D array to hold PDR results: rows = RngRun, cols = ErrorRate
    results_matrix = np.zeros((len(rng_runs), len(error_rates)))
    
    for i, seed in enumerate(rng_runs):
        for j, er in enumerate(error_rates):
            print(f"Running Seed {seed}, ErrorRate {er}...", end="\r")
            pdr = run_simulation(er, unit, seed)
            results_matrix[i, j] = pdr
            
    print(f"Completed {unit} simulations.                     ")
    
    # --- GENERATE TABLE ---
    # Calculate average PDR across seeds for each error rate
    avg_pdrs = np.mean(results_matrix, axis=0)
    
    # Build a Pandas DataFrame to format the table exactly as requested
    columns = [f"ER={er}" for er in error_rates]
    index = [f"RngRun{i+1}={seed}" for i, seed in enumerate(rng_runs)]
    
    df = pd.DataFrame(results_matrix, index=index, columns=columns)
    df.loc['AVG. PDR'] = avg_pdrs
    
    # Display table and save to CSV
    print(f"\nTable for {unit}:")
    print(df.to_string())
    csv_filename = os.path.join(output_dir, f"table_{unit}.csv")
    df.to_csv(csv_filename)
    
    # --- PLOT GRAPH ---
    plt.figure(figsize=(8, 5))
    plt.plot(error_rates, avg_pdrs, marker='o', linestyle='-', color='b', linewidth=2)
    plt.title(f'Average PDR vs Error Rate ({unit})')
    plt.xlabel('Error Rate')
    plt.ylabel('Average Packet Delivery Ratio (PDR)')
    plt.xticks(error_rates)
    plt.ylim(0, 1.05)
    plt.grid(True, linestyle='--', alpha=0.7)
    
    plot_filename = os.path.join(output_dir, f"plot_{unit}.png")
    plt.savefig(plot_filename)
    plt.close()

print(f"\nAll simulations complete. Check the '{output_dir}' folder for tables and plots.")
