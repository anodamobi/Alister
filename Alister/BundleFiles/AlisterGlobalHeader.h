//
//  AlisterGlobalHeader.h
//  Alister_iOS
//
//  Created by ANODA on 2/8/17.
//  Copyright © 2017 ANODA. All rights reserved.
//

@import UIKit;

#if ALISTER_FRAMEWORK_AVAILABLE
    #import <Masonry/Masonry.h>
#else
    #import "Masonry.h"
#endif
