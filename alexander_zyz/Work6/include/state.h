#ifndef STATE_H_
#define STATE_H_
#include "suan_png.h"
#include "pxl.h"
#include <set>
#include <vector>
#include <queue>
#define MAXN 2021
#define MAXSIZE 2021
#define _max 0x3f3f3f3f;

class State {
public:
    int pic[MAXSIZE][MAXSIZE];
    int dis[MAXSIZE][MAXSIZE];
    int s[MAXSIZE][MAXSIZE];
    int res;
    State();
    State(State &other);
    State(State &&other);
    ~State();
    State &operator=(State &&other);
    State &operator =(State &other);
    void parse(PNG *p);
    int solve();

};


#endif