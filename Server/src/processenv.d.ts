// Specify variables we expect in process env
declare namespace NodeJS {
    export interface ProcessEnv {
        HOST: string;
        PORT: string;
        INSTANCE_ID: string;
        SECRET_KEY: string;
    }
}