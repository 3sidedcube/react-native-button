package com.rnbutton;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.support.annotation.Nullable;
import android.support.v7.widget.AppCompatButton;

import com.facebook.drawee.drawable.ScalingUtils;
import com.facebook.drawee.generic.GenericDraweeHierarchyBuilder;
import com.facebook.drawee.view.DraweeHolder;

/**
 * Created by tim on 09/03/2017.
 */
public class ReactButton extends AppCompatButton
{
	private DraweeHolder mIconLeftHolder;
	private ImageControllerListener mIconLeftControllerListener;

	public ReactButton(Context context)
	{
		super(context);

		mIconLeftHolder = DraweeHolder.create(new GenericDraweeHierarchyBuilder(getResources()).setActualImageScaleType(ScalingUtils.ScaleType.FIT_CENTER)
		                                                                                       .setFadeDuration(0)
		                                                                                       .build(), context);
		mIconLeftControllerListener = new ImageControllerListener(mIconLeftHolder)
		{
			@Override
			protected void setDrawable(Drawable d)
			{
				setCompoundDrawablesWithIntrinsicBounds(d, null, null, null);
			}
		};
	}

	@Override
	public void onDetachedFromWindow()
	{
		super.onDetachedFromWindow();
		detachDraweeHolders();
	}

	@Override
	public void onStartTemporaryDetach()
	{
		super.onStartTemporaryDetach();
		detachDraweeHolders();
	}

	@Override
	public void onAttachedToWindow()
	{
		super.onAttachedToWindow();
		attachDraweeHolders();
	}

	@Override
	public void onFinishTemporaryDetach()
	{
		super.onFinishTemporaryDetach();
		attachDraweeHolders();
	}

	private void detachDraweeHolders()
	{
		mIconLeftHolder.onDetach();
	}

	private void attachDraweeHolders()
	{
		mIconLeftHolder.onAttach();
	}

	/* package */ void setIconLeft(@Nullable String uri, ImageInfo imageInfo)
	{
		ImageHelper.setIconSource(getContext(), uri, imageInfo, mIconLeftControllerListener, mIconLeftHolder);
	}
}
