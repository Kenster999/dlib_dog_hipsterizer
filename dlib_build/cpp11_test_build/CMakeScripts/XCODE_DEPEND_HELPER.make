# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.cpp11_test.Debug:
/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/cpp11_test_build/Debug/libcpp11_test.a:
	/bin/rm -f /Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/cpp11_test_build/Debug/libcpp11_test.a


PostBuild.cpp11_test.Release:
/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/cpp11_test_build/Release/libcpp11_test.a:
	/bin/rm -f /Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/cpp11_test_build/Release/libcpp11_test.a


PostBuild.cpp11_test.MinSizeRel:
/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/cpp11_test_build/MinSizeRel/libcpp11_test.a:
	/bin/rm -f /Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/cpp11_test_build/MinSizeRel/libcpp11_test.a


PostBuild.cpp11_test.RelWithDebInfo:
/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/cpp11_test_build/RelWithDebInfo/libcpp11_test.a:
	/bin/rm -f /Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/cpp11_test_build/RelWithDebInfo/libcpp11_test.a




# For each target create a dummy ruleso the target does not have to exist
