package com.rnbutton;

import android.graphics.drawable.Animatable;
import android.graphics.drawable.Drawable;
import android.support.annotation.Nullable;

import com.facebook.drawee.controller.BaseControllerListener;
import com.facebook.drawee.view.DraweeHolder;
import com.facebook.react.views.toolbar.DrawableWithIntrinsicSize;

/**
 * Attaches specific icon width & height to a BaseControllerListener which will be used to
 * create the Drawable
 */
abstract class ImageControllerListener extends BaseControllerListener<com.facebook.imagepipeline.image.ImageInfo>
{
	private final DraweeHolder mHolder;
	private ImageInfo mImageInfo;

	public ImageControllerListener(DraweeHolder holder)
	{
		mHolder = holder;
	}

	public void setIconImageInfo(ImageInfo imageInfo)
	{
		mImageInfo = imageInfo;
	}

	@Override
	public void onFinalImageSet(String id, @Nullable com.facebook.imagepipeline.image.ImageInfo imageInfo, @Nullable Animatable animatable)
	{
		super.onFinalImageSet(id, imageInfo, animatable);

		final com.facebook.imagepipeline.image.ImageInfo info = mImageInfo != null ? mImageInfo : imageInfo;
		setDrawable(new DrawableWithIntrinsicSize(mHolder.getTopLevelDrawable(), info));
	}

	protected abstract void setDrawable(Drawable d);
}
