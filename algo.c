#include <stdio.h>

int line_sum (int * a, size_t size){
    int sum = 0; 
    for (size_t i = 0; i < size; i++){
        sum += a[i];
    }
    return sum;
}

int main(){
    int n = 5, m = 3;
    int a[][5] = {
        {1, 2, 3, 4, 5},
        {1, 3, 3, 0, 0},
        {1, 4, 3, 7, 2}
    };
    int sums[] = {0, 0, 0};

    for (size_t i = 0; i < m; i++){
        sums[i] = line_sum(a[i], n);
    }
    size_t ind_min = 0;

    for (size_t i = 1; i < m; i++){
        if (sums[i] < sums[ind_min]) ind_min = i;
    }

    printf("Строка с минимальным номером: %ld\n", ind_min); 
}