import React, { Component } from 'react'
import { AccountData, ContractData, ContractForm } from 'drizzle-react-components'
import logo from '../../logo.png'

class Home extends Component {
  render() {
    var provider = this.props.accounts[0]
    var chairperson = this.props.accounts[1]
    var anyone = this.props.accounts[2]
    return (
      <main className="container">
        <div className="pure-g">
          <div className="pure-u-1-1 header">
            <img src={logo} alt="delife-logo" />

            <br/><br/>
          </div>
          
          <div className="pure-u-1-1">
            <h2>Provider</h2>
            <AccountData accountIndex="0" units="ether" precision="6" />
            <h2>Chairperson</h2>
            <AccountData accountIndex="1" units="ether" precision="6" />
            <h2>Anyone</h2>
            <AccountData accountIndex="2" units="ether" precision="6" />

            <br/><br/>
          </div>

          <div className="pure-u-1-1">
            <h2>DeVote</h2>
            <p>
              <strong>getProvider</strong>:   
              <ContractData 
                contract="DeVote" method="getProvider" />
            </p>
            <p>
              <strong>getChairperson</strong>:   
              <ContractData 
                contract="DeVote" method="getChairperson" />
            </p>
            <br/><br/>


            <h3>addVoter</h3>
            <ContractForm 
              contract="DeVote" method="addVoter"
              sendArgs={{from: provider}}
              labels={
                ['addr', 'name', 'tokens']
              } />
            <h3>allocateTokens</h3>
            <ContractForm 
              contract="DeVote" method="allocateTokens"
              sendArgs={{from: provider}}
              labels={
                ['recipient', 'amount']
              } />
            <br/><br/>
            

            <h3>Provider</h3>
            <p>
              <strong>getVoterName</strong>: 
              <ContractData 
                contract="DeVote" method="getVoterName"
                methodArgs={[provider]} />
            </p>
            <p>
              <strong>getVoterTokens</strong>: 
              <ContractData 
                contract="DeVote" method="getVoterTokens"
                methodArgs={[provider]} />
            </p>
            <p>
              <strong>getVoterParticipation</strong>: 
              <ContractData 
                contract="DeVote" method="getVoterParticipation" 
                methodArgs={[provider]} />
            </p>

            <h3>Chairperson</h3>
            <p>
              <strong>getVoterName</strong>: 
              <ContractData 
                contract="DeVote" method="getVoterName"
                methodArgs={[chairperson]} />
            </p>
            <p>
              <strong>getVoterTokens</strong>: 
              <ContractData 
                contract="DeVote" method="getVoterTokens"
                methodArgs={[chairperson]} />
            </p>
            <p>
              <strong>getVoterParticipation</strong>: 
              <ContractData 
                contract="DeVote" method="getVoterParticipation" 
                methodArgs={[chairperson]} />
            </p>

            <h3>Anyone</h3>
            <p>
              <strong>getVoterName</strong>: 
              <ContractData 
                contract="DeVote" method="getVoterName"
                methodArgs={[anyone]} />
            </p>
            <p>
              <strong>getVoterTokens</strong>: 
              <ContractData 
                contract="DeVote" method="getVoterTokens"
                methodArgs={[anyone]} />
            </p>
            <p>
              <strong>getVoterParticipation</strong>: 
              <ContractData 
                contract="DeVote" method="getVoterParticipation" 
                methodArgs={[anyone]} />
            </p>
            <br/><br/>


            <h3>getNow</h3>
              <ContractData 
                contract="DeVote" method="getNow" />
            <h3>initReferendum</h3>
            <ContractForm 
              contract="DeVote" method="initReferendum"
              sendArgs={{from: chairperson}}
              labels={
                ['topic_', 'endTime_', 'votesRequired_', 'binding']
              } />
            <h3>deployReferendum</h3>
            <ContractForm 
              contract="DeVote" method="deployReferendum"
              sendArgs={{from: chairperson}} />
            <p>
              <strong>getReferendumCount</strong>: 
              <ContractData 
                contract="DeVote" method="getReferendumCount" />
            </p>            
            <h3>setReferendumIndex</h3>
            <ContractForm 
              contract="DeVote" method="setReferendumIndex"
              sendArgs={{from: anyone}} 
              labels={
                ['index']
              } />  
            <p>
              <strong>referendumIndex</strong>: 
              <ContractData 
                contract="DeVote" method="referendumIndex" />
            </p>
            <br/><br/>


            <h3>addOption</h3>
            <ContractForm 
              contract="DeVote" method="addOption"
              sendArgs={{from: chairperson}}
              labels={
                ['option']
              } />          
            <p>
              <strong>getOptionCount</strong>: 
              <ContractData 
                contract="DeVote" method="getOptionCount" 
                methodArgs={[1]} />
            </p>
            <h3>getOptionDescription</h3>
            <ContractForm 
              contract="DeVote" method="getOptionDescription" 
              labels={
                ['referendumID','optionID']
              } />
            <h3>tallyVotesForOption</h3>
            <ContractForm 
              contract="DeVote" method="tallyVotesForOption" 
              labels={
                ['referendumID','optionID']
              } />
            <br/><br/>


            <h3>castVote</h3>
            <ContractForm 
              contract="DeVote" method="castVote" 
              labels={
                ['referendumID','optionID']
              } />
            <h3>getVoteTopic</h3>
            <ContractForm 
              contract="DeVote" method="getVoteTopic" 
              labels={
                ['referendumID']
              } />
            <h3>getVoteEndTime</h3>
            <ContractForm 
              contract="DeVote" method="getVoteEndTime" 
              labels={
                ['referendumID']
              } />
            <h3>getVotesForQuorum</h3>
            <ContractForm 
              contract="DeVote" method="getVotesForQuorum" 
              labels={
                ['referendumID']
              } />
            <h3>getVotesCasted</h3>
            <ContractForm 
              contract="DeVote" method="getVotesCasted" 
              labels={
                ['referendumID']
              } />
            <h3>getVoteBinding</h3>
            <ContractForm 
              contract="DeVote" method="getVoteBinding" 
              labels={
                ['referendumID']
              } />
            <br/><br/> 


            <h3>postComment</h3>
            <ContractForm 
              contract="DeVote" method="postComment"
              sendArgs={{from: provider}}
              labels={
                ['referendumID','comment']
              } />
            <h3>getCommentCount</h3>
            <ContractForm 
              contract="DeVote" method="getCommentCount"
              sendArgs={{from: provider}}
              labels={
                ['referendumID','commentID']
              } />              
            <h3>getComment</h3>
            <ContractForm 
              contract="DeVote" method="getComment"
              sendArgs={{from: provider}}
              labels={
                ['referendumID','commentID']
              } />
            <br/><br/>
          </div>
        </div>
      </main>
    )
  }
}

export default Home
