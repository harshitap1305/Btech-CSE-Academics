#include<iostream>
#include<string>
#include<algorithm>
#include<bitset>
using namespace std;
int binaryToDecimal(const string& binary) {
    int n=binary.length();
    int result=0;
    if(binary[0]=='1')
    {result=-1*(1<<(n-1));}
    
    for(int i=0;i<n;i++)
    {
        if(binary[i]=='1')
        {result+=(1<<(n-1-i));}
    }
    return result;
}
int booth(string &M, string &Q)
{
    int n=M.size();
    int m=binaryToDecimal(M);
    int q=binaryToDecimal(Q);

    int A=0;
    int Q_reg=q;
    int Q_1=0;
    
    int count=n;
    int sign_mask=1<<(n-1);
    int extend_mask=~((1<<n)-1);
    while(count>0)
    {
        int Q_0=Q_reg&1;
        if(Q_0==1 && Q_1==1){ A=A-m;}
        else if(Q_0==0 && Q_1==1){A=A+m;}
        Q_1=Q_0;
        int lsb_A=A&1;
        A=(A>>1);
        if(A & sign_mask) {A|=extend_mask;}
        Q_reg=(Q_reg>>1);
        if(lsb_A){
         Q_reg|=sign_mask;
        }
        else{
            Q_reg&=~sign_mask;
        }
        count--;
    }
    return (A<<n) | (Q_reg &((1<<n)-1));
}

int main()
{
    int n;
    string M, Q;
    
    cout<<"Enter the size:";
    cin>>n;
    cout<<"Enter multiplicand (in binary): ";
    cin>>M;
    cout << "Enter multiplier (in binary): ";
    cin>>Q;

    int result = booth(M,Q);
    cout << "Result: " << result << endl;
    bitset<32> binary(result);
    cout << "Binary representation: " << binary << endl;
    return 0;
}
