#!/bin/sh

#  MemLookup.sh
#  RAM Activity
#
#  Created by Luis Matute on 11/5/14.
#  Copyright (c) 2014 Luis Matute. All rights reserved.
/usr/bin/top -l 1 | /usr/bin/grep PhysMem: | awk '{print $2" "$6}'