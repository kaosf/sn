import consumer from "channels/consumer";

consumer.subscriptions.create("SnsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (window.location.pathname === "/sns" && data.action === "SnCreate") {
      Turbo.visit(window.location.href, { action: "replace" });
    }
  },
});
