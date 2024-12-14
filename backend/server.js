import 'dotenv/config';
import connectDb from "./config/mongoose.connection.js";
import app from "./app.js";
import { createServer } from "http"; // Import to create HTTP server
import { WebSocketServer } from "ws"; // Import WebSocketServer
import { setWebSocketServer, performIoTAction } from "./controllers/iot.controller.js";

const port = process.env.PORT;

// Create an HTTP server
const server = createServer(app);

// Create a WebSocket server and bind it to the HTTP server
const wss = new WebSocketServer({ server });

// WebSocket connection logic
wss.on('connection', (ws) => {
    console.log('New WebSocket connection established');
  
    ws.on('message', (message) => {
        console.log(`Received message: ${message}`);
        const action = message.toString();
        performIoTAction(action); // Handle IoT action
    });
  
    ws.on('close', () => {
        console.log('WebSocket connection closed');
    });
});

// Pass WebSocket server reference to the IoT controller
setWebSocketServer(wss);

// Connect to MongoDB and start the server
connectDb()
    .then(() => {
        server.listen(port, () => {
            console.log(`Server started at http://localhost:${port}`);
            console.log(`WebSocket server running`);
        });
    })
    .catch((error) => {
        console.log("Error in connecting", error);
    });

console.log("Hello World");
