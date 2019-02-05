import React from "react";
import { Route, Switch, BrowserRouter } from "react-router-dom";
import Main from "./Main";
import Registration from "./authentication/Registration";
import Login from "./authentication/Login";
import AddSession from "./sessions/AddSession";

function App(props) {
	return (
		<div>
			<BrowserRouter>
				<Switch>
					<Route exact path ='/' render={() => <Main sessions={props} />} />;
					<Route exact path ='/register' render={() => <Registration />} />;
					<Route exact path ='/login' render={() => <Login />} />;
					<Route exact path ='/addsession' render={() => <AddSession />} />;
				</Switch>
			</BrowserRouter>
		</div>
	)
}

export default App
