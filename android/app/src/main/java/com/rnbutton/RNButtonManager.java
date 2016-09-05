package com.rnbutton;

import android.graphics.Color;
import android.support.annotation.Nullable;
import android.widget.Button;

import com.facebook.react.uimanager.LayoutShadowNode;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

public class RNButtonManager extends SimpleViewManager<Button>
{
	public static final String REACT_CLASS = "RNButton";

	@Override
	public String getName()
	{
		return REACT_CLASS;
	}

	@Override
	public LayoutShadowNode createShadowNodeInstance()
	{
		return new RNButtonNode();
	}

	@Override
	public Button createViewInstance(ThemedReactContext context)
	{
		return new Button(context);
	}

	@Override
	public Class getShadowNodeClass()
	{
		return RNButtonNode.class;
	}

	@ReactProp(name = "title")
	public void setText(Button button, @Nullable String title)
	{
		button.setText(title);
	}

	@ReactProp(name = "textColor",
	           defaultInt = Color.BLACK,
	           customType = "Color")
	public void setTextColor(Button button, int textColor)
	{
		button.setTextColor(textColor);
	}
}
