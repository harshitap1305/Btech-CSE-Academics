#include<bits\stdc++.h>
using namespace std;
class graph{
public:
vector<int> dijkstra(int v,vector<vector<int>> adj[], int s)
{
    priority_queue<pair<int,int>, vector<pair<int,int>>,greater<pair<int,int>>> pq;
    vector<int> distTo(v,INT_MAX);
    distTo[s]=0;
    pq.push({0,s});
    while(!pq.empty())
    {
        int node=pq.top().second;
        int dis=pq.top().first;
        pq.pop();
        for(auto i:adj[node])
        {
            int v=i[0];
            int w=i[1];
            if(dis+w < distTo[v])
            {
                distTo[v]=dis+w;
                pq.push({dis+w,v});
            }
        }
    }
    return distTo;
}
};
int main()
{
    int v=5,edges=6,s=0;
    vector<vector<int>> adj[v];
    adj[0].push_back({1,1});
    adj[0].push_back({3,3});
    adj[1].push_back({3,2});
    adj[1].push_back({4,5});
    adj[1].push_back({2,4});
    adj[3].push_back({4,2});
   

    graph d;
    vector<int> shortest_path = d.dijkstra(v, adj, s);
    cout<<"Shortest diatance from the source node "<<s<<" to all other vertex is given below"<<endl;
    for(int i=0;i<v;i++)
    {
       cout<<"dis("<<s<<","<<i<<") is : "<<shortest_path[i]<<endl;
    }
return 0;
}