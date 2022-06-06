#include "vector.h"
#include <string>
#include <iostream>
#include <cstdlib>
int vector::insert(Worker *new_worker) {
    if(length!=size){
        data[length++]=new_worker;
        return 0;
    }
    expand();
    data[length++] = new_worker;
    return 1;
}
Worker *vector::remove(int index) {
    try{
        if (!(index >= 0 && index < length)) throw 1;
        Worker* op = data[index];
        data[index] = NULL;
        for (int i = index; i < length - 1; i++)
            data[i] = data[i + 1];
        data[length] = NULL;
        length--;
        return op;
    }catch(...){
        return NULL;
    } 
}
Worker *vector::get(int index)
{
    if (!(index >= 0 && index < length))
        return NULL;
    return data[index];
}
vector::~vector() {
    for (int i = 0; i < length; i++) {
        delete *(data+i);
    }
    free(data);
}

vector::vector(int input_size) {
    size = input_size;
    length = 0;
    data = (Worker **)calloc(sizeof(Worker *), input_size);
}

void vector::expand() {
    size = size * 2;
    data = (Worker **)realloc(data, sizeof(Worker *) * size);
    return;
}

void vector::print() {
    std::cout << "Current vector:\n";
    for (int i = 0; i < length; i++) {
        std::cout << "[" << i << "] ";
        (*(data+i))->print();
    }
    std::cout << "Current vector Ends\n";
}
