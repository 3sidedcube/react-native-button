'use strict';

import React, {PropTypes} from "react";
import {processColor, requireNativeComponent, Platform, StyleSheet, Text, View} from 'react-native';

const Button = React.createClass({

	propTypes: {
		...View.propTypes,
		title: React.PropTypes.string.isRequired,
		textAllCaps: React.PropTypes.bool,
		style: Text.propTypes.style,
		onPress: React.PropTypes.func,
		enabled: React.PropTypes.bool,
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

			const flattenedStyle = StyleSheet.flatten(this.props.style);

			if (flattenedStyle) {
				if (flattenedStyle.color) {
					passProps.textColor = processColor(flattenedStyle.color);
				}
				if (flattenedStyle.backgroundColor) {
					passProps.backgroundColor = processColor(flattenedStyle.backgroundColor);
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
