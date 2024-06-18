
// Imports from packages
const express = require("express");
const mongoose = require("mongoose");



// Imports from other files
const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");

const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
require('dotenv').config();


//init
const PORT = process.env.PORT || 3000;

const app = express();
const DB = process.env.MONGODB_URL;

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