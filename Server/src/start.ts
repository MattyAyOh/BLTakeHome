/**
 * Start the Express Web-Server
 * 
 * We acknowledge that this is for dev purposes only,
 * hence the env.dev file. 
 * 
 * Production should not be running through this.
 * 
 * Test setup courtesy of:
 * https://levelup.gitconnected.com/setting-up-a-full-stack-typescript-application-featuring-express-and-react-ccfe07f2ea47
 *
 * created by Kevin Koh Oct 23, 2019
 */
import { config } from 'dotenv'
import { Logger } from '@overnightjs/logger';
import { resolve } from 'path';


// Setup environment variables found in .env.dev file
config({path: resolve(__dirname, "../../.env.dev")})

// Weird quirk with Overnight/Express that requires environment vars 
// be set up before Server is imported
import ExampleServer from './ExampleServer';

// Route here to start a dev server or test runner
if (process.argv[2] !== 'test') {

    // Start server, default to port 3000
    const exampleServer = new ExampleServer();

    exampleServer.start(Number(process.env.PORT || 3000));

} else {
    const Jasmine = require('jasmine');
    const jasmine = new Jasmine();

    jasmine.loadConfig({
        "spec_dir": "build/test",
        "spec_files": [
            "**/*.spec.js"
        ],
        "stopSpecOnExpectationFailure": false,
        "random": true
    });

    jasmine.onComplete((passed: boolean) => {
        if (passed) {
            Logger.Info('All tests have passed :)');
        } else {
            Logger.Err('At least one test has failed :(');
        }
    });

    let testPath = process.argv[3];

    if (testPath) {
        testPath = `./src/${testPath}.test.ts`;
        jasmine.execute([testPath]);
    } else {
        jasmine.execute();
    }
}
