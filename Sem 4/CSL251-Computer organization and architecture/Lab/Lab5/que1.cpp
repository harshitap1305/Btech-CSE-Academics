#include<bits/stdc++.h>
using namespace std;
class FloatingPointCalc {
private:
    double binToDecimal(const string& bin) {
        double result=0.0;
        for (size_t i=0; i < bin.length();i++) {
            if (bin[i]=='1') {
                result+=1.0/pow(2,i+1);
            }
        }
        return result;
    }

    long long binToInt(const string& bin) {
        long long result = 0;
        for (char c : bin) {
            result = (result << 1) + (c - '0');
        }
        return result;
    }

    string intToBin(long long num, int width) {
        if (num == 0) return string(width, '0');
        
        string result;
        bool isNegative=num<0;
        num=abs(num);
        
        while (num > 0 && result.length() < width) {
            result = char('0' + (num & 1)) + result;
            num >>= 1;
        }
        
        while (result.length() < width) {
            result = "0" + result;
        }
        
        return isNegative ? "-" + result : result;
    }

    bool isValidBinary(const string& str) {
        return str.find_first_not_of("01")==string::npos;
    }

public:
    struct Result {
        long long significand;
        long long exponent;
        string status;
        
        Result(long long s, long long e,string st) 
            : significand(s), exponent(e), status(st) {}
    };

    Result calculate(int n, int m, 
                    const string& S1, const string& S2,
                    const string& E1, const string& E2,
                    bool isAdd) {
        long long X_sig = binToInt("1" + S1);
        long long Y_sig = binToInt("1" + S2);
        long long X_exp = binToInt(E1);
        long long Y_exp = binToInt(E2);
        
        if (!isAdd) Y_sig = -Y_sig;
        
        long long Z_sig = 0;
        long long Z_exp = 0;
        
        if (X_sig == 0) return Result(Y_sig, Y_exp, "normal");
        if (Y_sig == 0) return Result(X_sig, X_exp, "normal");
        
        while (X_exp != Y_exp) {
            if (X_exp < Y_exp) {
                X_sig = X_sig >> 1;
                X_exp += 1;
                if (X_sig == 0) return Result(Y_sig, Y_exp, "normal");
            } else {
                Y_sig = Y_sig >> 1;
                Y_exp += 1;
                if (Y_sig == 0) return Result(X_sig, X_exp, "normal");
            }
        }
        
        Z_sig = X_sig + Y_sig;
        Z_exp = X_exp;
        
        if (Z_sig == 0) return Result(0, 0, "normal");
        
        long long max_sig = (1LL << (n + 1)) - 1;
        while (abs(Z_sig) > max_sig) {
            Z_sig = Z_sig >> 1;
            Z_exp += 1;
            if (Z_exp >= (1LL << m)) {
                return Result(Z_sig, Z_exp, "overflow");
            }
        }
        
        long long min_sig = 1LL << n;
        while (abs(Z_sig) < min_sig && Z_sig != 0) {
            Z_sig = Z_sig << 1;
            Z_exp -= 1;
            if (Z_exp < 0) {
                return Result(Z_sig, Z_exp, "underflow");
            }
        }
        
        return Result(Z_sig, Z_exp, "normal");

}string formatResult(const Result& result, int n) {
        if (result.significand == 0) {
            return "0 (Status: " + result.status + ")";
        }
        
        string sign = result.significand < 0 ? "-" : "";
        string sig_bin = intToBin(abs(result.significand), n + 1);
        string significand_part = sig_bin.substr(1);
        
        return sign + "1." + significand_part + "×2^" + 
               to_string(result.exponent) + 
               " (Status: " + result.status + ")";
    }

   string getBinaryInput(const string& prompt, int expectedLength) {
        string input;
        bool valid = false;
        
        while (!valid) {
            cout << prompt;
           cin >> input;
            
            if (!isValidBinary(input)) {
                cout << "Error: Please enter a valid binary number (0s and 1s only)\n";
                continue;
            }
            
            if (input.length() != expectedLength) {
                cout << "Error: Input must be exactly " << expectedLength << " bits long\n";
                continue;
            }
            
            valid = true;
        }
        
        return input;
    }
    void printDecimalEquivalent(const string& S1, const string& S2, 
                              const string& E1, const string& E2, 
                              bool isAdd) {
        double decimal1 = (1.0 + binToDecimal(S1)) * pow(2, binToInt(E1));
        double decimal2 = (1.0 + binToDecimal(S2)) * pow(2, binToInt(E2));
        cout << "\nFirst number (decimal): " << decimal1 <<endl;
        cout<<"Second number (decimal): "<<decimal2<<endl;
        cout<<"Result (decimal):"<<(isAdd?decimal1+decimal2:decimal1-decimal2)<<endl;
    }
};

int main() {
    FloatingPointCalc calc;
    
    
    while (1) {
      cout << "\n=== Floating Point Calculator ===\n\n";
        
      
        int n, m;
       cout << "Enter the length of significand (n): ";
        while (!(cin >> n) || n <= 0) {
            cout << "Please enter a valid positive integer: ";
           cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
        }
        
        cout << "Enter the length of exponent (m): ";
        while (!(cin >> m) || m <= 0) {
            cout << "Please enter a valid positive integer: ";
           cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
        }
    
        char operation;
       cout << "\nEnter operation (+ or -): ";
        while (!(cin >> operation) || (operation != '+' && operation != '-')) {
            cout << "Please enter either + or -: ";
            cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
        }
        
        cout << "\nEnter the binary numbers in the form 1.S * 2^E\n";
    
        string S1 = calc.getBinaryInput("Enter first significand (S1, " + 
            to_string(n) + " bits): ", n);
        string E1 = calc.getBinaryInput("Enter first exponent (E1, " + 
            to_string(m) + " bits): ", m);
        
       string S2 = calc.getBinaryInput("Enter second significand (S2, " + 
            to_string(n) + " bits): ", n);
        string E2 = calc.getBinaryInput("Enter second exponent (E2, " + 
            to_string(m) + " bits): ", m);
        
       
        cout << "\nCalculating " << "1." << S1 << "*2^" << E1 << " " << 
            operation << " 1." << S2 << "*2^" << E2 << endl;
        
        auto result = calc.calculate(n, m, S1, S2, E1, E2, operation == '+');
        cout << "\nBinary result: " << calc.formatResult(result, n) << endl;
        break;
        
        
    }

    return 0;
}
