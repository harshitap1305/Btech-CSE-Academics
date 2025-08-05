#include <iostream>
#include <stack>

using namespace std;

class QueueUsingTwoStacks {
private:
    stack<int> stack1; // Used for enqueue
    stack<int> stack2; // Used for dequeue

public:
    // Enqueue operation
    void enqueue(int data) {
        stack1.push(data);
    }

    // Dequeue operation
    int dequeue() {
        if (stack2.empty()) {
            // Move all elements from stack1 to stack2 if stack2 is empty
            if (stack1.empty()) {
                cout << "Queue is empty!" << endl;
                return -1; // Return -1 if queue is empty
            }
            while (!stack1.empty()) {
                stack2.push(stack1.top());
                stack1.pop();
            }
        }
        // Now pop from stack2
        int topValue = stack2.top();
        stack2.pop();
        return topValue;
    }

    // Check if the queue is empty
    bool isEmpty() {
        return stack1.empty() && stack2.empty();
    }

    // Peek the front element of the queue
    int front() {
        if (stack2.empty()) {
            if (stack1.empty()) {
                cout << "Queue is empty!" << endl;
                return -1;
            }
            while (!stack1.empty()) {
                stack2.push(stack1.top());
                stack1.pop();
            }
        }
        return stack2.top();
    }
};

int main() {
    QueueUsingTwoStacks queue;

    queue.enqueue(10);
    queue.enqueue(20);
    queue.enqueue(30);

    cout << "Front element: " << queue.front() << endl; // Output: 10

    cout << "Dequeued: " << queue.dequeue() << endl; // Output: 10
    cout << "Dequeued: " << queue.dequeue() << endl; // Output: 20

    queue.enqueue(40);
    cout << "Front element: " << queue.front() << endl; // Output: 30

    cout << "Dequeued: " << queue.dequeue() << endl; // Output: 30
    cout << "Dequeued: " << queue.dequeue() << endl; // Output: 40
     queue.enqueue(40);
    cout << "Front element: " << queue.front() << endl;
    queue.enqueue(50);
    cout << "Front element: " << queue.front() << endl;
    queue.enqueue(60);
    cout << "Front element: " << queue.front() << endl;
    cout << "Dequeued: " << queue.dequeue() << endl; // Output: 30
    queue.enqueue(70);
    cout << "Front element: " << queue.front() << endl;
    if (queue.isEmpty()) {
        cout << "Queue is empty now!" << endl;
    }

    return 0;
}
