What is it?
===========

This ZIP archive or Windows installer contains a build of Hamlib-4.5~git
cross-compiled for MS Windows 64 bit using MinGW under Debian GNU/Linux 10
(nice, heh!).

This software is copyrighted. The library license is LGPL, and the *.EXE files
licenses are GPL.  Hamlib comes WITHOUT ANY WARRANTY. See the LICENSE.txt,
COPYING.txt, and COPYING.LIB.txt files.

Supporting documentation in the form of Unix manual pages have also been
included after being converted to HTML.


Installation and Configuration
==============================

Extract the ZIP archive into a convenient location, C:\Program Files is a
reasonable choice.

Make sure *all* the .DLL files are in your PATH (leave them in the bin
directory and set the PATH).  To set the PATH environment variable in Windows
2000, Windows XP, and Windows 7 (need info on Vista and Windows 8/10) do the
following:

 * W2k/XP: Right-click on "My Computer"
   Win7: Right-click on "Computer"

 * W2k/XP: Click the "Advanced" tab of the "System Properties" dialog
   Win7: Click the "Advanced system settings" link in the System dialog

 * Click the "Environment Variables" button of the pop-up dialog

 * Select "Path" in the "System variables" box of the "Environment Variables"
   dialog

   NB: If you are not the administrator, system policy may not allow editing
   the path variable.  The complete path to an executable file will need to be
   given to run one of the Hamlib programs.

 * Click the Edit button

 * Now add the Hamlib path in the "Variable Value:" edit box.  Be sure to put
   a semi-colon ';' after the last path before adding the Hamlib path (NB. The
   entire path is highlighted and will be erased upon typing a character so
   click in the box to unselect the text first.  The PATH is important!!)
   Append the Hamlib path, e.g. C:\Program Files\hamlib-w64-4.0~git\bin

 * Click OK for all three dialog boxes to save your changes.


Testing with the Hamlib Utilities
=================================

To continue, be sure you have read the README.betatester file, especially the
"Testing Hamlib" section.  The primary means of testing is by way of the
rigctl utility for radios and rotctl utility for rotators.  Each is a command
line program that is interactive or can act on a single command and exit.

Documentation for each utility can be found as an HTML file in the doc
directory.

In short, the command syntax is of the form:

  rigctl -m 1020 -r COM1 -vvvvv

  -m -> Radio model 1020, or Yaesu FT-817 (use 'rigctl -l' for a list)
  -r -> Radio device, in this case COM1
  -v -> Verbosity level.  For testing four or five v characters are required.
        Five 'v's set a debug level of TRACE which generates a lot of screen
        output showing communication to the radio and values of important
        variables.  These traces are vital information for Hamlib rig backend
        development.

To run rigctl or rotctl open a cmd window (Start|Run|enter 'cmd' in the
dialog).  If text scrolls off the screen, you can scroll back with the mouse.
To copy output text into a mailer or editor (I recommend Notepad++, a free
editor also licensed under the GPL), highlight the text as a rectangle in the
cmd window, press <Enter> (or right-click the window icon in the upper left
corner and select Edit, then Copy), and paste it into your editor with Ctl-V
(or Edit|Paste from the typical GUI menu).

All feedback is welcome to the mail address below.


Uninstall
=========

To uninstall, simply delete the Hamlib directory.  You may wish to edit the
PATH as above to remove the Hamlib bin path, if desired.


Information for w64 Programmers
=================================

The DLL has a cdecl interface.

There is a libhamlib-4.def definition file for MS Visual C++/Visual Studio in
lib/msvc.  Refer to the sample commands below to generate a local
libhamlib-4.lib file for use with the VC++/VS linker.

Simply #include <hamlib/rig.h> (add directory to include path), include
libhamlib-4.lib in your project and you are done.  Note: VC++/VS cannot
compile all the Hamlib code, but the API defined by rig.h has been made MSVC
friendly :-)

As the source code for the library DLLs is licensed under the LGPL, your
program is not considered a "derivative work" when using the published Hamlib
API and normal linking to the front-end library, and may be of a license of
your choosing.

For linking the library with MS Visual C++ 2003, from the directory you
installed Hamlib run the following commands to generate the libhamlib-4.lib
file needed for linking with your MSVC project:

cd lib\msvc
c:\Program Files\Microsoft Visual C++ Toolkit 2003\bin\link.exe /lib /machine:amd64 /def:libhamlib-4.def

To do the same for Visual Studio 2017:

cd lib\msvc
c:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x86\bin\link.exe /lib /machine:i386 /def:libhamlib-4.def

and for VS 2019:

cd lib\msvc
c:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.25.28610\bin\Hostx64\x86\bin\link.exe /lib /machine:i386 /def:libhamlib-4.def

NOTE: feedback is requested on the previous two command examples as these do
not appear to be correct to generate a 64 bit libhamlib-4.lib file!

The published Hamlib API may be found at:

http://hamlib.sourceforge.net/manuals/4.1/index.html


Thank You!
==========

Patches, feedback, and contributions are welcome.

Please report problems or success to hamlib-developer@lists.sourceforge.net

Cheers,
Stephane Fillod - F8CFE
Nate Bargmann - N0NB
http://www.hamlib.org

