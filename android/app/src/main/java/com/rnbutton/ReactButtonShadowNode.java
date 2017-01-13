package com.rnbutton;

import android.support.v7.widget.AppCompatButton;
import android.view.View;
import android.view.ViewGroup;

import com.facebook.csslayout.CSSMeasureMode;
import com.facebook.csslayout.CSSNodeAPI;
import com.facebook.csslayout.MeasureOutput;
import com.facebook.react.uimanager.LayoutShadowNode;

/**
 * Created by tim on 19/08/2016.
 */
public class ReactButtonShadowNode extends LayoutShadowNode implements CSSNodeAPI.MeasureFunction
{
	private int mWidth;
	private int mHeight;
	private boolean mMeasured;

	public ReactButtonShadowNode()
	{
		setMeasureFunction(this);
	}

	@Override
	public long measure(CSSNodeAPI node, float width, CSSMeasureMode widthMode, float height, CSSMeasureMode heightMode)
	{
		if (!mMeasured)
		{
			AppCompatButton nodeView = null;

			// Attempt to fix: https://github.com/facebook/react-native/issues/9979 (see my comment there)
			synchronized (getThemedContext())
			{
				nodeView = new AppCompatButton(getThemedContext());
			}

			final int spec = View.MeasureSpec.makeMeasureSpec(ViewGroup.LayoutParams.WRAP_CONTENT, View.MeasureSpec.UNSPECIFIED);
			nodeView.measure(spec, spec);
			mWidth = nodeView.getMeasuredWidth();
			mHeight = nodeView.getMeasuredHeight();
			mMeasured = true;
		}

		return MeasureOutput.make(mWidth, mHeight);
	}
}
