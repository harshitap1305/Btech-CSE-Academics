#include<bits/stdc++.h>
using namespace std;

enum CacheState {INVALID,SHARED,EXCLUSIVE,MODIFIED };
enum Operation {READ,WRITE};
string stateToString(CacheState state){
    switch(state){
        case INVALID: return "INVALID";
        case SHARED: return "SHARED";
        case EXCLUSIVE: return "EXCLUSIVE";
        case MODIFIED: return "MODIFIED";
        default: return "UNKNOWN";
    }
}
class CacheSystem {
private:
    vector<CacheState> cacheStates;
    int numCaches;

public:
    CacheSystem(int numCaches):numCaches(numCaches) {
    
        cacheStates.resize(numCaches, INVALID);
    }
    void processRead(int processor) {
    
        bool otherModified = false;
        bool otherValid = false;
        
        switch (cacheStates[processor]) {
            case INVALID:
                for (int i = 0; i < numCaches; i++) {
                    if (i == processor) continue;
                    
                    if (cacheStates[i] == MODIFIED) {
                       
                        otherModified = true;
                        cacheStates[i] = SHARED; 
                    } else if (cacheStates[i] == EXCLUSIVE) {
                
                        cacheStates[i] = SHARED;
                        otherValid = true;
                    } else if (cacheStates[i] == SHARED) {
                    
                        otherValid = true;
                    }}
            
                if (otherModified || otherValid) {
                    cacheStates[processor] = SHARED;
                }
                 else {
                    cacheStates[processor] = EXCLUSIVE;
                }
                break;
                
            case SHARED:
                break;
            case EXCLUSIVE:
                break;
            case MODIFIED:
                break;
        }
    }

    void processWrite(int processor) {
        switch (cacheStates[processor]) {
            case INVALID:
                
                for (int i = 0; i < numCaches; i++) {
                    if (i == processor) continue;
                    cacheStates[i] = INVALID;
                }
                cacheStates[processor] = MODIFIED;
                break;
                
            case SHARED:
               
                for (int i = 0; i < numCaches; i++) {
                    if (i == processor) continue;
                    cacheStates[i] = INVALID;
                }
                cacheStates[processor] = MODIFIED;
                break;
                
            case EXCLUSIVE:
                cacheStates[processor] = MODIFIED;
                break;
                
            case MODIFIED:
                break;
        }
    }
    void displayStates() {
        for (int i=0;i<numCaches;i++) {
        cout<<"C"<<(i + 1) << ": " << stateToString(cacheStates[i]) << std::endl;
        }
    }
};

int main() {
    CacheSystem cacheSystem(4);
    int a, c;
    char b;
    while (true) {
        cout <<"Enter input triple(a,b,c):";
      cin>>a>>b>>c;
        if (a<1||a>4) {
        cout<<"Invalid processor number."<<endl;
            continue;
        }
        
        if (b != 'R' && b != 'W') {
            cout<<"Invalid operation."<<endl;
            continue;
        }
        
        if (c != 0&& c != 1) {
            cout<<"Invalid"<<endl;
            continue;
        }
        int processor=a-1;
        if (b=='R') {
            cacheSystem.processRead(processor);
        } else {
            cacheSystem.processWrite(processor);
        }
        cout <<"Cache States:"<<endl;
        cacheSystem.displayStates();
        
       
        if (c==0) {
            cout <<"program terminated"<<endl;
            break;
        }
    }
    
    return 0;
}