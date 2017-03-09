package com.rnbutton;

import android.support.v7.widget.AppCompatButton;
import android.view.View;
import android.view.ViewGroup;

import com.facebook.react.uimanager.LayoutShadowNode;
import com.facebook.yoga.YogaMeasureFunction;
import com.facebook.yoga.YogaMeasureMode;
import com.facebook.yoga.YogaMeasureOutput;
import com.facebook.yoga.YogaNodeAPI;

/**
 * Created by tim on 19/08/2016.
 */
public class ReactButtonShadowNode extends LayoutShadowNode implements YogaMeasureFunction
{
	private int mWidth;
	private int mHeight;
	private boolean mMeasured;

	public ReactButtonShadowNode()
	{
		setMeasureFunction(this);
	}

	@Override
	public long measure(YogaNodeAPI node, float width, YogaMeasureMode widthMode, float height, YogaMeasureMode heightMode)
	{
		if (!mMeasured)
		{
			ReactButton nodeView = null;

			// Attempt to fix: https://github.com/facebook/react-native/issues/9979 (see my comment there)
			synchronized (getThemedContext())
			{
				nodeView = new ReactButton(getThemedContext());
			}

			final int spec = View.MeasureSpec.makeMeasureSpec(ViewGroup.LayoutParams.WRAP_CONTENT, View.MeasureSpec.UNSPECIFIED);
			nodeView.measure(spec, spec);
			mWidth = nodeView.getMeasuredWidth();
			mHeight = nodeView.getMeasuredHeight();
			mMeasured = true;
		}

		return YogaMeasureOutput.make(mWidth, mHeight);
	}
}
