import { NativeModules, Platform, ToastAndroid } from "react-native";

const { wxtip } = NativeModules;
export class WXTip {
    static showToast(message) {
        if (Platform.OS === 'ios') {
            wxnative.showToast(message)
        } else {
            ToastAndroid.show(message, 2)
        }
    }

    static showLoading() {
        wxtip.showLoading()
    }

    static dismissLoading() {
        wxtip.dismissLoading()
    }
}

