#include <bits/stdc++.h>
using namespace std;

vector<int> AddSub(vector<int>& A, vector<int>& B, int op){
    if(A.size()!=B.size()){
        cout<<"Input of different length is not accepted!!"<<endl;
        return vector<int>();
    }
    size_t n=A.size();
    vector<int> res(n);
    int c=op;
    vector<int> B_n=B;
    if(op==1)
    {
        for(size_t i=0;i<n;i++)
        {
            B_n[i]=B_n[i]^1;
        }
    }
    for(int i=n-1;i>=0;i--)
    {
        int sum=A[i]+B_n[i]+c;
        res[i]=sum%2;
        c=sum/2;
    }
    return res;
}


void shiftLeft(vector<int>& A, vector<int>& Q) {
    for (size_t i=0; i<A.size()-1;i++) {
        A[i]=A[i+1];
    }
    A[A.size()-1]=Q[0];

    for (size_t i=0;i<Q.size()-1;i++) {
        Q[i]=Q[i+1];
    }
    Q[Q.size()-1]=0;
}

void printState(const vector<int>& A, const vector<int>& Q, int Count) {
    cout << "A:";
    for (int bit: A) cout << bit;
    cout << "Q:";
    for (int bit : Q) cout << bit;
    cout << " Count: " << Count << endl;
}


vector<int> stringToBinary(const string& str, int n) {
    vector<int> result(n, 0);
    for (size_t i = 0; i<str.length()&&i< static_cast<size_t>(n); i++) {
        if (str[str.length()-1-i]=='1') {
            result[result.size()-1-i]=1;
        }
    }
    return result;
}

int main() {
    int n;
    cout << "Enter number of bits (n): ";
    cin >> n;
    
    vector<int> A(n, 0);      // Accumulator
    vector<int> M(n);         // Divisor
    vector<int> Q(n);         // Dividend/Quotient
    int count = n;            // Counter
    
    string m_str, q_str;
    cout << "Enter divisor (M): ";
    cin >> m_str;
    cout << "Enter dividend (Q): ";
    cin >> q_str;
    
    M = stringToBinary(m_str, n);
    Q = stringToBinary(q_str, n);
    
    cout << "Initial state:" << endl;
    printState(A, Q, count);
    
    
    while (count > 0) {
       
        shiftLeft(A,Q);
        cout<<"After shift left:"<<endl;
        printState(A,Q,count);
        
        vector<int> temp=AddSub(A,M,1);  
        A = temp;
        cout << "After A-M:"<<endl;
        printState(A,Q,count);
    
        if(A[0]==1) {  
            Q[Q.size()-1]=0; 
           
            A = AddSub(A,M,0);  
        } else {
            Q[Q.size()-1]=1;  
        }
        
        count--;
        cout<<"After restoration/setting Q0:"<<endl;
        printState(A,Q,count);
    }
    
    cout << "\nFinal Result" << endl;
    cout << "Quotient (Q): ";
    for (int bit : Q) cout << bit;
    cout << "\nRemainder (A): ";
    for (int bit : A) cout << bit;
    cout << endl;
    
    return 0;
}