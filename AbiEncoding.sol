// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AbiEncodingExplained {
    function encode(string memory text) public pure returns (bytes memory) {
        return abi.encode(text);
    }

    function encodePacked(string memory text)
        public
        pure
        returns (bytes memory)
    {
        return abi.encodePacked(text);
    }

    function willCreatecollision() public pure returns (bool) {
        return
            keccak256(abi.encodePacked("AA", "ABB")) ==
            keccak256(abi.encodePacked("A", "AABB")); //true
    }

    function transfer(address recipient, uint256 amount)
        public
        pure 
        returns (string memory)
    {
        //Simple empty function
        return "You called the transfer function";
    }

    function createFunctionSelector() public pure returns (bytes4) {
        return
            bytes4(
                keccak256(
                    abi.encodePacked(
                        "transfer(address,uint256)"
                    )
                )
            ); //create function signature and take the first four bytes.
    }

    function addDataTobeCalledWithTheTransferFunction(
        address recipient,
        uint256 amount
    ) public pure returns (bytes memory) {
        return
            abi.encodeWithSelector(createFunctionSelector(), recipient, amount);
    }

    function callTransferFunctionDirectly(address recipient, uint256 amount)
        public
        returns (bool, string memory)
    {
        (bool success, bytes memory returnedDate) = address(this).call(
            (addDataTobeCalledWithTheTransferFunction(recipient,amount))
        );
        
        require(success, "Call failed");
        return (success, abi.decode(returnedDate,(string)));
    }
}


//0x6B395b38facbfe9896a98a753FC6dB1967E4c067