#include "hashtable.h"

bool Node::operator!=(const char* str)
{
    if (str == NULL) return false;
    string op(str);
    return op != p.first;
}

bool Node::operator!=(const string& str)
{
    return str == p.first;
}

bool Node::operator==(const char* str)
{
    if (str == NULL) return false;
    string op(str);
    return op == p.first;
}

bool Node::operator==(const string& str)
{
    return str == p.first;
}

bool Node::operator!=(Node& n)
{
    return p.first == n.p.first;
}

bool Node::operator==(Node& n)
{
    return p.first == n.p.first;
}

char Node::operator[](const int index)
{
    return p.first[index];
}

int Node::length()
{ //return length of the string
    return p.first.length();
}

int& Node::second()
{
    return p.second;
}

const pair<string, int>* Node::get_pair() const
{
    const pair<string, int>* op = &p;
    return op;
}

Node::~Node()
{//无需操作
}

HashTable::HashTable()
{
    size = MAXN;
    elem = new Node[size];
    Node op;
    op.second() = 0;
    for (int i = 0; i < MAXN; i++)
    {
        elem[i] = op;
    }
}

HashTable::~HashTable()
{
    size = 0;
    delete[] elem;
}

int HashTable::hash(Node& index)
{
    int length = index.length();
    int ans = 0;
    int op_times = (length <= 5 ? length : length / 2);
    for (int i = 0; i < length; i++)
        ans += (1 << (tolower(index.get_pair()->first[i]) - 'a') % MAXN);
    return ans % MAXN;
}

bool HashTable::search(Node& index, int& pos, int& times)
{
    int sss = hash(index);
    times = 0;
    pos = sss;
    for (int i = sss; times < MAXN; i = (i + 1) % MAXN)
    {
        if (elem[i] == index) {
            pos = i;
            return true;
        }
        else if (elem[i].get_pair()->second == 0) {
            pos = i;
            return false;
        }
        else {
            times++;
        }
    }
    pos = -1;
    return false;
}

int HashTable::insert(Node& index)
{
    int ops, times;
    if (search(index, ops, times))
    {
        elem[ops].second()++;
        return 2;
    }
    else if (ops >= 0)
    {
        elem[ops] = index;
        elem[ops].second() = 1;
        return 1;
    }
    else {
        return -1; //Wrong
    }
}

int HashTable::insert(const char* str)
{
    Node op(str);
    int ops, times;
    if (search(op, ops, times))
    {
        elem[ops].second()++;
        return 2;
    }
    else
    {
        elem[ops] = op;
        elem[ops].second() = 1;
        return 1;
    }
    return -1; //Wrong
}

/*
 ==========================================================================
 =================Please Do Not Modify Functions Below=====================
 ========================请不要修改下列函数实现================================
 ==========================================================================
 */

Node::Node()
{
    p = make_pair(string("#"), 1);
}

Node::Node(const char* str)
{
    p = make_pair(string(str), 1);
}

Node::Node(const string& str)
{
    p = make_pair(str, 1);
}

int HashTable::get_size() const
{
    return size;
}

const pair<string, int>* HashTable::get_pair(int index)
{
    if (index < size && index >= 0)
    {
        return (elem[index].get_pair());
    }
    return NULL;
}

const pair<string, int>* HashTable::get_pair(int index) const
{
    if (index < size && index >= 0)
    {
        return (elem[index].get_pair());
    }
    return NULL;
}
