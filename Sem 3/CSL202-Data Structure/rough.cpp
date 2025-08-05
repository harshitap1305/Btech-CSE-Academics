#include<iostream>
using namespace std;

class PriorityQueue {
   int* heap; // Pointer to the heap array
   int size;  // Number of elements in the heap
   int capacity; // Capacity of the heap

public:
   PriorityQueue(int capacity) {
      this->capacity = capacity;
      heap = new int[capacity]; // Allocate memory for heap array
      size = 0; // Initialize heap size to 0
   }

   int parent(int i) {
      return (i - 1) / 2;
   }

   int leftChild(int i) {
      return 2 * i + 1;
   }

   int rightChild(int i) {
      return 2 * i + 2;
   }

   void heapify(int i) {
      int largest = i;
      int left = leftChild(i);
      int right = rightChild(i);

      if (left < size && heap[left] > heap[largest]) {
         largest = left;
      }
      if (right < size && heap[right] > heap[largest]) {
         largest = right;
      }
      if (largest != i) {
         swap(heap[i], heap[largest]);
         heapify(largest);
      }
   }

   void Insert(int x) {
      if (size == capacity) {
         cout << "Heap is full!" << endl;
         return;
      }

      // Insert the new element at the end
      size++;
      int i = size - 1;
      heap[i] = x;

      // Fix the max heap property if violated
      while (i != 0 && heap[parent(i)] < heap[i]) {
         swap(heap[i], heap[parent(i)]);
         i = parent(i);
      }
   }

   int Maximum() {
      if (size <= 0) {
         cout << "Heap is empty, insert some elements" << endl;
         return -1;
      }
      return heap[0];
   }

   int extractMax() {
      if (size <= 0) {
         cout << "Heap is empty" << endl;
         return -1;
      }
      if (size == 1) {
         size--;
         return heap[0];
      }

      // Store the maximum value, remove it from the heap, and fix the heap
      int max = heap[0];
      heap[0] = heap[size - 1];
      size--;
      heapify(0);

      return max;
   }

   void increaseKey(int i, int key) {
      if (key < heap[i]) {
         cout << "The given key is smaller than the current key" << endl;
         return;
      }

      heap[i] = key;
      while (i != 0 && heap[parent(i)] < heap[i]) {
         swap(heap[i], heap[parent(i)]);
         i = parent(i);
      }
   }

   void printHeap() {
      for (int i = 0; i < size; ++i) {
         cout << heap[i] << " ";
      }
      cout << endl;
   }

   ~PriorityQueue() {
      delete[] heap; // Free the allocated memory
   }
};

int main() {
   int n;
   cout << "Enter the size of the array: ";
   cin >> n;

   PriorityQueue h(n);

   cout << "Enter the elements of array: " << endl;
   for (int i = 0; i < n; i++) {
      int x;
      cin >> x;
      h.Insert(x);
   }

   cout << "After inserting all elements:" << endl;
   h.printHeap();

   cout << "Enter an element to insert: ";
   int x;
   cin >> x;
   h.Insert(x);
   cout << "After inserting:" << endl;
   h.printHeap();

   cout << "The max is: " << h.Maximum() << endl;

   cout << "Extracting maximum element: " << h.extractMax() << endl;
   cout << "After extracting max:" << endl;
   h.printHeap();

   int i, y;
   cout << "Enter the position and key for increase key function: ";
   cin >> i >> y;
   h.increaseKey(i, y);
   cout << "After increasing key:" << endl;
   h.printHeap();

   return 0;
}
