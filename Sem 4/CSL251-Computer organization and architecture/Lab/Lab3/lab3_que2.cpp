#include<bits/stdc++.h>
using namespace std;


void add(vector<int>& a,const vector<int>& b,int n) {
    int carry=0;
    for (int i=n-1;i>=0;i--) {
        int c_a=a[i];
        int c_b=b[i];
        a[i]=(c_a+c_b+carry)%2;
        carry=(c_a+c_b+carry)/2;
    }
}
void complement(vector<int>& a,int n) {
    for (int i=0;i<n;i++) {
        a[i]=(a[i]+1)%2;
    }
    vector<int> o(n,0);
    o[n-1]=1;
    add(a,o,n);
}
void shift(vector<int>& a,vector<int>& q,int& Q_m1,int n) {
    int last_a=a[n-1];
    for (int i=n-1;i>0;i--) {
        a[i]=a[i-1];
        q[i]=q[i-1];
    }
    a[0]=a[1];
    q[0]=last_a;
    Q_m1=q[n-1];
}

int main(){
    int n;
    cout << "Enter number of bits (n): ";
    cin >> n;

    vector<int> A(n, 0); // Accumulator
    vector<int> Q(n);    // Multiplier
    vector<int> M(n);    // Multiplicand
    int Qm1 = 0;         // Previous bit of Q

    cout << "Enter the multiplicand (M) in binary: ";
    for (int i = 0; i < n; i++) {
        cin >> M[i];
    }

    cout << "Enter the multiplier (Q) in binary: ";
    for (int i = 0; i < n; i++) {
        cin >> Q[i];
    }

    // Perform Booth's algorithm
    for (int i = 0; i < n; i++) {
        if (Q[n - 1] == 0 && Qm1 == 0) {
            shift(A, Q, Qm1, n);
        } else if (Q[n - 1] == 1 && Qm1 == 0) {
            complement(M, n);
            add(A, M, n);
            complement(M, n);
            shift(A, Q, Qm1, n);
        } else if (Q[n - 1] == 0 && Qm1 == 1) {
            add(A, M, n);
            shift(A, Q, Qm1, n);
        } else if (Q[n - 1] == 1 && Qm1 == 1) {
            shift(A, Q, Qm1, n);
        }
    }

    cout << "Final result in A and Q: ";
    for (int i = 0; i < n; i++) {
        cout << A[i];
    }
    for (int i = 0; i < n; i++) {
        cout << Q[i];
    }
    cout << endl;
    return 0;
}