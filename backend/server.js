import 'dotenv/config';
import connectDb from "./config/mongoose.connection.js";
import app from "./app.js";

const port = process.env.PORT
// console.log("port",port)
connectDb().then(()=>{
    app.listen(port,()=>{
        console.log(`Server started at http://localhost:${port}`)
    })
}).catch((error)=>{
    console.log("error in connecting",error)
})

// console.log("Hello World");
console.log("Hello World");