'use strict';

import React, {PropTypes} from "react";
import {processColor, requireNativeComponent, Platform, Text, View} from 'react-native';

const Button = React.createClass({

	propTypes: {
		...View.propTypes,
		title: React.PropTypes.string.isRequired,
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
		const props = {
			...this.props
		};

		if (this.props.style) {
			if (this.props.style.color) {
				props.textColor = Platform.OS === "ios" ? processColor(this.props.style.color) : this.props.style.color;
			}
			if (this.props.style.backgroundColor) {
				props.backgroundColor = Platform.OS === "ios" ? processColor(this.props.style.backgroundColor) : this.props.style.backgroundColor;
			}
			if (this.props.style.textAllCaps) {
				props.textAllCaps = this.props.style.textAllCaps;
			}
		}

		if (Platform.OS === "android") {
			return (
				<ButtonNative {...props} onChange={this._onPress}/>
			);
		} else if (Platform.OS === "ios") {
			props.onStartShouldSetResponder = (event) => true;
			props.onMoveShouldSetResponder = (event) => true;
			return (
				<ButtonNative {...props} onPress={this._onPress}/>
			);
		}
	}
});

var ButtonNative = null;

if (Platform.OS === "android") {
	ButtonNative = requireNativeComponent('RNButton', Button, {
		nativeOnly: {
			backgroundColor: true,
			textAllCaps: true,
			textColor: true
		}
	});
} else if (Platform.OS === "ios") {
	ButtonNative = requireNativeComponent('RNButton', Button);
}

module.exports = Button;
