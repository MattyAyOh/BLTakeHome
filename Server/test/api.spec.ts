/**
 * Tests the Push API functions. Stubs the Pusher call.
 * 
 * OvernightJS test setup referenced from:
 * https://levelup.gitconnected.com/setting-up-a-full-stack-typescript-application-featuring-express-and-react-ccfe07f2ea47
 * 
 * Unfortunately stubbing was not able to work yet. Running the test will call Pusher on the "test" channel.
 *
 * created by Kevin Koh Oct 24, 2019
 */
import PushController from '../src/controllers/PushController';

import * as PusherService from '../src/resources/PusherService';

import * as bodyParser from 'body-parser';
import * as supertest from 'supertest';
import * as sinon from 'sinon';

import { Application } from 'express';
import {} from 'jasmine';
import { Logger } from '@overnightjs/logger';
import { Server } from '@overnightjs/core';
import { SuperTest, Test } from 'supertest';


class TestServer extends Server {

	constructor() {
        super();
        this.app.use(bodyParser.json());
        this.app.use(bodyParser.urlencoded({extended: true}));
    }

    public setController(ctlr: object): void {
        super.addControllers(ctlr);
    }

    public getExpressInstance(): Application {
        return this.app;
	}
}


describe('PushController', () => {

	const pushController = new PushController();
    let agent: SuperTest<Test>
    let pusherStub: any;
    let mockService: any;

	beforeEach(() => {
        // Stubs don't work
        pusherStub = sinon.stub(PusherService, "pushToChannel");
        pusherStub.returns(Promise.resolve());

		const server = new TestServer();
		server.setController(pushController);
        agent = supertest.agent(server.getExpressInstance());
    })

    afterEach(() => {
        pusherStub.restore();
    })

	describe('API: "/api/push/:channel"', () => {

        const channel = 'test';

        it('should return status 400 (undefined title and body)', () => {
            agent.post('/api/push/' + channel)
                .end((err, res) => {
                    if (err) {
                        Logger.Err(err, true);
                    }
                    expect(res.status).toBe(400);
                    expect(res.body.error).toBe("Push requires title and body fields");
                });
        });
        
        it('should return status 200 (success with title and body)', () => {
            agent.post('/api/push/' + channel)
                .send({title: 'hello', body: 'test'})
                .end((err, res) => {
                    if (err) {
                        Logger.Err(err, true);
                    }
                    expect(res.status).toBe(200);
                });
        });

        it('should return status 200 (success with just title)', () => {
            agent.post('/api/push/' + channel)
                .send({title: 'hi', body: ''})
                .end((err, res) => {
                    if (err) {
                        Logger.Err(err, true);
                    }
                    expect(res.status).toBe(200);
                });
        });
	});


})