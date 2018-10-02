# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.dlib.Debug:
/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/Debug/libdlib.a:
	/bin/rm -f /Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/Debug/libdlib.a


PostBuild.dlib.Release:
/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/Release/libdlib.a:
	/bin/rm -f /Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/Release/libdlib.a


PostBuild.dlib.MinSizeRel:
/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/MinSizeRel/libdlib.a:
	/bin/rm -f /Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/MinSizeRel/libdlib.a


PostBuild.dlib.RelWithDebInfo:
/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/RelWithDebInfo/libdlib.a:
	/bin/rm -f /Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/RelWithDebInfo/libdlib.a




# For each target create a dummy ruleso the target does not have to exist
