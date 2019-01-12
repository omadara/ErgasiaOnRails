Notification.requestPermission();

App.cable.subscriptions.create({channel: "NotificationChannel"}, {
    received: function(data) {
        new Notification(data.title, {body: data.body});
    }
});
