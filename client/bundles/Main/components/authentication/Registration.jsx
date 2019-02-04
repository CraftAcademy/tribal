import React, { Component } from "react";
import ReactOnRails from "react-on-rails";
import RegistrationForm from "./RegistrationForm";

const axios = require("axios");

export class Registration extends Component {
	constructor(props) {
		super(props);
		this.state = {
			role: "trainee",
			first_name: "",
			last_name: "",
			email: "",
			password: "",
			password_confirmation: "",
			roleChoiceStatus: false,
			displayForm: false,
			formErrors: ""
		};
		this.onChange = this.onChange.bind(this);
		this.onSubmit = this.onSubmit.bind(this);
		this.onRoleClick = this.onRoleClick.bind(this);
		this.fbLogin = this.fbLogin.bind(this);
		this.onLoginEmailClick = this.onLoginEmailClick.bind(this);
	}

	fbLogin(){
		let role = this.state.role;
		let params = '?role=' + role;
		let authUrl = '/users/auth/facebook';
		document.location.href = authUrl + params;
	}

	onSubmit() {
		event.preventDefault();
		const csrfToken = ReactOnRails.authenticityToken();
		let registrationForm = document.getElementById("Registration-form");
		const data = new FormData(registrationForm);
		const config = {
			headers: {
				"Content-Type": "application/x-www-form-urlencoded",
				"X-CSRF-Token": csrfToken
			}
		};
		axios
			.post("/users", data, config)
			.then(response => {
				if (response.data.errors) {
					let errors = Object.entries(response.data.errors).join('\n').replace(/,|_/g, ' ');
					this.setState({
						formErrors: errors
					});
				} else {
					document.location.href = "/";
				}
			})
			.catch(function (error) {
				console.log(error);
			});
	}
	onClick(event) {
		event.preventDefault();
		this.setState({
			[event.target.id]: event.target.value
		});
	}

	onChange() {
		this.setState({
			[event.target.id]: event.target.value
		});
	}

	onRoleClick() {
		event.preventDefault();
		this.setState(prevState => ({
			roleChoiceStatus: !prevState.roleChoiceStatus,
			role: event.target.value,
		}));
	}

	onLoginEmailClick(){
		event.preventDefault();
		this.setState(prevState => ({
			displayForm: !prevState.displayForm
		}));
	}

	render() {
		return (
			<div className="main_container">
				<div style={this.state.roleChoiceStatus ? { display: "none" } : {}}>
					<h1>I am a</h1>
					<div className="content wrapper">
						<button className="button" id = "role" name="role" value= "trainee" onClick={this.onRoleClick}>
							Trainee
						</button>
						<button className="button" id = "role" name="role" value="coach" onClick={this.onRoleClick}>
							Coach
						</button>
					</div>
				</div>
				<div style={this.state.roleChoiceStatus ? {} : { display: "none" }}>
					<div className="mt-4 text-center whitespace-pre-wrap">{this.state.formErrors}</div>
						<div className="wrapper-col" style={this.state.displayForm ?  { display: "none" } : {} }>
							<button
								className="button m-4"
								onClick={this.fbLogin}
							>
								Register with Facebook
							</button>
							<button
								id = "displayForm"
								className="button m-4"
								onClick={this.onLoginEmailClick}
							>
								Register with Email
							</button>
						</div>
					<div style={this.state.displayForm ? {} : { display: "none" }}>
						<RegistrationForm
							onSubmit={this.onSubmit}
							onChange={this.onChange}
							first_name={this.state.first_name}
							last_name={this.state.last_name}
							email={this.state.email}
							password={this.state.password}
							password_confirmation={this.state.password_confirmation}
							role={this.state.role}
						/>
					</div>

				</div>
			</div>
		);
	}
}

export default Registration;
