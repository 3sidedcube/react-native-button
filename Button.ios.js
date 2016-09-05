/**
 * @providesModule RNButton
 * @flow
 */
'use strict';

// RNButton.js
import React from 'react';
import { requireNativeComponent, processColor } from 'react-native';
var ColorPropType = require('ColorPropType');

class Button extends React.Component {

	_onPress(event) {

		if (!this.props.onPress) {
			return;
		}

    	this.props.onPress();
	}

	render() {
		
		var passProps = {
			onStartShouldSetResponder: (event) => true,
			onMoveShouldSetResponder: (event) => true
		}

		Object.keys(this.props).forEach(key => {

			var value = this.props[key];
			if (key === 'textColor') {
				value = processColor(value);
			}
			passProps[key] = value;
		})

		return <RNButton {...passProps} onPress={this._onPress.bind(this)} />;
	}
}

Button.propTypes = {
	title: React.PropTypes.string,
	textColor: ColorPropType,
	onPress: React.PropTypes.func
};

var RNButton = requireNativeComponent('RNButton', Button);
module.exports = Button;
