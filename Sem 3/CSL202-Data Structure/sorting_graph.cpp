#include <iostream>
#include <vector>
#include <chrono>
#include <fstream> // For file handling
using namespace std;
using namespace std::chrono;

void generateInput(vector<int>& arr, int size) {
    arr.clear();
    for (int i = 0; i < size; i++) {
        arr.push_back(rand() % 100000); // Random values between 0 and 100000
    }
}

// Insertion Sort
void insertionSort(vector<int>& arr) {
    int n = arr.size();
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}

// Merge Sort Functions
void merge(vector<int>& a, int left, int mid, int right) {
    vector<int> temp;
    int low = left, high = mid + 1;
    while (low <= mid && high <= right) {
        if (a[low] <= a[high]) {
            temp.push_back(a[low]);
            low++;
        } else {
            temp.push_back(a[high]);
            high++;
        }
    }
    while (low <= mid) {
        temp.push_back(a[low]);
        low++;
    }
    while (high <= right) {
        temp.push_back(a[high]);
        high++;
    }
    for (int i = left; i <= right; i++) {
        a[i] = temp[i - left];
    }
}

void mergeSort(vector<int>& a, int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        mergeSort(a, left, mid);
        mergeSort(a, mid + 1, right);
        merge(a, left, mid, right);
    }
}

// Bubble Sort
void bubbleSort(vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
            }
        }
    }
}

// Heap Sort Functions
void heapify(vector<int>& arr, int n, int i) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < n && arr[left] > arr[largest])
        largest = left;

    if (right < n && arr[right] > arr[largest])
        largest = right;

    if (largest != i) {
        swap(arr[i], arr[largest]);
        heapify(arr, n, largest);
    }
}

void heapSort(vector<int>& arr) {
    int n = arr.size();
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);
    for (int i = n - 1; i >= 0; i--) {
        swap(arr[0], arr[i]);
        heapify(arr, i, 0);
    }
}

// Function to run and time each sort
double timeSort(void (*sortFunc)(vector<int>&), vector<int>& arr) {
    auto start = high_resolution_clock::now();
    sortFunc(arr);
    auto end = high_resolution_clock::now();
    return duration<double, milli>(end - start).count();
}

int main() {
    ofstream file("sorting_results.csv");
    file << "Size,Insertion Sort,Merge Sort,Bubble Sort,Heap Sort\n";

    vector<int> sizes = {500, 1000, 5000, 10000, 20000, 50000, 100000};

    for (int size : sizes) {
        double insertionTime = 0, mergeTime = 0, bubbleTime = 0, heapTime = 0;

        for (int i = 0; i < 3; i++) {
            vector<int> arr;

            // Insertion Sort
            generateInput(arr, size);
            insertionTime += timeSort(insertionSort, arr);

            // Merge Sort
            generateInput(arr, size);
            mergeTime += timeSort([](vector<int>& a) { mergeSort(a, 0, a.size() - 1); }, arr);

            // Bubble Sort
            generateInput(arr, size);
            bubbleTime += timeSort(bubbleSort, arr);

            // Heap Sort
            generateInput(arr, size);
            heapTime += timeSort(heapSort, arr);
        }

        // Calculate average times and write to file
        file << size << "," 
             << insertionTime / 3 << "," 
             << mergeTime / 3 << "," 
             << bubbleTime / 3 << "," 
             << heapTime / 3 << "\n";
    }

    file.close();
    cout << "Results saved to sorting_results.csv" << endl;

    return 0;
}
