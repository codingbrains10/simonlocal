import dotenv from 'dotenv'
import fs from 'fs'
import path from 'path'
import process from 'process'
dotenv.config()
const ENVIROMENT = process.env.NODE_ENV;
switch(ENVIROMENT){
    case 'production' : {
        if(fs.existsSync(path.join(process.cwd(),'/.env.production'))){
            dotenv.config({ path : ".env.production"})
        }else{
            process.exit(1);
        }
        break;
    }

    case 'development' : {
        if(fs.existsSync(path.join(process.cwd(),'/.env.development'))){
            dotenv.config({path : ".env.development"})
        }else{
            console.log(`${ENVIROMENT} enviroment file not found`)
            process.exit(1)
        }
        break;
    }

    case 'local' : {
        if(fs.existsSync(path.join(process.cwd(),'/.env.local'))){
            dotenv.config({path : ".env.local"})
        }else{
            console.log(`${ENVIROMENT} enviroment file not found`)
            process.exit(1)
        }
        break;
    }

    default:{
        if(fs.existsSync(path.join(process.cwd(),'/.env.development'))){
            dotenv.config({path : ".env.development"})
        }else{
            console.log(`${ENVIROMENT} enviroment file not found`)
            process.exit(1)
        }
        break;
    }
}
  

const config = {
    APP_NAME : process.env.APP_NAME,
    PORT : process.env.PORT,
    BASE_SERVER_URL : process.env.BASE_SERVER_URL,
    API_KEY : process.env.API_KEY,
    SECRET_KEY : process.env.SECRET_KEY,
    SECRET_IV : process.env.SECRET_IV,
    DATABASE_CONFIGURATION : {
        host : process.env.DB_HOST,
        database : process.env.DB_NAME,
        user : process.env.DB_USER,
        password : process.env.DB_PASSWORD,
        connectionLimit : process.env.DB_CONNECTION_LIMIT,
        waitForConnections: process.env.DB_WAIT_FOR_CONNECTION,
        dateStrings : process.env.DB_DATE_STRING
    },
    EMAIL_CONFIGURATION : {
        AUTH : {
            user: process.env.SMTP_EMAIL,
            pass: process.env.SMTP_EMAIL_PASSWORD
        },
        SMTP_FROM_EMAIL : process.env.SMTP_FROM_EMAIL,
    },
}

export default config;


