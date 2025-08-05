#include <iostream>
#include <vector>
#include <string>

using namespace std;
int binaryToDecimal(const string& binary) {
    int n = binary.length();
    int result = 0;
    if (binary[0] == '1') {
        result = -1 * (1 << (n-1));
    }
    for (int i = 1; i < n; i++) {
        if (binary[i] == '1') {
            result += (1 << (n-1-i));
        }
    }
    return result;
}
int boothMultiplication(const string& multiplicand, const string& multiplier) {
    int n = multiplicand.length();
    
    int M = binaryToDecimal(multiplicand);  
    int Q = binaryToDecimal(multiplier);   
    
  
    int A = 0;      
    int Q_reg = Q;
    int Q_1 = 0;   
    
    
    int count = n;

    int sign_mask = 1 << (n-1);
    int extend_mask = ~((1 << n) - 1);
    
    
    while (count > 0) {
        
        int Q_0 = Q_reg & 1;
        
    
        if (Q_0 == 1 && Q_1 == 0) {
            A = A - M;
        }
        else if (Q_0 == 0 && Q_1 == 1) {
            A = A + M;
        }
        Q_1 = Q_0;

        int lsb_A = A & 1; 
        A = (A >> 1);
        

        if (A & sign_mask) {
            A |= extend_mask;
        }
        
        Q_reg = (Q_reg >> 1);
        

        if (lsb_A) {
            Q_reg |= sign_mask;
        } else {
            Q_reg &= ~sign_mask;
        }
        
        count--;
    }

    return (A << n) | (Q_reg & ((1 << n) - 1));
}

int main() {
    int n;
    string multiplicand, multiplier;
    
   
    cout << "Enter the size of binary numbers (n): ";
    cin >> n;
    
    cout << "Enter multiplicand (in binary): ";
    cin >> multiplicand;

    cout << "Enter multiplier (in binary): ";
    cin >> multiplier;
    
    if (multiplicand.length() != n || multiplier.length() != n) {
        cout << "Error: Input lengths must match specified size n" << endl;
        return 1;
    }
    
    for (char c : multiplicand + multiplier) {
        if (c != '0' && c != '1') {
            cout << "Error: Inputs must be binary (0s and 1s only)" << endl;
            return 1;
        }
    }
    
    int result = boothMultiplication(multiplicand, multiplier);
    
    cout << "Result: " << result << endl;
    
    return 0;
}