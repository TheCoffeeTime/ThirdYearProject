--------------------------------------------------------------------------------------------
Project Title: Who is speaking, Adult or Child?
Last Update: 24/03/2014
By Thanakorn Tuanwachat

Please do not hesitate to contact me if there is a bug found or if there is a discussion
Contact: oak.thanakorn@gmail.com
--------------------------------------------------------------------------------------------
BSD licenses
Copyright (c) , 
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the distribution

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

--------------------------------------------------------------------------------------------

How to use?

- There are 2 possible files which can run. 
		- projectUI.m: The user interface for everything except cross valadation.
		- k-foldCrossValation.m: Use to do a cross validation to test the features, data-samples, 
		  and classifier.

- To run you will need the library. Since I cannot submit all the library (it is too big),
  I have given all my library, data samples, and my code to Ke Chen.

- Simply add every to MATLAB path (all the library, including the sub-folders. Data sample 
	doesn't need to be added to the path. You can give them 

- You will need to change the config files (If you don't know what to change, then only change the path)

WARNING:

- The software is not perfect. I have tested many possibilities but it can still crash. One possible
  scenario is when SVM cannot find the convergence. This shouldn't be the case but if there are
	much data (I only tested with around 400 datas) then the program could give a run time error
	saying that it cannot find a convergence. 
	 