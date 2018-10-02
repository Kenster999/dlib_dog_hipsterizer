# dlib static library and `dnn_mmod_dog_hipsterizer` for iOS 11.4

**Date:** 2018-10-02

---

This Xcode project shows how to build dlib for iOS 11.4 and use it in the `dnn_mmod_dog_hipsterizer` project. The way I got this working was to make dlib a separate project in Xcode; compile it to a resulting file (libdlib.a); and then copy that file into any other project that wants to use it.

See [http://dlib.net](http://dlib.net) for the main dlib project documentation and API reference. The "Dog Hipsterizer" home page is located at http://blog.dlib.net/2016/10/hipsterize-your-dog-with-deep-learning.html.


## Credits / License
All credits for dlib and the "dog hipsterizer" projects are as given with their distribution. My changes (`dnn_mmod_dog_hipsterizer.h/.mm`) are distributed under the [MIT License](https://choosealicense.com/licenses/mit/).


## Assumptions / Setup
- These files are targeted to iOS 11.4 (and my iPhone X).
- Language: Objective-C.
- dlib source files are version 19.15.
- You can build a debug or release version as desired.
- On my system, the `dlib_build` directory is located at:
`/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build`
Adjust the project and target settings accordingly for your system.
- **Note:** the project and target settings took a fair amount of experimentation to get working correctly with no warnings. Be careful to note any changes you make. When editing the "Build Settings" I found it useful to choose `Customized` and `Levels`.

## Setup 
1. Download all of the files.
2. Put the `dlib_build` directory wherever as desired.


## Compiling the static library
1. Open dlib.xcodeproj to begin.
2. In the main Xcode toolbar, choose the "dlib" scheme and the appropriate target (such as your phone for testing).
3. You can edit the `dlib` scheme to toggle between debug and release mode. You can build for either mode and use the resulting libdlib.a static library in your separate project. If you choose release mode, then the library will be faster but you will not be able to debug into it.
4. Build the project.

The result will be a file named `libdlib.a`. On my system, it is located at:
`/Users/ken/projects/dlib/v-19.15-Xcode/dlib-19.15/examples/build/dlib_build/Debug-iphoneos/libdlib.a`


## Create new project to use the library
1. Download my modified `dnn_mmod_dog_hipsterizer.h` and `dnn_mmod_dog_hipsterizer.mm` and add them to your project.
2. Get the dog model from here and unzip it back to its original `.dat` format:
`http://dlib.net/files/mmod_dog_hipsterizer.dat.bz2`
3. Add the `mmod_dog_hipsterizer.dat` file to your project.
4. Drag the `libdlib.a` file from a Finder window into the Xcode project "Project Navigator" pane. I usually put it at the top level of the project (ie, same level as `AppDelegate.h/.m` and `Main.storyboard`).
5. When you drop the file into Xcode, choose these options:
- [x] Copy items if needed
- [x] Create groups
- [ ] Create folder references   *(ie, this option not selected)*
- Add to whichever targets will directly use the library


## Calling the library
1. In the `.m` file where you want to use this, add an import statement:
`#import "dnn_mmod_dog_hipsterizer.h"`
2. I created a function called `loadDataFromPath` which you call once to load the dog model data (rather than the original source code which loaded it upon each call to recognize). Call this function once during your app's startup:
```
NSURL *datUrl = [[NSBundle mainBundle] URLForResource:@"mmod_dog_hipsterizer" withExtension:@"dat"];
loadDataFromPath(datUrl.path);
```
3. Normal image sizes are way too big to work on an iPhone, so you need to shrink them down dramatically. Currently, I use some code that reduces standard camera images down to 10% of their size, using code like this:
```
+ (CGImageRef)shrinkCGImage:(CGImageRef)image
{

size_t width = CGImageGetWidth(image) / 10;
size_t height = CGImageGetHeight(image) / 10;

// create context, keeping original image properties
CGColorSpaceRef colorspace = CGImageGetColorSpace(image);
CGContextRef context = CGBitmapContextCreate(NULL, width, height,
CGImageGetBitsPerComponent(image),
CGImageGetBytesPerRow(image),
colorspace,
CGImageGetAlphaInfo(image));
CGColorSpaceRelease(colorspace);

if (context == NULL)
return nil;

// Draw image to context (resizing it)
CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
// Extract resulting image from context
CGImageRef imgRef = CGBitmapContextCreateImage(context);
CGContextRelease(context);

return imgRef;

}  // +shrinkCGImage:
````
My code currently just resizes pictures to 10% because that was a quick decision for development purposes. It should be more sophisticated, either testing how much memory is available or using a preset ratio based on the phone model. I haven't written that yet, so you'll need to come up with something that works for you.
4. Use code like this to actually call the recognizer:
```
CGImageRef imageCGI = photo.CGImageRepresentation;  // or some other CGImageRef source

// Create a random filename based on the time; use another method if desired
NSTimeInterval epochInterval = [[NSDate date] timeIntervalSince1970];
NSString *epochString = [NSString stringWithFormat:@"%f.jpg", epochInterval];
NSString *tempJpgPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:epochString];
NSLog(@"Writing tiny jpg to: %@", tempJpgPath);

// Shrink to tiny, write to disk so it can be analyzed
CGImageRef tinyImage = [YourClass shrinkCGImage:imageCGI];  // as shown above

// Write the tiny version to disk
UIImage *tinyUiImage = [UIImage imageWithCGImage:tinyImage];
NSData *tinyJpgData = UIImageJPEGRepresentation(tinyUiImage, 1.0f);
NSError *writeError = nil;
if (![tinyJpgData writeToFile:tempJpgPath options:NSDataWritingAtomic error:&writeError])
{
NSLog(@"Error writing image to disk: %@. %@:%@. %i", writeError.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);
return;
}

// Now do the recognition
MxFaceLandmarksType faceLandmarks;  // this is defined in dnn_mmod_dog_hipsterizer.h
if (mainRecognize(tempJpgPath, &faceLandmarks))
{
NSLog(@"Dog face landmarks: top = %@", NSStringFromCGPoint(faceLandmarks.top));
// Do whatever other processing you want here
}
else
{
NSLog(@"No dog face detected!");
}

// Add code to delete the tiny image file so the device doesn't fill up with them.
```


## Notes on `dnn_mmod_dog_hipsterizer.mm`
1. The `dnn_mmod_dog_hipsterizer.mm` source code is my initial modification of the original `dnn_mmod_dog_hipsterizer.cpp` source code. I'm not very proficient in C++, so please excuse any lameness you spot. :)
2. The `mainRecognize` function returns YES if it found a dog face, or NO if not. If YES, then the second parameter will include the key points for the first dog face found. The code should be expanded to allow you to fetch each face (when there is more than one). `mainRecognize` should probably be changed to return the number of faces found, and save the results so that additional faces can be retrieved without re-recognizing the image.
3. The souce code includes most of the original source commented out. I did that as a safeguard while modifying the C++ code. Feel free to delete any obviously unused code.
4. Also notice that `dnn_mmod_dog_hipsterizer.h` uses this (and its closing pair) to ensure that the C++ functions can be called from Objective-C:
```
#ifdef __cplusplus
extern "C" {
#endif
```

## Performance

On my iPhone X, with clear lighting and a steady hand (ie, minimal focusing required), I found that the library can analyze about 1.6 images per second (16 images per 10 seconds).


## Conclusion
This solution is obviously still early stages, but hopefully it'll be enough to get you started.
