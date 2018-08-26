/*
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//version 18.05.27

pragma solidity ^0.4.20;
contract DeVote{
    
    struct Comment{
        address poster;
        string comment;
    }
    
    struct Option{
        string description;
        uint votesForThisOption;
    }
    
    struct Referendum{
        string topic;
        uint endTime; 
        uint votesRequiredForQuorum;
        uint votesCasted;
        uint optionCount;
        mapping (uint => Option) option_fromID;
        uint commentCount;
        mapping (uint => Comment) comment_fromComentID;
        mapping (address => uint) optionID_fromAddress;
        bool binding;
    }
    
    struct Voter{
        string name;
        uint tokens;
        uint participation;        
    }
    
    uint totalTokens;
    uint totalParticipation;
    uint referendumCount;

    address provider;
    address chairperson;
    
    //Referendum scratchVote;
    
    mapping (uint => Referendum) referendum_fromID;

    mapping (address => Voter) voter_fromAddress;
   
    modifier chairpersonOnly{
        require(msg.sender == chairperson);
        _;
    }
    
    modifier providerOnly{
        require (msg.sender == provider);
        _;
    }
    
    event VoteConstruction(string topic, uint endTime, uint votesRequiredForQuorum, bool binding );
    event OptionAdded(uint numOptions, string description);
    event referendumDeployed(uint referendumCount, string topic, uint endTime, uint votesRequiredForQuorum );
    event VoterAdded(address addr, string name, uint tokens);
    event tokensAllocated(address recipient, uint amount);
    event CommentPosted(uint referendumID, string comment);
    event VoteCasted(address voter, uint referendumID, uint optionID);

    
    constructor(address provider_, address chairperson_) public {
        chairperson = chairperson_;
        provider = provider_;
        referendumCount = 0;
    }


    function addVoter(address addr, string name, uint tokens) public providerOnly{
        voter_fromAddress[addr].name = name;
        voter_fromAddress[addr].tokens = tokens;
        emit VoterAdded(addr,  name,  tokens);
    }
    function allocateTokens(address recipient, uint amount) public providerOnly{
        voter_fromAddress[recipient].tokens += amount;
        emit tokensAllocated(recipient, amount);
    }
    function getProvider() public constant returns (address){
        return provider;
    }    
    function getChairperson() public constant returns (address){
        return chairperson;
    }   

    
    function getVoterName(address addr) public constant returns (string) {
        return voter_fromAddress[addr].name;
    }    
    function getVoterTokens(address addr) public constant returns (uint) {
        return voter_fromAddress[addr].tokens;
    }
    function getVoterParticipation(address addr) public constant returns (uint) {
        return voter_fromAddress[addr].participation;
    }


    function getNow() public constant returns (uint){
        return now;
    }    
    function initReferendum(string topic_ , uint endTime_, uint votesRequired_, bool binding) 
    public chairpersonOnly{        
        referendum_fromID[referendumCount].topic = topic_;
        referendum_fromID[referendumCount].endTime = endTime_;
        referendum_fromID[referendumCount].votesRequiredForQuorum = votesRequired_;
        referendum_fromID[referendumCount].votesCasted = 0;
        referendum_fromID[referendumCount].binding = binding;        
        emit VoteConstruction(
            topic_,
            endTime_,
            votesRequired_,
            binding
        );
    }
    function deployReferendum() public chairpersonOnly{
        emit referendumDeployed(
            referendumCount,
            referendum_fromID[referendumCount].topic,
            referendum_fromID[referendumCount].endTime,
            referendum_fromID[referendumCount].votesRequiredForQuorum
        );
        referendumCount += 1;
    }
    function getReferendumCount() public constant returns (uint) {
        return referendumCount;
    }
    function setReferendumIndex(uint index) public constant returns (uint) {
        return referendumCount;
    }
    uint public referendumIndex;
    

    function addOption(string option) public chairpersonOnly{
        referendum_fromID[referendumCount].option_fromID[referendum_fromID[referendumCount].optionCount] = Option(option, 0);
        referendum_fromID[referendumCount].optionCount += 1;
        emit OptionAdded(referendum_fromID[referendumCount].optionCount, option);
    }    
    function getOptionCount(uint referendumID) public constant returns (uint){
        return referendum_fromID[referendumID].optionCount;
    }
    function getOptionDescription(uint referendumID, uint optionID) public constant returns (string){
        return referendum_fromID[referendumID].option_fromID[optionID].description;
    }
    function tallyVotesForOption(uint referendumID, uint optionID)public constant returns (uint){
        referendum_fromID[referendumID].option_fromID[optionID].votesForThisOption;
    }    


    function castVote(uint referendumID, uint optionID) public {
        // Voter needs to have tokens
        require(voter_fromAddress[msg.sender].tokens > 0);
        // Election closing time needs to be in the future
        require(referendum_fromID[referendumID].endTime > now);
        
        // Increment vote count for that option
        referendum_fromID[referendumID].option_fromID[optionID].votesForThisOption += 1;
        // Record the option chosen by that voter
        referendum_fromID[referendumID].optionID_fromAddress[msg.sender] = optionID;
        //
        referendum_fromID[referendumID].votesCasted += 1;
        voter_fromAddress[msg.sender].tokens -= 1;
        voter_fromAddress[msg.sender].participation += 1;
        
        emit VoteCasted(msg.sender, referendumID, optionID);
    }
    function getVoteTopic(uint referendumID) public constant returns (string){
        return referendum_fromID[referendumID].topic;
    }    
    function getVoteEndTime(uint referendumID) public constant returns (uint){
        return referendum_fromID[referendumID].endTime; 
    }    
    function getVotesForQuorum(uint referendumID) public constant returns (uint){
        return referendum_fromID[referendumID].votesRequiredForQuorum;
    }    
    function getVotesCasted(uint referendumID) public constant returns (uint){
        return referendum_fromID[referendumID].votesCasted;
    }    
    function getVoteBinding(uint referendumID) public constant returns (bool){
        return referendum_fromID[referendumID].binding;
    }


    //TODO: restrict who can post comment_fromComentID..
    function postComment(uint referendumID, string comment) public{
        referendum_fromID[referendumID].comment_fromComentID[referendum_fromID[referendumID].commentCount] = Comment(msg.sender, comment);
        referendum_fromID[referendumID].commentCount += 1;
        emit CommentPosted(referendumID, comment);
    }
    function getCommentCount(uint referendumID) public constant returns (uint){
        return referendum_fromID[referendumID].commentCount;
    }    
    function getComment(uint referendumID, uint commentID)public constant returns (string){
        return referendum_fromID[referendumID].comment_fromComentID[commentID].comment;
    }
    
}
