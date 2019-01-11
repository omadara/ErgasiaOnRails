//first argument are the params to send to server, 'channel' is required
App.messages = App.cable.subscriptions.create({
    channel: "ChatChannel", room: "testroom"}, {

    //called when connected to the server
    connected: function() {
        //calls a method on the channel on server
        this.perform("hiFromClient", {a:1, b:2})
    },

    //called when received data from server through broadcast
    received: function(data) {
        console.log("received data", data);
    }
});
