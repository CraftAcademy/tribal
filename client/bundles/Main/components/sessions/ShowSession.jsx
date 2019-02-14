import React, { Component } from 'react';
import SessionCard from './SessionCard';
import { FacebookProvider, ShareButton } from 'react-facebook';

export class ShowSession extends Component {
	constructor(props) {
		super(props);
		this.state = {
			session: props.session,
			coach: props.coach,
			members: props.members,
			user: props.user,
		};
		this.buyStripe = this.buyStripe.bind(this);
		this.joinSession = this.joinSession.bind(this);
	}

	buyStripe() {
		document.location.href = "/transactions/new" + "?sessionId=" + this.state.session.id;
	}

	joinSession() {
		document.location.href = '/startsession?sessionId=' + this.state.session.id
	}

	render() {
		const members = this.state.members.map(member => member.id)
		const coach = this.state.coach
		return (
			<div className='main_container wrapper-col' >
				<SessionCard session={this.state.session} price={this.state.priceList} />
				<div className="session">
					{"Coach: " + this.state.coach.first_name}
				</div>
				<div className="session">
					{"The number of participants: " + this.state.members.length + "/8"}
				</div>
				<p className="m-4">
					{"Price: " + this.state.session.price + "$"}
				</p>
				<div style={members.includes(this.state.user.id) ||
					coach.id === this.state.user.id ? { display: "none" } : {}}>
					<button className='button' onClick={this.buyStripe}>
						Buy Session
				</button>
					<FacebookProvider appId="254630232098889">
						<ShareButton className='button' href="https://index.hu/">
							Share
						</ShareButton>
					</FacebookProvider>
				</div>
				<div style={members.includes(this.state.user.id) ? {} : { display: "none" }}>
					<button className='button' onClick={this.joinSession} >
						Join Session
				</button>
				</div>
				<div style={coach.id === this.state.user.id ? {} : { display: "none" }}>
					<button className='button' onClick={this.joinSession} >
						Start Session
				</button>
				</div>
			</div>
		);
	}
}

export default ShowSession;

