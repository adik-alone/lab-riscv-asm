int line_sum (int * a, int size){
    int sum = 0; 
    for (int i = 0; i < size; i++){
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

    for (int i = 0; i < m; i++){
        sums[i] = line_sum(a[i], n);
    }
    int ind_min = 0;

    for (int i = 1; i < m; i++){
        if (sums[i] < sums[ind_min]) ind_min = i;
    }

    return ind_min;
}