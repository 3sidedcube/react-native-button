package com.rnbutton;

import android.view.ViewGroup;
import com.facebook.react.uimanager.LayoutShadowNode;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewProps;
import com.facebook.react.uimanager.annotations.ReactProp;

public class ReactPaymentButtonManager extends SimpleViewManager<GooglePaymentButton>
{
	public static final String REACT_CLASS = "RNPaymentButton";

	@Override
	public String getName()
	{
		return REACT_CLASS;
	}

	@Override
	public LayoutShadowNode createShadowNodeInstance()
	{
		return new ReactButtonShadowNode();
	}

	@Override
	public GooglePaymentButton createViewInstance(ThemedReactContext context)
	{
		GooglePaymentButton button = null;

		// Attempt to fix: https://github.com/facebook/react-native/issues/9979 (see my comment there)
		synchronized (context)
		{
			button = new GooglePaymentButton(context);
			button.setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
		}

		return button;
	}

	@Override
	public Class getShadowNodeClass()
	{
		return ReactButtonShadowNode.class;
	}

	@ReactProp(name = ViewProps.ENABLED,
	           defaultBoolean = true)
	public void setEnabled(GooglePaymentButton button, boolean enabled)
	{
		button.setEnabled(enabled);
		button.setAlpha(enabled ? 1f : 0.3f);
	}

	@ReactProp(name = "buttonStyle")
	public void setButtonStyle(GooglePaymentButton button, String style)
	{
		button.setVariety(style);
	}
}
