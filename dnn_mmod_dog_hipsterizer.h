//
//  Header.h
//  DogHipTestB
//
//  Created by Ken Spreitzer on 8/27/18.
//  Copyright © 2018 Ken Spreitzer. All rights reserved.
//

#ifndef dnn_mmod_dog_hipsterizer_h
#define dnn_mmod_dog_hipsterizer_h


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


#ifdef __cplusplus
extern "C" {
#endif
	
	typedef struct MxFaceLandmarks_tag
	{
		CGPoint top;
		CGPoint leftEye;
		CGPoint rightEye;
		CGPoint leftEar;
		CGPoint rightEar;
		CGPoint nose;
	} MxFaceLandmarksType;
	
	
	void loadDataFromPath(NSString *dataPath);
	BOOL mainRecognize(NSString *imageFilePath, MxFaceLandmarksType *pFaceLandmarks);

#ifdef __cplusplus
}
#endif


#endif /* dnn_mmod_dog_hipsterizer_h */
