/**
 * Controller to handle receiving push requests from client
 *
 * created by Kevin Koh Oct 22, 2019
 */
import { pushToChannel } from '../resources/PusherService'
import { Request, Response } from 'express';
import { Controller, Post } from '@overnightjs/core';
import { Logger } from '@overnightjs/logger';


@Controller('api/push')
export default class PushController {

    /**
     * Post request handler for Push.
     * 
     * Full API pathway looks like: /api/push/<channel>
     * Channel field must be URL valid, as it is in the API path
     * 
     * @param {Request} req ExpressJS Request object
     * @param {Response} res ExpressJS Response object
     */
    @Post(':channel')
    private postChannelPush(req: Request, res: Response) {
        Logger.Info(`Channel: ${req.params.channel}, Title: ${req.body.title}, Body: ${req.body.body}`)

        // Push Message title and body fields must be present. However, they can be empty.
        if (!req.body.hasOwnProperty('title') || !req.body.hasOwnProperty('body')) {
            return res.status(400).json({
                error: "Push requires title and body fields"
            });
        }
        // Async, so no need to try/catch here
        pushToChannel(req.params.channel, req.body.title, req.body.body);

        res.status(200).send()
    }

}
