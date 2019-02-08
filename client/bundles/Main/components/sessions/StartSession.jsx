import React, { Component } from 'react';

export class StartSession extends Component {
	constructor(props) {
		super(props);
		this.state = {
            channel_name: props.sessions.channel_name
		};
		}

    componentDidMount() {
        let remoteContainer;
        let canvasContainer;

        let handleFail = function (err) {
            console.log("Error : ", err);
        };

        function addVideoStream(streamId) {
            let streamDiv = document.createElement("div");
            streamDiv.id = streamId;
            streamDiv.style.transform = "rotateY(180deg)";
            remoteContainer.appendChild(streamDiv);
        }

        function removeVideoStream(evt) {
            let stream = evt.stream;
            stream.stop();
            let remDiv = document.getElementById(stream.getId());
            remDiv.parentNode.removeChild(remDiv);
            console.log("Remote stream is removed " + stream.getId());
        }

        function addCanvas(streamId) {
            let canvas = document.createElement("canvas");
            canvas.id = "canvas" + streamId;
            canvasContainer.appendChild(canvas);
            let ctx = canvas.getContext("2d");
            let video = document.getElementById(`video${streamId}`);

            video.addEventListener("loadedmetadata", function () {
                canvas.width = video.videoWidth;
                canvas.height = video.videoHeight;
            });

            video.addEventListener("play", function () {
                let $this = this;
                (function loop() {
                    if (!$this.paused && !$this.ended) {
                        ctx.drawImage($this, 0, 0);
                        setTimeout(loop, 1000 / 30);
                    }
                })();
            }, 0);
        }

        let client = AgoraRTC.createClient({
            mode: "live",
            codec: "h264"
        });

        client.init("e7571501081d4ce68ec9564f6c8cd8aa", () => console.log("AgoraRTC client initialized"), handleFail);

        client.join(null, this.state.channel_name, null, (uid) => {

            let localStream = AgoraRTC.createStream({
                streamID: uid,
                audio: true,
                video: true,
                screen: false
            });

            localStream.init(function () {

                localStream.play("me");
                client.publish(localStream, handleFail);

            }, handleFail);
        }, handleFail);

        client.on("stream-added", function (evt) {
            client.subscribe(evt.stream, handleFail);
        });

        client.on("stream-subscribed", function (evt) {
            let stream = evt.stream;
            addVideoStream(stream.getId());
            stream.play(stream.getId());
            addCanvas(stream.getId());
        });

        client.on("stream-removed", removeVideoStream);
        client.on("peer-leave", removeVideoStream);
    }

	render() {
		return (
			<div className="videocall" >
				<h1 className="text-white">
                    Session Video Call
                </h1>

                <h4 className="text-white">My feed</h4>

                <div id="me">

                </div>

                <h4 className="text-white">Remote feeds</h4>

                <div id="remote-container">

                </div>

                <h4 className="text-white">Canvas feeds</h4>

                <div id="canvas-container">

                </div>
			</div>
		);
	}
}

export default StartSession;

