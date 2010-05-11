/*
 *  pontilizeDot.cpp
 *  ImageFun
 *
 *  Created by latrokles on 5/10/10.
 *  Copyright 2010 Samurai Hipppo Labs. All rights reserved.
 *
 */

#include "pontilizeDot.h"
pontilizeDot::pontilizeDot(){
    
}
pontilizeDot::~pontilizeDot(){
    
}

void pontilizeDot::init(int x, int y, int r, int g, int b, int size){
    position.set(x, y);
    red    = r;
    green  = g;
    blue   = b;
    radius = size;
}

void pontilizeDot::draw(){
    ofSetColor(red, green, blue);
    ofCircle(position.x, position.y, radius);
    ofSetColor(255, 255, 255);
}