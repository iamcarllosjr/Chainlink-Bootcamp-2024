//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;


contract RegisterAccess {
    string[] private info;
    address public owner;
    //Mapping aponta para uma key e value, onde address aponta para um booleano, chamando allowlist
    mapping(address => bool) public allowlist; 
 
    constructor() {
        owner = msg.sender;
        allowlist[msg.sender] = true;
    } 
 
    event InfoChange(string oldInfo, string newInfo); 
 
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner");
        _;
    }

    //Verificando se o endereço que está chamando a função com o onlyAllowlist é true
    modifier onlyAllowlist {
        require(allowlist[msg.sender] == true, "Only allowlist");
        _;
    } 
 
    function getInfo(uint index) public view returns (string memory) {
        return info[index];
    }
    
    //Para alterar uma info dentro do array info, passando seu index, e nova string
    //Para chamar esta função o endeço tem que estar em allowlist como true
    function changeInfo(uint index, string memory _info) public onlyAllowlist {
        emit InfoChange (info[index], _info);
        info[index] = _info;
    }
 
    function addInfo(string memory _info) public onlyAllowlist returns (uint index) {
        info.push (_info);
        index = info.length -1;
    }
   
    function listInfo() public view returns (string[] memory) {
        return info;
    }
    
    //Adicionando um novo endereço em allowlist e dizendo que ele é true
    function addMember (address _member) public onlyOwner {        
        allowlist[_member] = true;
    }
    
    //Removendo um endereço de allowlist, dizendo que ele agora é false
    function removeMember (address _member) public onlyOwner {
        allowlist[_member] = false;
    }    
}