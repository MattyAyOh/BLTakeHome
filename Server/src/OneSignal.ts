const OneSignal = require("onesignal-node");

const oneSignalClient = new OneSignal.Client({
    app: {
        appId: "d7d16830-f584-40a7-83c3-ed1eb2932538",
        appAuthKey: "NGVmZDAyZmMtMWVlZC00YmU4LTk4MzktYjk2NDUzMzdmZDRk",
    },
});

/**
 * Async calls beamClient to send Push Notification payload
 *
 * @param {string} channel Interest channel to publish push
 * @param {string} title Title of push notification
 * @param {string} body Body of push notification
 */
export async function pushToChannel(channel: string, title: string, body: string) {
    const data = {
        contents: { en: body },
        headings: { en: title },
        ios_sound: "bingbong.aiff",
      };

    const notification = new OneSignal.Notification(data);

    notification.postBody["filters"] = [{field: "tag", key: channel, relation: "=", value: true}];

    return oneSignalClient.sendNotification(notification);
}
