#include <bits/stdc++.h>
using namespace std;

class Solution
{
public:
    pair<int,vector<pair<int,int>>> spanningTree(int V,vector<vector<int>> adj[])
    {
        priority_queue<pair<int,pair<int,int>>,vector<pair<int, pair<int, int>>>,greater<pair<int, pair<int, int>>>> pq;

        vector<int> vis(V,0);
        vector<pair<int, int>> mstEdges;
        int sum=0;
        pq.push({0,{0,-1}});
        while (!pq.empty())
        {
            auto it=pq.top();
            pq.pop();
            int wt=it.first;
            int node=it.second.first;
            int parent=it.second.second;
            if (vis[node]==1)
                continue;
            vis[node] = 1;
            sum+=wt;
            if (parent!=-1)
            {
                mstEdges.push_back({parent, node});
            }

            for (auto it:adj[node])
            {
                int adjNode=it[0];
                int edW=it[1];
                if (!vis[adjNode])
                {
                    pq.push({edW, {adjNode, node}});
                }
            }
        }
        return {sum,mstEdges};
    }
};

int main()
{
    int V = 5;
    vector<vector<int>> edges={{0,1,2},{0,2,1},{1,2,1},{2,3,2},{3,4,1},{4,2,2}};
    vector<vector<int>> adj[V];
    for (auto it : edges)
    {
        vector<int> tmp(2);
        tmp[0] = it[1];
        tmp[1] = it[2];
        adj[it[0]].push_back(tmp);
        tmp[0] = it[0];
        tmp[1] = it[2];
        adj[it[1]].push_back(tmp);
    }

    Solution obj;
    auto result = obj.spanningTree(V, adj);
    int sum = result.first;
    auto mstEdges = result.second;

    cout << "The sum of all the edge weights: " << sum << endl;
    cout << "The edges in the Minimum Spanning Tree are:" << endl;
    for (auto edge : mstEdges)
    {
        cout << edge.first << "--" << edge.second << endl;
    }

    return 0;
}
