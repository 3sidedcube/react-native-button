'use strict';

import React, {PropTypes} from "react";
import { requireNativeComponent, Text, TouchableWithoutFeedback, View } from 'react-native';
var ColorPropType = require('ColorPropType');

const Button = React.createClass({

	propTypes: {
		...View.propTypes,
		...TouchableWithoutFeedback.propTypes,
		title: React.PropTypes.string,
		textColor: ColorPropType,
		style: Text.propTypes.style
	},

	render() {
		return (
			<TouchableWithoutFeedback {...this.props}>
				<ButtonAndroid {...this.props} />
			</TouchableWithoutFeedback>
		);
	}
});

var ButtonAndroid = requireNativeComponent('RNButton', Button);
module.exports = Button;
