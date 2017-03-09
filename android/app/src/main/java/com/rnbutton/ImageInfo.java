package com.rnbutton;

import com.facebook.imagepipeline.image.QualityInfo;

/**
 * Simple implementation of ImageInfo, only providing width & height
 */
class ImageInfo implements com.facebook.imagepipeline.image.ImageInfo
{
	private int mWidth;
	private int mHeight;

	public ImageInfo(int width, int height)
	{
		mWidth = width;
		mHeight = height;
	}

	@Override
	public int getWidth()
	{
		return mWidth;
	}

	@Override
	public int getHeight()
	{
		return mHeight;
	}

	@Override
	public QualityInfo getQualityInfo()
	{
		return null;
	}
}
