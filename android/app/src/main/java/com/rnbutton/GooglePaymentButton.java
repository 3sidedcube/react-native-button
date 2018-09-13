package com.rnbutton;

import android.content.Context;
import android.content.ContextWrapper;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.events.EventDispatcher;

public class GooglePaymentButton extends FrameLayout
{
	public GooglePaymentButton(Context context)
	{
		super(context);
		init();
	}

	public GooglePaymentButton(
		Context context,
		AttributeSet attrs
	)
	{
		super(context, attrs);
		init();
	}

	public GooglePaymentButton(
		Context context,
		AttributeSet attrs,
		int defStyle
	)
	{
		super(context, attrs, defStyle);
		init();
	}

	private void init()
	{
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

	public void setVariety(String variety)
	{
		switch (variety)
		{
			case "black": {
				inflate(getContext(), R.layout.buy_with_googlepay_button, this);
				break;
			}
			case "white": {
				inflate(getContext(), R.layout.buy_with_googlepay_button_white, this);
				break;
			}
			case "whiteOutline": {
				inflate(getContext(), R.layout.buy_with_googlepay_button_no_shadow_white, this);
				break;
			}
		}
	}
}
