#include<bits/stdc++.h>
using namespace std;

class Puzzle{
private:
 const int n = 3;
 vector<vector<int>> goal={
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 0}
  };

  vector<int> dx={-1, 1, 0, 0};
  vector<int> dy={0, 0, -1, 1};

  struct Node{
    vector<vector<int>> state;
    int g,h,f;
    int blankRow, blankCol;
    shared_ptr<Node> parent;
  };

  struct Compare {
    bool operator()(const shared_ptr<Node> &a, const shared_ptr<Node> &b) {
        return a->f > b->f; // Min-heap based on f value
    }
};

int mahattanDistance(vector<vector<int>> &v){
    int distance = 0;
    for(int i=0; i<n; i++) {
        for(int j=0; j<n; j++) {
            if(v[i][j] != 0) {
                int targetRow = (v[i][j] - 1) / n;
                int targetCol = (v[i][j] - 1) % n;
                distance += abs(i - targetRow) + abs(j - targetCol);
            }
        }
    }
    return distance;
}

string serialize(vector<vector<int>> &v) {
    string s;
    for(int i=0; i<n; i++) {
        for(int j=0; j<n; j++) {
            s += to_string(v[i][j]) + ",";
        }
    }
    return s;
}

void printState(const vector<vector<int>> &state) {
    for(const auto &row : state) {
        for(int val : row) {
            if(val == 0) cout<<"_ ";
            else cout<<val<<" ";
        }
        cout<<endl;
    }
    cout<<endl;
}

void reconstructPath(shared_ptr<Node> node) {
    vector<vector<vector<int>>> path;
    while(node != nullptr) {
        path.push_back(node->state);
        node = node->parent;
    }
    reverse(path.begin(), path.end());
    for(auto &state : path) {
        printState(state);
    }
}

public: 
void solvePuzzle(vector<vector<int>> &v){
    priority_queue<shared_ptr<Node>, vector<shared_ptr<Node>>,Compare> minHeap;
    unordered_set<string> visited;

    auto startNode= make_shared<Node>();
    startNode->state = v;
    startNode->g = 0;
    startNode->h = mahattanDistance(v);
    startNode->f = startNode->g + startNode->h;
    
    for(int i=0;i<n;i++)
    {
        for(int j=0;j<3;j++)
        {
            if(v[i][j]==0)
            {
                startNode->blankRow = i;
                startNode->blankCol = j;
                break;
            }
        }
    }
    minHeap.push(startNode);

    while(!minHeap.empty())
    {
        auto currNode=minHeap.top(); minHeap.pop();
        if(currNode->state == goal)
        {
            cout<<"Solution found:\n";
            reconstructPath(currNode);
            return;
        }

        visited.insert(serialize(currNode->state));
        for(int i=0;i<4;i++)
        {
            int nRow=currNode->blankRow+dx[i];
            int nCol=currNode->blankCol+dy[i];

            if(nRow>=0 && nRow<n && nCol>=0 && nCol<n)
            {
                auto nextNode = make_shared<Node>();
                nextNode->state = currNode->state;
                swap(nextNode->state[currNode->blankRow][currNode->blankCol], nextNode->state[nRow][nCol]);

                string serialized= serialize(nextNode->state);
                if(visited.count(serialized)) continue;

                nextNode->g = currNode->g + 1;
                nextNode->h = mahattanDistance(nextNode->state);
                nextNode->f = nextNode->g + nextNode->h;
                nextNode->blankRow = nRow;
                nextNode->blankCol = nCol;
                nextNode->parent = currNode;    

                minHeap.push(nextNode);
            }
        }
    }
    cout<<"No solution found.\n";
}
};

int main() {
    vector<vector<int>> v(3,vector<int>(3,0));
    cout<<"Enter 3x3 matrix elements (from 0 to 8, each number appearing only once):\n";
    for(int i=0;i<3;i++) {
        for(int j=0;j<3;j++) {
            cin>>v[i][j];
        }
    }
    Puzzle p;
    p.solvePuzzle(v);

    cout<<"End of program.\n";
    return 0;
}