/**
 * Start the Express Web-Server
 * 
 * We acknowledge that this is for dev purposes only,
 * hence the env.dev file. 
 * 
 * Production should not be running through this.
 *
 * created by Kevin Koh Oct 23, 2019
 */
import { config } from 'dotenv'
import { resolve } from 'path';


// Setup environment variables found in .env.dev file
config({path: resolve(__dirname, "../.env.dev")})

// Weird quirk with Overnight/Express that requires environment vars 
// be set up before Server is imported
import ExampleServer from './ExampleServer';

// Start server, default to port 3000
const exampleServer = new ExampleServer();

exampleServer.start(Number(process.env.PORT || 3000));
