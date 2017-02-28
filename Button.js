'use strict';

import React, {PropTypes} from "react";
import {processColor, requireNativeComponent, Platform, StyleSheet, Text, View} from 'react-native';

const ImageSourcePropType = require('ImageSourcePropType');
const resolveAssetSource = require('resolveAssetSource');

const Button = React.createClass({

	propTypes: {
		...View.propTypes,

		/**
		 * The alignment of the button image
		 */
		imageAlignment: React.PropTypes.oneOf([
			// Will be aligned to the left of the button with the title centered
			'left',
			// Will be aligned centrally with imageInsets between it and the title
			'center'
		]),

		/**
		 * The image to display along with the title on the button
		 */
		image: ImageSourcePropType,

		/**
		 * The insets for the image on the button
		 */
		imageInsets: React.PropTypes.shape({
			bottom: React.PropTypes.number,
			left: React.PropTypes.number,
			right: React.PropTypes.number,
			top: React.PropTypes.number
		}),

		/**
		 * The title of the button
		 */
		title: React.PropTypes.string.isRequired,

		/**
		 * Whether the text should be in all caps
		 */
		textAllCaps: React.PropTypes.bool,

		/**
		 * The insets for the title of the button
		 */
		titleInsets: React.PropTypes.shape({
			bottom: React.PropTypes.number,
			left: React.PropTypes.number,
			right: React.PropTypes.number,
			top: React.PropTypes.number
		}),

		/**
		 * The style of the button
		 */
		style: Text.propTypes.style,

		/**
		 * An callback when the button is pressed
		 */
		onPress: React.PropTypes.func,

		/**
		 * Whether the button is enabled
		 */
		enabled: React.PropTypes.bool,
	},

	getDefaultProps() {
		return {
			imageAlignment: 'center'
		}
	},

	/**
	 * The Android native code emits an onChange event to notify that it has been clicked
	 *
	 * @private
	 */
	_onPress() {
		this.props.onPress && this.props.onPress();
	},

	render() {

		if (Platform.OS === "android") {
			return (
				<ButtonNative {...this.props} onChange={this._onPress}/>
			);
		} else if (Platform.OS === "ios") {

			const passProps = {
				...this.props
			};

			if (passProps.image) {
				passProps.image = resolveAssetSource(passProps.image);
			}

			const flattenedStyle = StyleSheet.flatten(this.props.style);

			if (flattenedStyle) {
				if (flattenedStyle.color) {
					passProps.textColor = processColor(flattenedStyle.color);
				}
				if (flattenedStyle.backgroundColor) {
					passProps.backgroundColor = flattenedStyle.backgroundColor;
				}
				if (flattenedStyle.fontFamily) {
					passProps.fontFamily = flattenedStyle.fontFamily;
				}
				if (flattenedStyle.fontWeight) {
					passProps.fontWeight = flattenedStyle.fontWeight;
				}
			}

			if (passProps.textAllCaps && passProps.title) {
				passProps.title = passProps.title.toUpperCase();
			}

			passProps.onStartShouldSetResponder = (event) => true;
			passProps.onMoveShouldSetResponder = (event) => true;
			return (
				<ButtonNative {...passProps} onPress={this._onPress}/>
			);
		}
	}
});

if (Platform.OS === "ios") {
	var ButtonNative = requireNativeComponent('RNButton', Button, {
  		nativeOnly: { 
  			textColor: true,
  			backgroundColor: true,
  			fontFamily: true,
  			fontWeight: true 
  		}
	});
} else if (Platform.OS === "android") {
	var ButtonNative = requireNativeComponent('RNButton', Button);
}

module.exports = Button;
