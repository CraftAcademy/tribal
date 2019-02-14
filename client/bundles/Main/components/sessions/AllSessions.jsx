import 'babel-polyfill';
import React, { Component } from 'react'
import SessionCard from './SessionCard';

export class AllSessions extends Component {
	constructor(props) {
		super(props)
		this.state = {
			sessions: props.sessionlist.sessions.sessions,
			sessionType: props.sessionType,
			buttonName: "",
			showDetails: false,
			user: props.sessionlist.sessions.user,
			mysessions: props.sessionlist.sessions.mysessions
		};

		this.showPage = this.showPage.bind(this);
	}

	showPage(event) {
		document.location.href = '/sessions/' + event.target.value;
	}

	render() {
		console.log(this.state.sessions)
		let mySessions = [];
		if (this.state.mysessions) {
			this.state.mysessions.forEach(session => {
				mySessions.push(session.id)
			})
		}
		let status = this.state.sessionType
		let allSessions = this.state.sessions.map(session => {
			if (session.status === status) {
				if (mySessions.includes(session.id)) {
					return (
						<SessionCard session={session} user={this.state.user} buttonName={'Join'} showPage={this.showPage} />
					);
				} else {
					return (
						<SessionCard session={session} user={this.state.user} buttonName={'Book'} showPage={this.showPage} />
					);
				}
			}

		});

		return (
			<div className='main_container'>
				<div id={this.state.sessionType}>
					<div style={this.state.user ? {} : { display: "none" }}>
						<h1 className="capitalize">{this.state.sessionType} sessions</h1>
					</div>
					<div className='session_wrapper'>
						<div>{allSessions}</div>
					</div>
					<br />
				</div>
			</div>);
	}
}

export default AllSessions;
