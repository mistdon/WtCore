//
//  EXTScope.m
//  extobjc
//
//  Created by Justin Spahr-Summers on 2011-05-04.
//  Copyright (C) 2012 Justin Spahr-Summers.
//  Released under the MIT license.
//

#import "WtEXTScope.h"

void rac_executeCleanupBlock(__strong rac_cleanupBlock_t *block) {
  (*block)();
}