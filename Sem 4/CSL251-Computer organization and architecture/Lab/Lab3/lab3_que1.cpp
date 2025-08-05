
#include<bits/stdc++.h>
using namespace std;
vector<int> AddSub(const vector<int>& A, const vector<int>& B, int op) {
    if (A.size() != B.size()) {
        cout<<"Error: Bit vectors must be of equal length"<< endl;
        return vector<int>();
    }
    int n = A.size();
    vector<int> result(n);
    int carry = op;
   vector<int> B_modified = B;
    if (op == 1) {
        for (int i = 0; i < n; i++) {
            B_modified[i] = B_modified[i] ^ 1;
        }
    }
    for (int i=n-1;i>=0;i--) {
        int sum=A[i]+B_modified[i]+carry;
        result[i]=sum%2;
        carry=sum/2;
    }
    return result;
}

void arithmeticShift(vector<int>& A, vector<int>& Q,int& Q_1) {

    int temp=Q[Q.size()-1];
    for (int i=Q.size()-1;i>0;i--) {
        Q[i]=Q[i-1];
    }
    Q[0]=A[A.size()-1];
    for (int i=A.size()-1;i>0;i--) {
        A[i]=A[i-1];
    }
    Q_1=temp;
}

void printState(const vector<int>& A, const vector<int>& Q,int Q_1,int Count) {
    cout << "A: ";
    for (int bit : A) cout << bit;
  cout << " Q: ";
    for (int bit : Q) cout << bit;
    cout << " Q_1: " << Q_1;
    cout << " Count: " << Count << endl;
}

vector<int> stringToBinary(const string& str, int n) {
   vector<int> result(n, 0);
    for (int i = 0; i < str.length() && i < n; i++) {
        if (str[str.length()-1-i] == '1') {
            result[result.size()-1-i] = 1;
        }
    }
    return result;
}

int main() {
    int n;
    cout<<"Enter number of bits (n): ";
    cin>>n;
    vector<int> A(n, 0);      
    vector<int> M(n);         
    vector<int> Q(n);         
    int Q_1 = 0;                   
    int Count = n;                 
    
   string m_str, q_str;
    cout << "Enter multiplicand (M): ";
    cin >> m_str;
    cout << "Enter multiplier (Q): ";
    cin >> q_str;
    
    M = stringToBinary(m_str, n);
    Q = stringToBinary(q_str, n);
    
    cout << "\nInitial state:" <<endl;
    printState(A, Q, Q_1, Count);
    
    
    while (Count > 0) {
      
        int Q0 = Q[Q.size()-1];
        if (Q0 == 1 && Q_1 == 0) {           
            A = AddSub(A, M, 1); 
        }
        else if (Q0 == 0 && Q_1 == 1) {   
            A = AddSub(A, M, 0); 
        }
        arithmeticShift(A, Q, Q_1);
        Count--;
        cout<<"\nAfter iteration:"<<endl;
        printState(A, Q, Q_1, Count);
    }
    
    cout<<"\nFinal Result"<<endl;
    cout<<"A: ";
    for (int bit : A)cout<<bit;
    cout<<" Q: ";
    for (int bit : Q) cout<<bit;
    cout<< endl;
    return 0;
}
