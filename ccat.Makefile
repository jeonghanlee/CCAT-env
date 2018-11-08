#
#  Copyright (c) 2018 - Present  Jeong Han Lee
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 

# from 3.6 we can use cmake -H. -B$(BUILD_DIR)
cmake: 
	mkdir -p $(MODULE_BUILD_DIR)
	cd $(MODULE_BUILD_DIR) && cmake ..


autoconf:
	touch ChangeLog
	autoreconf --force --install -v
	./configure 

cmakebuild:
	cd $(MODULE_BUILD_DIR) && make 


cmakeinstall: 
	cd $(MODULE_BUILD_DIR) && make install


# uninstall:
# 	make uninstall


cmakeclean:
	cd $(MODULE_BUILD_DIR) && make clean



autoconfbuild:
	make 


autoconfinstall: 
	make install


autoconfclean:
	make clean


.PHONY: cmake cmakebuild cmakeinstall cmakeclean autoconf autoconfbuild autoconfinstall autoconfclean

