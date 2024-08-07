
// Imports from packages
const express = require("express");
const mongoose = require("mongoose");
require('dotenv').config();


// Imports from other files
const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");

const productRouter = require("./routes/product");
const userRouter = require("./routes/user");



//init
const PORT = process.env.PORT || 3000;

const app = express();
const DB = process.env.MONGODB_URL;

if (!DB) {
    throw new Error('MONGODB_URL environment variable is not defined');
}

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);



//connections

mongoose.connect(DB).then(() => {
    console.log('Connection Successful');
 }).catch((e) => {
    console.log(e);
 });



//creating an api



app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}` );
});