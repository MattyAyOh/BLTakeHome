import * as PushNotifications from '@pusher/push-notifications-server';
import { Logger } from '@overnightjs/logger';

const beamsClient = new PushNotifications({
    instanceId: process.env.INSTANCE_ID,
    secretKey: process.env.SECRET_KEY
});

/**
 * Async calls beamClient to send Push Notification payload
 * 
 * @param {string} channel Interest channel to publish push
 * @param {string} title Title of push notification
 * @param {string} body Body of push notification
 */
export async function pushToChannel(channel: string, title: string, body: string) {
    let resp: PushNotifications.PublishResponse
    try {
        resp = await beamsClient.publishToInterests([channel], {
            apns: {
                aps: {
                    "alert": {
                        "title": title,
                        "body": body
                    }
                }
            }
        });
        Logger.Info(`Pusher publish success. Publish ID: ${resp.publishId}`);
    } catch (error) {
        Logger.Info(`Pusher publish error. Error msg: ${error}`);
    }
}