package com.rnbutton;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.res.AssetManager;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Build;
import android.support.annotation.Nullable;
import android.support.v4.view.ViewCompat;
import android.support.v7.widget.AppCompatButton;
import android.util.Log;
import android.view.View;

import com.facebook.react.bridge.ReactContext;
import com.facebook.react.uimanager.LayoutShadowNode;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.ViewProps;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.EventDispatcher;
import com.facebook.react.views.text.ReactFontManager;

public class ReactButtonManager extends SimpleViewManager<AppCompatButton>
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
	public AppCompatButton createViewInstance(ThemedReactContext context)
	{
		AppCompatButton button;
		try
		{
			button = new AppCompatButton(context);
		}
		catch (Exception ex)
		{
			Log.e("3SC", "Unexpected error when creating button", ex);
			return null;
		}

		button.setOnClickListener(new View.OnClickListener()
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
	public void setBackgroundColor(AppCompatButton button, int bgColor)
	{
		if (bgColor == Color.TRANSPARENT && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
		{
			button.setBackgroundResource(R.drawable.btn_borderless_material);
		}
		else
		{
			if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
			{
				button.setBackgroundResource(R.drawable.btn_default_material);
			}

			ViewCompat.setBackgroundTintList(button, ColorStateList.valueOf(bgColor));
		}
	}

	@ReactProp(name = "color",
	           defaultInt = Color.BLACK,
	           customType = "Color")
	public void setColor(AppCompatButton button, int textColor)
	{
		button.setTextColor(textColor);
	}

	@ReactProp(name = ViewProps.ENABLED,
	           defaultBoolean = true)
	public void setEnabled(AppCompatButton button, boolean enabled)
	{
		button.setEnabled(enabled);
		button.setAlpha(enabled ? 1f : 0.3f);
	}

	@ReactProp(name = "fontFamily")
	public void setFontFamily(AppCompatButton button, String fontFamily)
	{
		AssetManager assetManager = button.getContext().getAssets();
		int style = Typeface.NORMAL;

		Typeface prevTypeface = button.getTypeface();
		if (prevTypeface != null)
		{
			style = prevTypeface.getStyle();
		}

		Typeface typeface = ReactFontManager.getInstance().getTypeface(fontFamily, style, assetManager);
		button.setTypeface(typeface);
	}

	@ReactProp(name = "title")
	public void setText(AppCompatButton button, @Nullable String title)
	{
		button.setText(title);
	}

	@ReactProp(name = "textAllCaps",
	           defaultBoolean = true)
	public void setTextAllCaps(AppCompatButton button, boolean allCaps)
	{
		button.setSupportAllCaps(allCaps);
	}
}
