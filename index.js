const keccak256 = require("keccak256");
const signature = "transfer(address,uint256)";
const address = "0x19708648D2f76607B32CcB1240B0DfC67a222a75";
const amount = 2;

//This will create the same signature as the one we saw on Remix
const generateFunctionSelector = () => {
  const hash = keccak256(signature).toString("hex");
  return "0x" + hash.toString().slice(0, 8);
};

//The returned information can be used  direclty when making calls to the EVM
function addParameters() {
  const serializeAddress = address
    .toLowerCase()
    .replace("0x", "")
    .padStart(64, 0);

  const functionSelector = generateFunctionSelector();
  const serializeAmount = amount.toString(16).padStart(64, "0");
  const transactionData = "".concat(
    functionSelector,
    serializeAddress,
    serializeAmount
  );

  return transactionData;
}

console.log(addParameters());
