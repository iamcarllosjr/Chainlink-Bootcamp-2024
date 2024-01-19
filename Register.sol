//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract Register {
    string info;

    function setInfo (string memory _newInfo) public {
        info = _newInfo;
    }

    function getInfo () public view returns (string memory){
        return info;
    }   
}