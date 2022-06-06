#include "heap.h"
#define LEFT true
#define RIGHT false

#define LIST_SIZE 2000

Heap::~Heap() {
    delete[] arr;
    num = 0;
}

Heap::Heap(Heap& other) {
    arr = new Player_info[LIST_SIZE];
    for (int i = 0;i < LIST_SIZE;i++) {
        arr[i] = other.arr[i];
    }
    num = other.get_num();
}

Heap& Heap::operator=(Heap& other) {
    arr = new Player_info[LIST_SIZE];
    for (int i = 0;i < LIST_SIZE;i++) {
        arr[i] = other.arr[i];
    }
    num = other.get_num();
    return *this;

}

void Heap::heapify_up() {
    int op = num - 1;
    if (op < 0) return;
    int v = 0;
    while (true)
    {
        v = get_father(op);
        if (v < 0) //不存在父亲点
            break;
        if (arr[op] < arr[v])
        {
            Player_info oppl = arr[op];
            arr[op] = arr[v];
            arr[v] = oppl;
            op = v;
        }
        else
            break;
    }
}

void Heap::heapify_down() {
    int op = 0;
    int v = 0;
    int vv = 0;
    while (true)
    {
        v = get_child(LEFT, op);
        if (v < 0)
            break;
        vv = get_child(RIGHT, op);
        if (vv != -1 && arr[vv] <= arr[v]) {
            v = vv;
        }
        if (arr[op] > arr[v])
        {
            Player_info oppl = arr[op];
            arr[op] = arr[v];
            arr[v] = oppl;
            op = v;
        }
        else {
            break;
        }
    }
}

int Heap::get_child(bool direction, int index) {
    if (index > num - 1 || index < 0)
    {
        return -1;
    }
    else {
        if (direction == LEFT) {
            if (index * 2 + 1 < num) {
                return index * 2 + 1;
            }
            return -1;
        }
        else {
            if (index * 2 + 2 < num) {
                return index * 2 + 2;
            }
            return -1;
        }
    }
}

int Heap::get_father(int index) {
    if (index > num - 1 || index <= 0) {
        return -1;
    }
    else {
        return (index - 1) / 2;
    }
}

int Heap::insert(Player_info& p) {
    if (num == 0) {
        arr[num] = p;
        num++;
        return 1;
    }
    else if (num < 2000) { //堆未满，向上堆化
        arr[num] = p;
        heapify_up();
        num++;
        return 1;
    }
    else {
        if (p <= arr[0]) return -1; //如果比根元素还小，舍弃
        else {
            arr[0] = p;
            heapify_down(); //向下堆化
        }
    }
    return 0;
}

Player_info* Heap::sort() { //return降序排序arr，执行倒序即可
    int op = num;
    while (true) {
        if (num <= 0) break;
        Player_info op = arr[0];
        arr[0] = arr[num - 1];
        arr[num - 1] = op;
        num--;
        heapify_down();
    }
    num = op;
    Player_info* ans = new Player_info[LIST_SIZE];
    for (int i = 0;i < num;i++)
    {
        ans[i] = arr[i];
    }
    return ans;
}

/*
 =========================================================
 ================ WARNING ===== 警告 ======================
 ===Please Do Not Modify Any of the Following Functions===
 ===================请不要修改以下函数=======================
 =========================================================
 */

int Heap::get_num() const {
    return num;
}

Heap::Heap() {
    num = 0;
    arr = new Player_info[LIST_SIZE];
}

void Heap::print() {
    for (int i = 0; i < num; i++) {
        arr[i].print();
    }
    printf("\nSize of the heap is %d\n", num);
}

Player_info::Player_info() {
    username = std::string("#");
    uid = 0;
    score = 0;
}

Player_info::~Player_info() {

}

Player_info::Player_info(Player_info& other) {
    username = std::string((other.username));
    score = other.score;
    uid = other.uid;
}

Player_info::Player_info(std::string in_name, long in_uid, int in_score) {
    username = std::string(in_name);
    score = in_score;
    uid = in_uid;
}

Player_info& Player_info::operator=(Player_info& other) {
    username = std::string((other.username));
    score = other.score;
    uid = other.uid;
    return *this;
}

int Player_info::get_score() const {
    return score;
}

const std::string& Player_info::get_name() const {
    return username;
}

bool Player_info::operator==(Player_info& other) const {
    if (score == other.score) {
        return true;
    }
    return false;
}

bool Player_info::operator!=(Player_info& other) const {
    if (score == other.score) {
        return false;
    }
    return true;
}

bool Player_info::operator<(Player_info& other) const {
    if (score < other.score) {
        return true;
    }
    return false;
}

bool Player_info::operator<=(Player_info& other) const {
    if (score <= other.score) {
        return true;
    }
    return false;
}

bool Player_info::operator>(Player_info& other) const {
    if (score > other.score) {
        return true;
    }
    return false;
}

bool Player_info::operator>=(Player_info& other) const {
    if (score >= other.score) {
        return true;
    }
    return false;
}

void Player_info::print() {
    printf("[%ld]%s - %d\n", uid, username.c_str(), score);
    return;
}
