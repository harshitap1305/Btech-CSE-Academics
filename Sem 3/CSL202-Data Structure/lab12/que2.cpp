#include <bits/stdc++.h>
using namespace std;

class graph{
public:
void topologicalSort(int node, vector<vector<pair<int, int>>> &adj, vector<bool> &visited, stack<int> &st) {
    visited[node] = true;
    for (auto &neighbor : adj[node]) {
        int nextNode = neighbor.first;
        if (!visited[nextNode]) {
            topologicalSort(nextNode, adj, visited, st);
        }
    }
    st.push(node);
}
vector<int> shortestPathDAG(int v, int s, vector<vector<pair<int, int>>> &adj) {
    stack<int> st;
    vector<bool> visited(v, false);
    for (int i=0;i<v;i++) {
        if (!visited[i]) {
            topologicalSort(i, adj, visited, st);
        }
    }
    vector<int> dist(v, INT_MAX);
    dist[s] = 0; 
    while (!st.empty()) {
        int node = st.top();
        st.pop();
        if (dist[node] != INT_MAX) {
            for (auto &neighbor : adj[node]) {
                int nextNode = neighbor.first;
                int weight = neighbor.second;
                if (dist[node] + weight < dist[nextNode]) {
                    dist[nextNode] = dist[node] + weight;
                }
            }
        }
    }
    return dist;
}
};

int main() {
    int v=5,edges=6,s=0;
    vector<vector<pair<int,int>>> adj(v);
    adj[0].push_back({1,2});
    adj[0].push_back({2,4});
    adj[1].push_back({2,-8});
    adj[1].push_back({3,3});
    adj[2].push_back({4,1});
    adj[3].push_back({4,4});
    graph d;
    vector<int> shortest_path = d.shortestPathDAG(v,0,adj);
    cout<<"Shortest diatance from the source node "<<s<<" to all other vertex is given below"<<endl;
    for(int i=0;i<v;i++)
    {
       cout<<"dis("<<s<<","<<i<<") is : "<<shortest_path[i]<<endl;
    }
    return 0;
}
