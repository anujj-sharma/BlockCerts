// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract BlockCerts {
    address public admin;

    struct Certificate {
        string studentName;
        string course;
        uint256 issueDate;
        bool isValid;
    }

    mapping(address => Certificate) public certificates;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function issueCertificate(address student, string memory name, string memory course) public onlyAdmin {
        certificates[student] = Certificate(name, course, block.timestamp, true);
    }

    function revokeCertificate(address student) public onlyAdmin {
        require(certificates[student].isValid, "Certificate already revoked or doesn't exist");
        certificates[student].isValid = false;
    }

    function verifyCertificate(address student) public view returns (bool) {
        return certificates[student].isValid;
    }

    function getCertificateDetails(address student) public view returns (string memory, string memory, uint256, bool) {
        Certificate memory cert = certificates[student];
        return (cert.studentName, cert.course, cert.issueDate, cert.isValid);
    }
}
