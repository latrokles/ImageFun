/*
 *  pontilizeDot.h
 *  ImageFun
 *
 *  Created by latrokles on 5/10/10.
 *  Copyright 2010 Samurai Hipppo Labs. All rights reserved.
 *
 */

#pragma once
#include "ofMain.h"

class pontilizeDot{
public:
    pontilizeDot();
    ~pontilizeDot();
    
    void init(int x, int y, int r, int g, int b, int size);
    void draw();
    
private:
    ofPoint position;
    int     radius;
    int     red, green, blue;
};