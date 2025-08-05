#include <iostream>
#include <chrono>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <vector>
using namespace std;
void insertionSort(vector<int> &a, int n) {
    for (int i = 0; i < n; i++) {
        int j = i;
        while (j > 0 && a[j - 1] > a[j]) {
            swap(a[j - 1], a[j]);
            j--;
        }
    }
}
void bubbleSort(vector<int> &a, int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (a[j] > a[j + 1]) {
                swap(a[j], a[j + 1]);
            }
        }
    }
}
void merge(vector<int> &a, int left, int mid, int right) {
    vector<int> temp;
    int low = left;
    int high = mid + 1;
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

void mergeSort(vector<int> &a, int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        mergeSort(a, left, mid);
        mergeSort(a, mid + 1, right);
        merge(a, left, mid, right);
    }
}
void heapify(vector<int> &a, int n, int i) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    if (left < n && a[left] > a[largest])
        largest = left;
    if (right < n && a[right] > a[largest])
        largest = right;
    if (largest != i) {
        swap(a[i], a[largest]);
        heapify(a, n, largest);
    }
}
void heapSort(vector<int> &a, int n) {
    for (int i = n / 2 - 1; i >= 0; i--) {
        heapify(a, n, i);
    }
    for (int i = n - 1; i > 0; i--) {
        swap(a[0], a[i]);
        heapify(a, i, 0);
    }
}
void generateRandomArray(int arr[], int n) {
    srand(time(0));
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % 100000;
    }
}
template <typename Func>
double measureTime(Func func, vector<int> &arr) {
    auto start = chrono::high_resolution_clock::now();
    func(arr);
    auto end = chrono::high_resolution_clock::now();
    chrono::duration<double, milli> elapsed = end - start;
    return elapsed.count();
}
void runSortingTests() {
    int sizes[] = {500, 1000, 5000, 10000, 20000, 50000, 100000};
    int numSizes = sizeof(sizes) / sizeof(sizes[0]);
    double insertionTimes[numSizes], mergeTimes[numSizes], bubbleTimes[numSizes], heapTimes[numSizes];
    for (int i = 0; i < numSizes; i++) {
        int n = sizes[i];
        vector<int> arr(n);
        double insertionAvg = 0, mergeAvg = 0, bubbleAvg = 0, heapAvg = 0;
        for (int j = 0; j < 3; j++) {
            generateRandomArray(arr.data(), n);
            insertionAvg += measureTime([&](vector<int> &a) { insertionSort(a, n); }, arr);
            generateRandomArray(arr.data(), n);
            mergeAvg += measureTime([&](vector<int> &a) { mergeSort(a, 0, n - 1); }, arr);
            generateRandomArray(arr.data(), n);
            bubbleAvg += measureTime([&](vector<int> &a) { bubbleSort(a, n); }, arr);
            generateRandomArray(arr.data(), n);
            heapAvg += measureTime([&](vector<int> &a) { heapSort(a, n); }, arr);
        }
        insertionTimes[i] = insertionAvg / 3;
        mergeTimes[i] = mergeAvg / 3;
        bubbleTimes[i] = bubbleAvg / 3;
        heapTimes[i] = heapAvg / 3;
        cout << "Size: " << n << "\n";
        cout << "Insertion Sort Avg Time: " << insertionTimes[i] << " ms\n";
        cout << "Merge Sort Avg Time: " << mergeTimes[i] << " ms\n";
        cout << "Bubble Sort Avg Time: " << bubbleTimes[i] << " ms\n";
        cout << "Heap Sort Avg Time: " << heapTimes[i] << " ms\n\n";
    }
    ofstream file("sorting_results.csv");
    file << "Size,Insertion Sort,Merge Sort,Bubble Sort,Heap Sort\n";
    for (int i = 0; i < numSizes; i++) {
        file << sizes[i] << "," << insertionTimes[i] << "," << mergeTimes[i] << "," << bubbleTimes[i] << "," << heapTimes[i] << "\n";
    }
    file.close();
}
int main() {
    runSortingTests();
    return 0;
}
