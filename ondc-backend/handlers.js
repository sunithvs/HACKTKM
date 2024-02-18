const ondc = require('ondc-node');// Initialize ONDC


const onSearch = async (req, res) => {
    // Use the req.body to find the result of search
    let result = await Search(req.body);    // The result should be in correct schema as per ONDC spec
    res.status(200).send(result);
}
const onInit = async (req, res) => {
    // Use the req.body to init a transaction (create transactionId)
    let result = await Init(req.body);    // The result should be in correct schema as per ONDC spec
    res.status(200).send(result);
}

// /import ondc
const instance = new ondc.ONDC({
    host: "http://localhost:5000",
    bapId: "bap.com",
    bapUri: "https://bap.com/beckn",
    bppId: "bpp.com",
    bppUri: "https://bpp.com/beckn",
    country: "IND",
    city: "std:080",
    ttl: "P1M"
});


const produt_add = async (req, res) => {
    let result = await instance.add(req.body);
    res.status(200).send(result);
}
module.exports = {
    onSearch,
    onInit
}
