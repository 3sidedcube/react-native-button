package com.rnbutton;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.net.Uri;

import com.facebook.drawee.backends.pipeline.Fresco;
import com.facebook.drawee.interfaces.DraweeController;
import com.facebook.drawee.view.DraweeHolder;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.uimanager.PixelUtil;

/**
 * Created by tim on 09/03/2017.
 */
public class ImageHelper
{
	private static final String PROP_ICON_URI = "uri";
	private static final String PROP_ICON_WIDTH = "width";
	private static final String PROP_ICON_HEIGHT = "height";

	public static int getDrawableResourceByName(Context context, String name)
	{
		return context.getResources().getIdentifier(name, "drawable", context.getPackageName());
	}

	public static Drawable getDrawableByName(Context context, String name)
	{
		int drawableResId = getDrawableResourceByName(context, name);
		if (drawableResId != 0)
		{
			return context.getResources().getDrawable(getDrawableResourceByName(context, name));
		}
		else
		{
			return null;
		}
	}

	public static ImageInfo getImageInfo(ReadableMap source)
	{
		if (source.hasKey(PROP_ICON_WIDTH) && source.hasKey(PROP_ICON_HEIGHT))
		{
			final int width = Math.round(PixelUtil.toPixelFromDIP(source.getInt(PROP_ICON_WIDTH)));
			final int height = Math.round(PixelUtil.toPixelFromDIP(source.getInt(PROP_ICON_HEIGHT)));
			return new ImageInfo(width, height);
		}
		else
		{
			return null;
		}
	}

	public static String getImageUri(ReadableMap source)
	{
		return source.getString(PROP_ICON_URI);
	}

	/**
	 * Sets an icon for a specific icon source. If the uri indicates an icon
	 * to be somewhere remote (http/https) or on the local filesystem, it uses fresco to load it.
	 * Otherwise it loads the Drawable from the Resources and directly returns it via a callback
	 */
	public static void setIconSource(Context context, String uri, ImageInfo imageInfo, ImageControllerListener controllerListener, DraweeHolder holder)
	{
		if (uri == null)
		{
			controllerListener.setIconImageInfo(null);
			controllerListener.setDrawable(null);
		}
		else if (uri.startsWith("http://") || uri.startsWith("https://") || uri.startsWith("file://"))
		{
			controllerListener.setIconImageInfo(imageInfo);
			DraweeController controller = Fresco.newDraweeControllerBuilder()
			                                    .setUri(Uri.parse(uri))
			                                    .setControllerListener(controllerListener)
			                                    .setOldController(holder.getController())
			                                    .build();
			holder.setController(controller);
			holder.getTopLevelDrawable().setVisible(true, true);
		}
		else
		{
			controllerListener.setDrawable(getDrawableByName(context, uri));
		}
	}

}
