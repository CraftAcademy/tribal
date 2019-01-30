import React from "react";

const AllSessions = props => {

	let sessionlist = props.sessionlist;

	let sessions = sessionlist.map(session => {

		return (
			<div class="wrapper">
				<div id={session.id} className='session'>
					<h1 class="session_name">{session.title}</h1>
					<p>{new Date(session.start_date).toLocaleString('en-GB', { h12: false })}</p>
					{/* <h4>{new Date(session.end_date).toLocaleString('en-GB', { h12: false })}</h4> */}
				</div>
				<button class="button">join</button>
			</div>
		);
	});
	return <div>{sessions}</div>
};

export default AllSessions;
