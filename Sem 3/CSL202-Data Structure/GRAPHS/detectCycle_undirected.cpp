#include<bits\stdc++.h>
using namespace std;
class cycleDetectionUsing_BFS{
    public:
    // Function to detect cycle in an undirected graph USING BFS.
    bool detectCycle(vector<vector<int>>& adj, int start, vector<int> &visited)
    {
       queue<pair<int,int>> q;
       q.push({start,-1});
       visited[start]=1;
       while(!q.empty())
       {
           int node=q.front().first;
           int parent=q.front().second;
           q.pop();
           for(int i=0;i<adj[node].size();i++)
           {
               if(!visited[adj[node][i]])
               {
                   visited[adj[node][i]]=1;
                   q.push({adj[node][i],node});
               }
               else if(parent!=adj[node][i])
               {
                   return true;
               }
           }
       }
       return false;
    }
    bool isCycle(vector<vector<int>>& adj) {
        // Code here
        vector<int> visited(adj.size(),0);
        for(int i=0;i<adj.size();i++)
        {
            if(!visited[i])
            {
                if(detectCycle(adj,i,visited)==true)
                {
                    return true;
                }
            }
        }
        return false;
    }
};
class cycleDetectionUsing_DFS{
    
};

int main()
{
    return 0;
}