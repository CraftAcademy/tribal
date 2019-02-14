import React, { Component } from 'react';
const axios = require('axios')

export default class SessionCard extends Component {
	constructor(props) {
		super(props);
		this.state = {
			coach: {},
			members: props.members
		}
	}

	componentDidMount() {
		this.getUser(this.props.session.coach_id)
	}

	async getUser(id) {
		let response = await axios.get(`/users/${id}`)
		this.setState({ coach: response.data.user })
	}
	
	render() {
		return (
			<div>
				<div id={this.props.session.id} className="wrapper" key={this.props.session.id}>
					<div className='session'>
						<div id={this.props.session.id} className='session'>
							<h1 className="session_name">{this.props.session.title}</h1>
							<p>{"Coach name:" + this.state.coach.first_name}</p>
							<p>{"Participants:" + this.props.session.members_count + "/8"}</p>
							<p>{new Date(this.props.session.start_date).toLocaleString('en-GB', { h12: false })}</p>
						</div>
						<div style={this.props.buttonName ? {} : { display: "none" }} >
							<button value={this.props.session.id} onClick={this.props.showPage} className="button">{this.props.buttonName}</button>
						</div>
					</div>
				</div>
			</div >
		);
	}

}
