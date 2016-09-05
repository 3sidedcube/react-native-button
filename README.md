# react-native-button

A simple cross-platform wrapper around the native platform buttons for iOS and Android, so they can be used identically but rendered according to the platform look and feel.

In our experience combinations of ```Touchable...``` and ```Text``` do not give a fully native look and feel, and Javascript re-creations of native appearance and behaviour are unsatisfactory and unnecessary.

For our purposes a simple Javascript wrapper interface around the respective native buttons was sufficient. This supports:

* Text color
* Background color
* Font
* Text-all-caps (passed through to native on Android, performed in JS on iOS)
* Enabled / disabled state

##Installation

TODO

##Usage

```javascript
import Button from "react-native-platform-button";

...

<Button
    style={{
    	backgroundColor: "red",
    	textColor: "white",
    	fontFamily: "fontName"
    }}
    textAllCaps={true}
    title="Confirm"
    onPress={() => console.log("confirmed")}
/>
```
## Future plans
* On Android, overriding background colour whilst keeping the ripple effect. (e.g. see http://stackoverflow.com/questions/26519979/coloring-buttons-in-android-with-material-design-and-appcompat)
* More complete text / font styling options to match ```Text```.
