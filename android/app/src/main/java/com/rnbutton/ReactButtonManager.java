package com.rnbutton;

import android.content.res.AssetManager;
import android.graphics.Color;
import android.graphics.Typeface;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.Button;

import com.facebook.react.bridge.ReactContext;
import com.facebook.react.uimanager.LayoutShadowNode;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.ViewProps;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.EventDispatcher;
import com.facebook.react.views.text.ReactFontManager;

public class ReactButtonManager extends SimpleViewManager<Button>
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
		return new ReactButtonShadowNode();
	}

	@Override
	public Button createViewInstance(ThemedReactContext context)
	{
		Button button = new Button(context);
		button.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				ReactContext reactContext = (ReactContext) v.getContext();
				EventDispatcher eventDispatcher = reactContext.getNativeModule(UIManagerModule.class).getEventDispatcher();
				eventDispatcher.dispatchEvent(new OnClickEvent(v.getId(), null));
			}
		});
		return button;
	}

	@Override
	public Class getShadowNodeClass()
	{
		return ReactButtonShadowNode.class;
	}

	@Override
	@ReactProp(name = "backgroundColor",
	           defaultInt = Color.TRANSPARENT,
	           customType = "Color")
	public void setBackgroundColor(Button button, int bgColor)
	{
		button.setBackgroundColor(bgColor);
	}

	@ReactProp(name = "color",
	           defaultInt = Color.BLACK,
	           customType = "Color")
	public void setColor(Button button, int textColor)
	{
		button.setTextColor(textColor);
	}

	@ReactProp(name = ViewProps.ENABLED,
	           defaultBoolean = true)
	public void setEnabled(Button button, boolean enabled)
	{
		button.setEnabled(enabled);
	}

	@ReactProp(name = "fontFamily")
	public void setFontFamily(Button button, String fontFamily)
	{
		AssetManager assetManager = button.getContext().getAssets();
		Typeface typeface = ReactFontManager.getInstance().getTypeface(fontFamily, button.getTypeface().getStyle(), assetManager);
		button.setTypeface(typeface);
		assetManager.close();
	}

	@ReactProp(name = "title")
	public void setText(Button button, @Nullable String title)
	{
		button.setText(title);
	}

	@ReactProp(name = "textAllCaps",
	           defaultBoolean = true)
	public void setTextAllCaps(Button button, boolean allCaps)
	{
		button.setAllCaps(allCaps);
	}
}
