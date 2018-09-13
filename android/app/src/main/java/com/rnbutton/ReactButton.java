package com.rnbutton;

import android.content.Context;
import android.content.ContextWrapper;
import android.graphics.drawable.Drawable;
import android.support.annotation.Nullable;
import android.support.v7.widget.AppCompatButton;
import android.view.View;
import com.facebook.drawee.drawable.ScalingUtils;
import com.facebook.drawee.generic.GenericDraweeHierarchyBuilder;
import com.facebook.drawee.view.DraweeHolder;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.events.EventDispatcher;

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

		setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				Context baseContext = v.getContext();

				while (baseContext instanceof ContextWrapper)
				{
					if (baseContext instanceof ReactContext)
					{
						ReactContext reactContext = (ReactContext) baseContext;
						EventDispatcher eventDispatcher = reactContext.getNativeModule(UIManagerModule.class).getEventDispatcher();
						eventDispatcher.dispatchEvent(new OnClickEvent(v.getId(), null));
						break;
					}
					else
					{
						baseContext = ((ContextWrapper) baseContext).getBaseContext();
					}
				}
			}
		});
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
